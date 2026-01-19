import 'package:flutter/material.dart';
import 'package:focus_quest/core/theme/app_colors.dart';
import 'package:go_router/go_router.dart';

class ScaffoldWithNavBar extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const ScaffoldWithNavBar({
    required this.navigationShell,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: NavigationBar(
          selectedIndex: navigationShell.currentIndex,
          onDestinationSelected: (index) {
            navigationShell.goBranch(
              index,
              initialLocation: index == navigationShell.currentIndex,
            );
          },
          backgroundColor: Colors.white,
          indicatorColor: AppColors.calmBlue.withOpacity(0.2),
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.spa_outlined),
              selectedIcon: Icon(Icons.spa, color: AppColors.calmBlue),
              label: 'Focus',
            ),
            NavigationDestination(
              icon: Icon(Icons.book_outlined),
              selectedIcon: Icon(Icons.book, color: AppColors.calmBlue),
              label: 'Diario',
            ),
          ],
        ),
      ),
    );
  }
}
