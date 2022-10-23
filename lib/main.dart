import 'package:flutter/material.dart';
import 'package:money_saver/provider/customer/customer_provider.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import 'main_page.dart';
import 'pages/home_page.dart';
import 'provider/application/application.dart';
import 'provider/application/application_provider.dart';
import 'provider/settings/settings_provider.dart';
import 'provider/theme/theme_provider.dart';
import 'provider/theme/theme_status.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: _createProviders(),
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          final settingsProvider = context.watch<SettingsProvider>();
          return MaterialApp(
            theme: settingsProvider.themeStatus == ThemeStatus.light ? themeProvider.lightTheme : themeProvider.darkTheme,
            debugShowCheckedModeBanner: false,
            home: const SafeArea(
              top: false,
              child: MainPage(),
            ),
            routes: _getRoutes(),
          );
        },
      ),
    );
  }

  List<SingleChildWidget> _createProviders() {
    return [
      ChangeNotifierProvider(create: (_) => CustomerProvider()),
      ChangeNotifierProvider(create: (_) => ApplicationProvider(selectedNavigationBarPageWidget: const HomePage(), selectedNavigationBarPage: NavigationBarPage.home, status: ProgramStatus.none)),
      ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ChangeNotifierProvider(create: (_) => SettingsProvider(themeStatus: ThemeStatus.light)),
    ];
  }

  Map<String, WidgetBuilder> _getRoutes() {
    return {};
  }
}
