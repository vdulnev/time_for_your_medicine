import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:talker_flutter/talker_flutter.dart';

import '../../core/logging/talker.dart';

/// Debug log viewer — `talker_flutter`'s built-in [TalkerScreen], showing
/// every logged DB read/write and error for on-device troubleshooting.
/// Reached from Settings.
@RoutePage()
class LogsPage extends ConsumerWidget {
  const LogsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TalkerScreen(talker: ref.watch(talkerProvider));
  }
}
