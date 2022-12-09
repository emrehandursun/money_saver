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
    /* return Scaffold(
      backgroundColor: themeData.colorScheme.primaryContainer,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                const SizedBox(height: 40),
                Text(
                  isLoggingMode ? 'Login Form' : 'Register Form',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: themeData.colorScheme.primary,
                  ),
                ),
                const SizedBox(height: 40),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(
                          color: themeData.colorScheme.primary.withOpacity(0.2),
                          width: 2,
                        ),
                        color: themeData.colorScheme.onPrimaryContainer,
                      ),
                      child: isLoggingMode ? const LoginForm() : const RegisterForm(),
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          isLoggingMode = !isLoggingMode;
                        });
                      },
                      child: Text(isLoggingMode ? 'Don\'t have an account? Register here' : 'Already have an account? Login here'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    ); */
    return Scaffold(
      backgroundColor: themeData.colorScheme.primaryContainer,
      body: SafeArea(
        bottom: false,
        child: AnimatedBuilder(
          animation: controller,
          builder: (context, child) {
            return LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                return Stack(
                  children: [
                    AnimatedPositioned(
                      duration: const Duration(milliseconds: 500),
                      left: 0,
                      right: 0,
                      top: 20,
                      height: controller.authenticationState == AuthenticationState.wellCome ? MediaQuery.of(context).size.height : 100,
                      child: const WellcomePage(),
                    ),
                    AnimatedPositioned(
                      duration: const Duration(milliseconds: 500),
                      left: 0,
                      right: 0,
                      top: 20,
                      height: controller.authenticationState == AuthenticationState.login ? MediaQuery.of(context).size.height - 100 : 0,
                      child: const LoginPage(),
                    ),
                    AnimatedPositioned(
                      duration: const Duration(milliseconds: 500),
                      left: 0,
                      right: 0,
                      top: 20,
                      height: controller.authenticationState == AuthenticationState.register ? MediaQuery.of(context).size.height - 100 : 0,
                      child: const RegisterPage(),
                    ),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }
}
