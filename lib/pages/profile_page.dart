import 'package:flutter/material.dart';
import 'package:money_saver/pages/users_page.dart';
import 'package:provider/provider.dart';

import '../provider/settings/settings_provider.dart';
import 'settings_page.dart';
import 'user_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 8),
      child: SingleChildScrollView(
        child: Column(
          children: [
            InkWell(
              onTap: () async {
                final settingsProvider = context.read<SettingsProvider>();
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => SettingsPage(
                      settingsProvider: settingsProvider,
                    ),
                  ),
                );
              },
              child: Container(
                width: double.maxFinite,
                padding: const EdgeInsets.only(left: 8, right: 8, top: 4, bottom: 4),
                decoration: BoxDecoration(
                  color: themeData.colorScheme.onPrimaryContainer,
                  border: Border.all(
                    color: themeData.colorScheme.secondaryContainer,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.settings,
                          color: themeData.iconTheme.color,
                          size: themeData.iconTheme.size,
                        ),
                        const SizedBox(width: 6.0),
                        Text(
                          'Settings',
                          style: themeData.textTheme.bodyLarge,
                        ),
                      ],
                    ),
                    Icon(
                      Icons.arrow_right_rounded,
                      color: themeData.iconTheme.color,
                      size: themeData.iconTheme.size,
                    ),
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () async {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const UsersPage(),
                  ),
                );
              },
              child: Container(
                width: double.maxFinite,
                padding: const EdgeInsets.only(left: 8, right: 8, top: 4, bottom: 4),
                decoration: BoxDecoration(
                  color: themeData.colorScheme.onPrimaryContainer,
                  border: Border.all(
                    color: themeData.colorScheme.secondaryContainer,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.settings,
                          color: themeData.iconTheme.color,
                          size: themeData.iconTheme.size,
                        ),
                        const SizedBox(width: 6.0),
                        Text(
                          'Users',
                          style: themeData.textTheme.bodyLarge,
                        ),
                      ],
                    ),
                    Icon(
                      Icons.arrow_right_rounded,
                      color: themeData.iconTheme.color,
                      size: themeData.iconTheme.size,
                    ),
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () async {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const UserPage(),
                  ),
                );
              },
              child: Container(
                width: double.maxFinite,
                padding: const EdgeInsets.only(left: 8, right: 8, top: 4, bottom: 4),
                decoration: BoxDecoration(
                  color: themeData.colorScheme.onPrimaryContainer,
                  border: Border.all(
                    color: themeData.colorScheme.secondaryContainer,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.settings,
                          color: themeData.iconTheme.color,
                          size: themeData.iconTheme.size,
                        ),
                        const SizedBox(width: 6.0),
                        Text(
                          'User',
                          style: themeData.textTheme.bodyLarge,
                        ),
                      ],
                    ),
                    Icon(
                      Icons.arrow_right_rounded,
                      color: themeData.iconTheme.color,
                      size: themeData.iconTheme.size,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
