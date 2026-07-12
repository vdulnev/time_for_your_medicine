import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/models/pill_kind.dart';
import '../../core/router/app_router.dart';
import '../../core/state/providers.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/widgets/pill_shape.dart';
import '../../l10n/l10n_extensions.dart';

/// The animated launch screen: brand mark + name, shown while the initial
/// data load and the one-time medicine-registry import (see
/// `medicineRegistryProvider`) run in the background, then replaced by
/// `DashboardRoute`. Styled after `DonePage`'s full-bleed primary
/// background + pop-in badge, so the two "moments" screens share a look.
@RoutePage()
class SplashPage extends ConsumerStatefulWidget {
  const SplashPage({super.key});

  @override
  ConsumerState<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends ConsumerState<SplashPage>
    with TickerProviderStateMixin {
  late final AnimationController _entrance = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1100),
  )..forward();

  /// A slow, subtle breathing scale on the logo once it's popped in — kept
  /// running for as long as the splash is visible, since load time varies.
  late final AnimationController _pulse = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1400),
  )..repeat(reverse: true);

  late final Animation<double> _logoScale = CurvedAnimation(
    parent: _entrance,
    curve: const Interval(0.0, 0.55, curve: Curves.easeOutBack),
  );
  late final Animation<double> _logoFade = CurvedAnimation(
    parent: _entrance,
    curve: const Interval(0.0, 0.4, curve: Curves.easeOut),
  );
  late final Animation<double> _titleFade = CurvedAnimation(
    parent: _entrance,
    curve: const Interval(0.35, 0.7, curve: Curves.easeOut),
  );
  late final Animation<Offset> _titleSlide = Tween(
    begin: const Offset(0, 0.2),
    end: Offset.zero,
  ).animate(_titleFade);
  late final Animation<double> _subtitleFade = CurvedAnimation(
    parent: _entrance,
    curve: const Interval(0.55, 0.85, curve: Curves.easeOut),
  );
  late final Animation<double> _loaderFade = CurvedAnimation(
    parent: _entrance,
    curve: const Interval(0.75, 1.0, curve: Curves.easeOut),
  );

  @override
  void initState() {
    super.initState();
    _bootstrap();
  }

  /// Waits for both the real data load and a minimum splash duration, so
  /// the animation always plays out in full even when the DB responds
  /// instantly — then hands off to the dashboard. Failures aren't handled
  /// here: `Home` and `Settings` already show their own `ErrorView` with
  /// retry once the underlying providers land on `AsyncError`.
  Future<void> _bootstrap() async {
    final minShow = Future<void>.delayed(const Duration(milliseconds: 1400));
    await Future.wait([
      _loadSafely(),
      _loadRegistrySafely(),
      _initNotificationsSafely(),
      minShow,
    ]);
    if (!mounted) return;
    context.router.replace(const DashboardRoute());
  }

  Future<void> _loadSafely() async {
    try {
      await ref.read(dataProvider.future);
    } catch (_) {
      // Ignored here — Home surfaces the failure itself.
    }
  }

  Future<void> _loadRegistrySafely() async {
    try {
      await ref.read(medicineRegistryProvider.future);
    } catch (_) {
      // Ignored here — Settings surfaces the failure itself.
    }
  }

  /// Brings the OS notification schedule up to date with the loaded data
  /// (and triggers the permission prompt on first launch). Failures are
  /// already logged inside the service; notifications degrading must not
  /// strand the splash.
  Future<void> _initNotificationsSafely() async {
    try {
      final data = await ref.read(dataProvider.future);
      final service = ref.read(notificationServiceProvider);
      await service.init();
      await service.sync(data);
    } catch (_) {
      // Ignored — the app works without notifications.
    }
  }

  @override
  void dispose() {
    _entrance.dispose();
    _pulse.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: AppColors.primary,
        body: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedBuilder(
                  animation: Listenable.merge([_entrance, _pulse]),
                  builder: (context, child) {
                    final breathe = 1 + (_pulse.value * 0.04);
                    return Opacity(
                      opacity: _logoFade.value,
                      child: Transform.scale(
                        scale: _logoScale.value * breathe,
                        child: child,
                      ),
                    );
                  },
                  child: const _SplashLogo(),
                ),
                const SizedBox(height: 24),
                SlideTransition(
                  position: _titleSlide,
                  child: FadeTransition(
                    opacity: _titleFade,
                    child: Text(
                      l10n.appTitle,
                      style: AppText.bricolage(size: 30, color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                FadeTransition(
                  opacity: _subtitleFade,
                  child: Text(
                    l10n.splashTagline,
                    style: AppText.jakarta(
                      size: 13,
                      color: Colors.white.withValues(alpha: 0.8),
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                FadeTransition(
                  opacity: _loaderFade,
                  child: const _SplashLoader(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SplashLogo extends StatelessWidget {
  const _SplashLogo();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 108,
      height: 108,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.18),
        shape: BoxShape.circle,
      ),
      child: Container(
        width: 78,
        height: 78,
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
        ),
        child: const PillShape(
          kind: PillKind.capsule,
          c1: AppColors.primary,
          c2: AppColors.primarySoft,
          capsuleWidth: 44,
          capsuleHeight: 22,
          capsuleRadius: 11,
          roundSize: 0,
        ),
      ),
    );
  }
}

/// Three dots pulsing in a left-to-right wave — a lightweight "still
/// working" signal under the brand mark while providers load.
class _SplashLoader extends StatefulWidget {
  const _SplashLoader();

  @override
  State<_SplashLoader> createState() => _SplashLoaderState();
}

class _SplashLoaderState extends State<_SplashLoader>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1000),
  )..repeat();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            for (var i = 0; i < 3; i++) ...[
              if (i > 0) const SizedBox(width: 6),
              _SplashDot(t: _controller.value, phase: i * 0.2),
            ],
          ],
        );
      },
    );
  }
}

class _SplashDot extends StatelessWidget {
  const _SplashDot({required this.t, required this.phase});

  /// The loader's animation clock, 0..1.
  final double t;

  /// This dot's offset into the wave, 0..1.
  final double phase;

  @override
  Widget build(BuildContext context) {
    final local = ((t - phase) % 1.0 + 1.0) % 1.0;
    final bump = (1 - (local * 2 - 1).abs()).clamp(0.0, 1.0);
    return Opacity(
      opacity: 0.35 + bump * 0.65,
      child: Container(
        width: 7,
        height: 7,
        decoration: const BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
