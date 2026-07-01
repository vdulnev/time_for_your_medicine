import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../core/router/app_router.dart';
import '../../core/theme/app_colors.dart';

/// Height of the bar itself (excluding bottom safe-area inset).
const double kNavBarHeight = 62;

/// The bottom navigation bar with a floating center "add" FAB. Drives the
/// [TabsRouter] for the four tabbed destinations.
class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key, required this.tabsRouter});

  final TabsRouter tabsRouter;

  @override
  Widget build(BuildContext context) {
    final active = tabsRouter.activeIndex;
    Color tint(int index) =>
        active == index ? AppColors.primary : AppColors.muted3;
    final bottomInset = MediaQuery.of(context).padding.bottom;

    return SizedBox(
      height: kNavBarHeight + bottomInset,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            height: kNavBarHeight + bottomInset,
            padding: EdgeInsets.only(bottom: bottomInset),
            decoration: const BoxDecoration(
              color: AppColors.card,
              border: Border(top: BorderSide(color: Color(0xFFF0EEF7))),
            ),
            child: Row(
              children: [
                _NavButton(
                  icon: Icons.home_outlined,
                  color: tint(0),
                  onTap: () => tabsRouter.setActiveIndex(0),
                ),
                _NavButton(
                  icon: Icons.calendar_today_outlined,
                  color: tint(1),
                  onTap: () => tabsRouter.setActiveIndex(1),
                ),
                const Spacer(),
                _NavButton(
                  icon: Icons.medication_liquid_outlined,
                  color: tint(2),
                  onTap: () => tabsRouter.setActiveIndex(2),
                ),
                _NavButton(
                  icon: Icons.tune_rounded,
                  color: tint(3),
                  onTap: () => tabsRouter.setActiveIndex(3),
                ),
              ],
            ),
          ),
          Positioned(
            top: -18,
            left: 0,
            right: 0,
            child: Center(
              child: _AddFab(
                onTap: () => context.router.push(const AddMedicineRoute()),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _NavButton extends StatelessWidget {
  const _NavButton({
    required this.icon,
    required this.color,
    required this.onTap,
  });

  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkResponse(
        onTap: onTap,
        radius: 26,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Icon(icon, size: 24, color: color),
        ),
      ),
    );
  }
}

class _AddFab extends StatelessWidget {
  const _AddFab({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 52,
        height: 52,
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withValues(alpha: 0.6),
              blurRadius: 22,
              offset: const Offset(0, 12),
              spreadRadius: -6,
            ),
          ],
        ),
        child: const Icon(Icons.add_rounded, color: Colors.white, size: 26),
      ),
    );
  }
}
