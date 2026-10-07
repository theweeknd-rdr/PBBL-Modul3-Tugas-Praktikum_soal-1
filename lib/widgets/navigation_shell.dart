import 'package:flutter/material.dart';

import '../pages/halaman_utama.dart';

class NavigationShell extends StatelessWidget {
  const NavigationShell({
    super.key,
    required this.currentIndex,
    required this.title,
    required this.onDestinationSelected,
    required this.child,
  });

  final int currentIndex;
  final String title;
  final ValueChanged<int> onDestinationSelected;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final wide = MediaQuery.sizeOf(context).width >= 800;

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      drawer: wide ? null : _NavigationDrawer(
        currentIndex: currentIndex,
        onDestinationSelected: onDestinationSelected,
      ),
      body: Row(
        children: [
          if (wide)
            NavigationRail(
              selectedIndex: currentIndex,
              onDestinationSelected: onDestinationSelected,
              labelType: NavigationRailLabelType.all,
              destinations: const [
                NavigationRailDestination(
                  icon: Icon(Icons.home_outlined),
                  selectedIcon: Icon(Icons.home),
                  label: Text('Beranda'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.miscellaneous_services_outlined),
                  selectedIcon: Icon(Icons.miscellaneous_services),
                  label: Text('Layanan'),
                ),
                NavigationRailDestination(
                  icon: PengajuanBadgeIcon(icon: Icons.person_outline),
                  selectedIcon: PengajuanBadgeIcon(icon: Icons.person),
                  label: Text('Warga'),
                ),
              ],
            ),
          if (wide) const VerticalDivider(width: 1),
          Expanded(child: child),
        ],
      ),
      bottomNavigationBar: wide
          ? null
          : NavigationBar(
              selectedIndex: currentIndex,
              onDestinationSelected: onDestinationSelected,
              destinations: const [
                NavigationDestination(
                  icon: Icon(Icons.home_outlined),
                  selectedIcon: Icon(Icons.home),
                  label: 'Beranda',
                ),
                NavigationDestination(
                  icon: Icon(Icons.miscellaneous_services_outlined),
                  selectedIcon: Icon(Icons.miscellaneous_services),
                  label: 'Layanan',
                ),
                NavigationDestination(
                  icon: PengajuanBadgeIcon(icon: Icons.person_outline),
                  selectedIcon: PengajuanBadgeIcon(icon: Icons.person),
                  label: 'Warga',
                ),
              ],
            ),
    );
  }
}

class _NavigationDrawer extends StatelessWidget {
  const _NavigationDrawer({
    required this.currentIndex,
    required this.onDestinationSelected,
  });

  final int currentIndex;
  final ValueChanged<int> onDestinationSelected;

  @override
  Widget build(BuildContext context) {
    return NavigationDrawer(
      selectedIndex: currentIndex,
      onDestinationSelected: (index) {
        Navigator.pop(context);
        onDestinationSelected(index);
      },
      children: const [
        Padding(
          padding: EdgeInsets.fromLTRB(28, 28, 16, 16),
          child: Text(
            'Nusantara Cerdas Mobile',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        NavigationDrawerDestination(
          icon: Icon(Icons.home_outlined),
          selectedIcon: Icon(Icons.home),
          label: Text('Beranda'),
        ),
        NavigationDrawerDestination(
          icon: Icon(Icons.miscellaneous_services_outlined),
          selectedIcon: Icon(Icons.miscellaneous_services),
          label: Text('Layanan'),
        ),
        NavigationDrawerDestination(
          icon: PengajuanBadgeIcon(icon: Icons.person_outline),
          selectedIcon: PengajuanBadgeIcon(icon: Icons.person),
          label: Text('Warga'),
        ),
      ],
    );
  }
}
