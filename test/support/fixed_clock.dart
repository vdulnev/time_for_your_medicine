import 'dart:async';

import 'package:clock/clock.dart';

/// The design's original anchor date — a Tuesday. Fixtures and assertions
/// across the test suite (weekday labels, "last 7 days" history, seeded
/// dose logs) are written relative to this specific day.
final DateTime fixedToday = DateTime(2026, 6, 30);

/// Runs [body] with `kToday` pinned to [fixedToday], so date-dependent
/// tests stay deterministic regardless of when they're actually run.
/// Production code never calls this — only tests that assert against
/// fixture data anchored to a specific day need it.
Future<T> withFixedToday<T>(FutureOr<T> Function() body) =>
    withClock(Clock.fixed(fixedToday), () async => await body());
