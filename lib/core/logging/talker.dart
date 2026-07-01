import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:talker_flutter/talker_flutter.dart';

/// The single [Talker] instance for the app. Overridden in `main()` with the
/// instance created before `runApp` (so early errors are captured too).
final talkerProvider = Provider<Talker>(
  (ref) => throw UnimplementedError('talkerProvider not overridden'),
);
