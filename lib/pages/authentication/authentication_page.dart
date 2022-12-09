import 'package:flutter/material.dart';
import 'package:money_saver/pages/authentication/register_page.dart';
import 'package:money_saver/pages/authentication/wellcome_page.dart';
import 'package:money_saver/provider/authentication/authentication_provider.dart';
import 'package:provider/provider.dart';

import 'login_page.dart';

class AuthenticationPage extends StatefulWidget {
  const AuthenticationPage({Key? key}) : super(key: key);

  @override
  State<AuthenticationPage> createState() => _AuthenticationPageState();
}

class _AuthenticationPageState extends State<AuthenticationPage> {
  bool isLoggingMode = true;
  @override
  Widget build(BuildContext context) {
    final controller = context.watch<AuthenticationProvider>();
    final ThemeData themeData = Theme.of(context);
    return Scaffold(
      backgroundColor: themeData.colorScheme.primaryContainer,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                AnimatedContainer(
                  duration: const Duration(seconds: 1),
                  height: controller.authenticationState == AuthenticationState.wellCome ? MediaQuery.of(context).size.height : 100,
                  child: const WellcomePage(),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AnimatedContainer(
                      duration: const Duration(seconds: 1),
                      height: controller.authenticationState == AuthenticationState.login ? MediaQuery.of(context).size.height - 200 : 0,
                      child: const LoginPage(),
                    ),
                    AnimatedContainer(
                      duration: const Duration(seconds: 1),
                      height: controller.authenticationState == AuthenticationState.register ? MediaQuery.of(context).size.height - 200 : 0,
                      child: const RegisterPage(),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
