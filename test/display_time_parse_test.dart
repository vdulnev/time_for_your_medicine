import 'package:flutter_test/flutter_test.dart';
import 'package:time_for_your_medicine/core/util/day_utils.dart';

/// `DoseTime.time` is free text, so the parser has to accept the two
/// formats the app itself suggests (en "8:00 AM", uk 24-hour "08:00") and
/// reject everything else — callers fall back to the period default.
void main() {
  test('parses 12-hour AM/PM display times', () {
    expect(DayUtils.parseDisplayTime('8:00 AM'), (8, 0));
    expect(DayUtils.parseDisplayTime('1:00 PM'), (13, 0));
    expect(DayUtils.parseDisplayTime('9:30 pm'), (21, 30));
    expect(DayUtils.parseDisplayTime(' 11:45 am '), (11, 45));
  });

  test('parses 24-hour display times', () {
    expect(DayUtils.parseDisplayTime('08:00'), (8, 0));
    expect(DayUtils.parseDisplayTime('23:15'), (23, 15));
    expect(DayUtils.parseDisplayTime('0:05'), (0, 5));
  });

  test('12 AM is midnight and 12 PM is noon', () {
    expect(DayUtils.parseDisplayTime('12:00 AM'), (0, 0));
    expect(DayUtils.parseDisplayTime('12:00 PM'), (12, 0));
  });

  test('rejects out-of-range and free-text values', () {
    expect(DayUtils.parseDisplayTime('25:00'), isNull);
    expect(DayUtils.parseDisplayTime('8:75 AM'), isNull);
    expect(DayUtils.parseDisplayTime('13:00 PM'), isNull);
    expect(DayUtils.parseDisplayTime('0:30 AM'), isNull);
    expect(DayUtils.parseDisplayTime('morning'), isNull);
    expect(DayUtils.parseDisplayTime('after breakfast'), isNull);
    expect(DayUtils.parseDisplayTime(''), isNull);
  });
}
