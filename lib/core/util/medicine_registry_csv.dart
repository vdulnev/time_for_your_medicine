import 'dart:convert';
import 'dart:typed_data';

import '../models/medicine_registry.dart';

const String _tradeNameHeader = 'Торгівельне найменування';
const String _genericNameHeader = 'Міжнародне непатентоване найменування';
const String _formHeader = 'Форма випуску';

/// Parses the first four columns of the official semicolon-separated registry.
/// Quoted delimiters, escaped quotes, CRLF, and multiline fields are supported.
Future<List<MedicineRegistryItem>> parseMedicineRegistryCsv(
  Stream<List<int>> bytes,
) async {
  final parser = _RegistryCsvParser();
  await for (final chunk in bytes.transform(utf8.decoder)) {
    parser.add(chunk);
  }
  return parser.close();
}

Future<List<MedicineRegistryItem>> parseMedicineRegistryBytes(Uint8List bytes) {
  return parseMedicineRegistryCsv(Stream<List<int>>.value(bytes));
}

class _RegistryCsvParser {
  final List<MedicineRegistryItem> _items = [];
  final Set<String> _seen = {};
  final List<String> _row = [];
  final StringBuffer _field = StringBuffer();

  var _column = 0;
  var _inQuotes = false;
  var _afterQuote = false;
  var _skipLineFeed = false;
  var _headerRead = false;

  void add(String text) {
    for (final rune in text.runes) {
      final char = String.fromCharCode(rune);
      if (_skipLineFeed) {
        _skipLineFeed = false;
        if (char == '\n') continue;
      }

      if (_inQuotes) {
        if (char == '"') {
          _inQuotes = false;
          _afterQuote = true;
        } else if (_column < 4) {
          _field.write(char);
        }
        continue;
      }

      if (_afterQuote) {
        if (char == '"') {
          if (_column < 4) _field.write(char);
          _inQuotes = true;
          _afterQuote = false;
          continue;
        }
        _afterQuote = false;
      }

      if (char == '"' && _field.isEmpty) {
        _inQuotes = true;
      } else if (char == ';') {
        _finishField();
      } else if (char == '\n' || char == '\r') {
        _finishField();
        _finishRow();
        _skipLineFeed = char == '\r';
      } else if (_column < 4) {
        _field.write(char);
      }
    }
  }

  List<MedicineRegistryItem> close() {
    if (_inQuotes) {
      throw const FormatException('Unclosed quoted CSV field');
    }
    if (_field.isNotEmpty || _row.isNotEmpty || _column > 0) {
      _finishField();
      _finishRow();
    }
    if (!_headerRead) throw const FormatException('CSV file is empty');
    if (_items.isEmpty) {
      throw const FormatException('CSV contains no medicine entries');
    }
    return List.unmodifiable(_items);
  }

  void _finishField() {
    if (_column < 4) _row.add(_field.toString().trim());
    _field.clear();
    _column++;
  }

  void _finishRow() {
    _column = 0;
    if (_row.every((value) => value.isEmpty)) {
      _row.clear();
      return;
    }
    if (!_headerRead) {
      _validateHeader();
      _headerRead = true;
      _row.clear();
      return;
    }
    if (_row.length < 4 || _row[1].isEmpty) {
      _row.clear();
      return;
    }
    final item = MedicineRegistryItem(
      name: _row[1],
      genericName: _row[2],
      form: _row[3],
    );
    final key = '${item.name}\u0000${item.genericName}\u0000${item.form}';
    if (_seen.add(key)) _items.add(item);
    _row.clear();
  }

  void _validateHeader() {
    if (_row.length < 4) {
      throw const FormatException('CSV header has fewer than four columns');
    }
    _row[0] = _row[0].replaceFirst('\uFEFF', '');
    if (_row[1] != _tradeNameHeader ||
        _row[2] != _genericNameHeader ||
        _row[3] != _formHeader) {
      throw const FormatException('Unsupported medicine registry columns');
    }
  }
}
