import 'package:flutter/material.dart';
import 'package:money_saver/pages/authentication/register_page.dart';
import 'package:money_saver/pages/authentication/welcome_page.dart';
import 'package:money_saver/pages/settings_page.dart';
import 'package:money_saver/provider/authentication/authentication_provider.dart';
import 'package:money_saver/provider/settings/settings_provider.dart';
import 'package:provider/provider.dart';

import 'login_page.dart';

class AuthenticationPage extends StatefulWidget {
  const AuthenticationPage({Key? key}) : super(key: key);

  @override
  State<AuthenticationPage> createState() => _AuthenticationPageState();
}

class _AuthenticationPageState extends State<AuthenticationPage> {
  @override
  Widget build(BuildContext context) {
    final SettingsProvider settingsProvider = context.watch<SettingsProvider>();
    final controller = context.watch<AuthenticationProvider>();
    final ThemeData themeData = Theme.of(context);
    return Scaffold(
      backgroundColor: themeData.colorScheme.primaryContainer,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 800),
                  height: controller.authenticationState == AuthenticationState.wellCome
                      ? MediaQuery.of(context).size.height
                      : controller.authenticationState == AuthenticationState.loginWithEmail || controller.authenticationState == AuthenticationState.loginWithPhoneNumber
                          ? MediaQuery.of(context).size.height * 0.4
                          : MediaQuery.of(context).size.height * 0.3,
                  child: const WelcomePage(),
                ),
                if (controller.authenticationState == AuthenticationState.loginWithEmail ||
                    controller.authenticationState == AuthenticationState.registerWithEmail ||
                    controller.authenticationState == AuthenticationState.loginWithPhoneNumber ||
                    controller.authenticationState == AuthenticationState.registerWithPhoneNumber)
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 800),
                        height: controller.authenticationState == AuthenticationState.loginWithEmail || controller.authenticationState == AuthenticationState.loginWithPhoneNumber
                            ? MediaQuery.of(context).size.height * 0.6
                            : 0,
                        child: const LoginPage(),
                      ),
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 800),
                        height: controller.authenticationState == AuthenticationState.registerWithEmail || controller.authenticationState == AuthenticationState.registerWithPhoneNumber
                            ? MediaQuery.of(context).size.height * 0.7
                            : 0,
                        child: const RegisterPage(),
                      ),
                    ],
                  ),
              ],
            ),
          ),
          Positioned(
            top: 24,
            right: 12,
            child: ChanceTheme(settingsProvider: settingsProvider),
          ),
        ],
      ),
    );
  }
}
