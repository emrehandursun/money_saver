import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/settings/settings_provider.dart';
import '../provider/theme/theme_status.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  bool isLightTheme = true;
  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final settingsProvider = context.read<SettingsProvider>();
    return Scaffold(
      backgroundColor: themeData.colorScheme.primaryContainer,
      appBar: AppBar(
        title: Text(
          'Money Saver',
          style: themeData.appBarTheme.titleTextStyle,
        ),
        backgroundColor: themeData.appBarTheme.backgroundColor,
        actions: [
          Switch.adaptive(
            value: isLightTheme,
            activeColor: themeData.colorScheme.primary,
            onChanged: (value) {
              setState(
                () {
                  isLightTheme = value;
                  if (isLightTheme) {
                    settingsProvider.setThemeStatus(ThemeStatus.light);
                  } else {
                    settingsProvider.setThemeStatus(ThemeStatus.dark);
                  }
                },
              );
            },
          ),
        ],
      ),
      body: Center(
        child: settingsProvider.themeStatus == ThemeStatus.light
            ? Text(
                'Light',
                style: themeData.textTheme.bodyLarge,
              )
            : Text(
                'Dark',
                style: themeData.textTheme.bodyLarge,
              ),
      ),
    );
  }
}
