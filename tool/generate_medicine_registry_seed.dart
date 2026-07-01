import 'dart:convert';
import 'dart:io';
import 'dart:math';

Future<void> main(List<String> arguments) async {
  final source = File(arguments.isEmpty ? 'reestr.csv' : arguments.first);
  if (!source.existsSync()) {
    stderr.writeln('Registry file not found: ${source.path}');
    exitCode = 1;
    return;
  }

  final rows = await _parse(source.openRead());
  final compact = StringBuffer()
    ..writeln(
      '"ID";"Торгівельне найменування";'
      '"Міжнародне непатентоване найменування";"Форма випуску"',
    );
  for (var index = 0; index < rows.length; index++) {
    final row = rows[index];
    compact.writeln(
      '${_quote(index.toString())};${_quote(row.$1)};'
      '${_quote(row.$2)};${_quote(row.$3)}',
    );
  }

  final encoded = base64.encode(gzip.encode(utf8.encode(compact.toString())));
  final output = File('lib/core/data/medicine_registry_seed.dart');
  final sink = output.openWrite()
    ..writeln('// GENERATED CODE - DO NOT MODIFY BY HAND')
    ..writeln(
      '// Generated from ${source.path}; ${rows.length} unique entries.',
    )
    ..writeln("const String medicineRegistrySeedSource = 'reestr.csv';")
    ..writeln(
      "const String medicineRegistrySeedGeneratedAt = '2026-07-01T00:00:00Z';",
    )
    ..writeln("const String medicineRegistrySeedBase64 = ''; ");
  await sink.close();

  final lines = <String>[];
  for (var start = 0; start < encoded.length; start += 100) {
    final end = min(start + 100, encoded.length);
    lines.add("  '${encoded.substring(start, end)}'");
  }
  var text = await output.readAsString();
  text = text.replaceFirst(
    "const String medicineRegistrySeedBase64 = ''; ",
    ['const String medicineRegistrySeedBase64 =', ...lines, ';'].join('\n'),
  );
  await output.writeAsString(text);
  stdout.writeln('Generated ${output.path} with ${rows.length} entries.');
}

String _quote(String value) => '"${value.replaceAll('"', '""')}"';

Future<List<(String, String, String)>> _parse(Stream<List<int>> bytes) async {
  final text = await utf8.decoder.bind(bytes).join();
  final rows = <List<String>>[];
  var row = <String>[];
  final field = StringBuffer();
  var quoted = false;
  for (var index = 0; index < text.length; index++) {
    final char = text[index];
    if (quoted) {
      if (char == '"') {
        if (index + 1 < text.length && text[index + 1] == '"') {
          field.write('"');
          index++;
        } else {
          quoted = false;
        }
      } else {
        field.write(char);
      }
    } else if (char == '"' && field.isEmpty) {
      quoted = true;
    } else if (char == ';') {
      row.add(field.toString().trim());
      field.clear();
    } else if (char == '\n' || char == '\r') {
      if (char == '\r' && index + 1 < text.length && text[index + 1] == '\n') {
        index++;
      }
      row.add(field.toString().trim());
      field.clear();
      rows.add(row);
      row = <String>[];
    } else {
      field.write(char);
    }
  }
  if (field.isNotEmpty || row.isNotEmpty) {
    row.add(field.toString().trim());
    rows.add(row);
  }

  final unique = <String, (String, String, String)>{};
  for (final values in rows.skip(1)) {
    if (values.length < 4 || values[1].isEmpty) continue;
    final item = (values[1], values[2], values[3]);
    unique['${item.$1}\u0000${item.$2}\u0000${item.$3}'] = item;
  }
  return unique.values.toList();
}
