import 'package:flutter/material.dart';

import '../provider/settings/settings_provider.dart';
import '../provider/theme/theme_status.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key, required this.settingsProvider}) : super(key: key);
  final SettingsProvider settingsProvider;
  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    bool isLightTheme = widget.settingsProvider.themeStatus == ThemeStatus.light ? true : false;
    final themeData = Theme.of(context);
    return Scaffold(
      backgroundColor: themeData.colorScheme.primaryContainer,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.arrow_back,
            color: themeData.iconTheme.color,
            size: themeData.iconTheme.size,
          ),
        ),
        centerTitle: true,
        title: Text(
          'Settings',
          style: themeData.appBarTheme.titleTextStyle,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 8, bottom: 8),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
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
                    Text(
                      'Theme Mode :',
                      style: themeData.textTheme.bodySmall,
                    ),
                    Row(
                      children: [
                        isLightTheme
                            ? Text(
                                'Light',
                                style: themeData.textTheme.bodySmall,
                              )
                            : Text(
                                'Night',
                                style: themeData.textTheme.bodySmall,
                              ),
                        const SizedBox(width: 6.0),
                        Switch.adaptive(
                          value: isLightTheme,
                          activeColor: themeData.colorScheme.primary,
                          onChanged: (value) {
                            setState(
                              () {
                                isLightTheme = value;
                                if (isLightTheme) {
                                  widget.settingsProvider.setThemeStatus(ThemeStatus.light);
                                } else {
                                  widget.settingsProvider.setThemeStatus(ThemeStatus.dark);
                                }
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
