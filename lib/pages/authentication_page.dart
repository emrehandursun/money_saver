import 'package:flutter/material.dart';

class AuthenticationPage extends StatefulWidget {
  const AuthenticationPage({Key? key}) : super(key: key);

  @override
  State<AuthenticationPage> createState() => _AuthenticationPageState();
}

class _AuthenticationPageState extends State<AuthenticationPage> {
  bool isLoggingMode = true;
  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return Scaffold(
      backgroundColor: themeData.colorScheme.primaryContainer,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
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
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                        onTap: () => setState(() => isLoggingMode = true),
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            border: Border.all(
                              color: themeData.colorScheme.primary.withOpacity(0.5),
                              width: 1,
                            ),
                            color: isLoggingMode ? themeData.colorScheme.primary : themeData.colorScheme.onPrimaryContainer,
                          ),
                          child: Text(
                            'Login',
                            style: TextStyle(
                              color: isLoggingMode ? themeData.colorScheme.primaryContainer : themeData.colorScheme.primary,
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () => setState(() => isLoggingMode = false),
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            border: Border.all(
                              color: themeData.colorScheme.primary.withOpacity(0.5),
                              width: 1,
                            ),
                            color: isLoggingMode ? themeData.colorScheme.onPrimaryContainer : themeData.colorScheme.primary,
                          ),
                          child: Text(
                            'Register',
                            style: TextStyle(
                              color: isLoggingMode ? themeData.colorScheme.primary : themeData.colorScheme.primaryContainer,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  isLoggingMode ? const LoginForm() : const RegisterForm(),
                  isLoggingMode ? const Login() : const Register(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class RegisterForm extends StatefulWidget {
  RegisterForm({Key? key}) : super(key: key);

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}