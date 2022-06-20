import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/application/application.dart';
import '../provider/application/application_provider.dart';

class MainNavigationBar extends StatefulWidget {
  const MainNavigationBar({
    Key? key,
  }) : super(key: key);

  @override
  State<MainNavigationBar> createState() => _MainNavigationBarState();
}

class _MainNavigationBarState extends State<MainNavigationBar> {
  NavigationBarPage _selectedPage = NavigationBarPage.home;

  @override
  void didChangeDependencies() {
    _selectedPage = context.read<ApplicationProvider>().selectedNavigationBarPage;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    return BottomNavigationBar(
      elevation: 0,
      items: [
        BottomNavigationBarItem(
          icon: _buildNavigationBarItemIcon(
            themeData: themeData,
            title: 'Home',
            page: NavigationBarPage.home,
            icon: Icons.home,
          ),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: _buildNavigationBarItemIcon(
            themeData: themeData,
            title: 'Profile',
            page: NavigationBarPage.profile,
            icon: Icons.person,
          ),
          label: 'Profile',
        ),
      ],
      currentIndex: _selectedPage.index,
      onTap: (index) {
        final selectedPage = NavigationBarPage.values[index];
        if (selectedPage != _selectedPage) {
          setState(() {
            _selectedPage = NavigationBarPage.values[index];
            context.read<ApplicationProvider>().setNavigationBarPage(_selectedPage);
          });
        }
      },
      selectedItemColor: themeData.colorScheme.primary,
      unselectedItemColor: themeData.colorScheme.outline,
      selectedLabelStyle: const TextStyle(height: 0),
      unselectedLabelStyle: const TextStyle(height: 0),
      selectedFontSize: 0,
      unselectedFontSize: 0,
      showUnselectedLabels: false,
      backgroundColor: Colors.transparent,
      type: BottomNavigationBarType.fixed,
      showSelectedLabels: false,
    );
  }

  Widget _buildNavigationBarItemIcon({
    required ThemeData themeData,
    required String title,
    required NavigationBarPage page,
    required IconData icon,
  }) {
    return Container(
      color: themeData.colorScheme.onPrimaryContainer,
      child: Column(
        children: [
          Container(
            height: 3,
            color: _selectedPage == page ? themeData.colorScheme.primary : themeData.colorScheme.onPrimaryContainer,
          ),
          const SizedBox(height: 4.0),
          Icon(
            icon,
            size: 24.0,
            color: _selectedPage == page ? themeData.colorScheme.primary : themeData.colorScheme.primary.withOpacity(0.5),
          ),
          const SizedBox(height: 2.0),
          Text(
            title,
            style: themeData.textTheme.headline6?.copyWith(
              fontWeight: FontWeight.normal,
              fontSize: 11.0,
              height: 1.65,
              color: _selectedPage == page ? themeData.colorScheme.primary : themeData.colorScheme.primary.withOpacity(0.5),
            ),
          ),
          const SizedBox(height: 2.0),
        ],
      ),
    );
  }
}
