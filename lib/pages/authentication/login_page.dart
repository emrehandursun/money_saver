import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:money_saver/extensions/string_extensions.dart';
import 'package:provider/provider.dart';

import '../../extensions/input_decorations.dart';
import '../../mixin/dialog_composer.dart';
import '../../provider/application/application.dart';
import '../../provider/application/application_provider.dart';
import '../../provider/authentication/authentication_provider.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthenticationProvider authenticationProvider = context.watch<AuthenticationProvider>();
    final ThemeData themeData = Theme.of(context);
    return Center(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const SizedBox(height: 40),
              Text(
                'Login Form',
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
                    child: LoginForm(context: context),
                  ),
                  TextButton(
                    onPressed: () {
                      authenticationProvider.changeHomeState(AuthenticationState.register);
                    },
                    child: Text(
                      'Don\'t have an account? Register here',
                      style: TextStyle(fontSize: 16, color: themeData.colorScheme.primary),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  final BuildContext context;
  const LoginForm({Key? key, required this.context}) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> with DialogComposer {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool isHidden = true;
  bool isPasswordValidate = false;

  var controller = AuthenticationProvider();
  @override
  void initState() {
    controller = widget.context.watch<AuthenticationProvider>();
    controller.addListener(() {
      if (controller.authenticationState == AuthenticationState.login) {
        _emailController.clear();
        _passwordController.clear();
      } else if (controller.authenticationState == AuthenticationState.register) {
        _emailController.clear();
        _passwordController.clear();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          TextFormField(
            controller: _emailController,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: inputDecoration(themeData, 'E-mail'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your e-mail';
              } else if (!value.isValidEmail()) {
                return 'Please enter a valid e-mail';
              }
              return null;
            },
            onChanged: (value) => setState(() {}),
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: _passwordController,
            obscureText: isHidden,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: inputDecoration(themeData, 'Password', forPassword: true, onTap: () {
              setState(() {
                isHidden = !isHidden;
              });
            }),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your password';
              }
              return null;
            },
            onChanged: (value) => setState(() {
              isPasswordValidate = value.length >= 8;
            }),
          ),
          const SizedBox(height: 12),
          OutlinedButton(
            onPressed: () async {
              if (_emailController.text.isValidEmail()) {
                try {
                  await FirebaseAuth.instance.signInWithEmailAndPassword(email: _emailController.text, password: _passwordController.text).then((value) {
                    final ApplicationProvider applicationProvider = Provider.of<ApplicationProvider>(context, listen: false);
                    applicationProvider.setNavigationBarPage(NavigationBarPage.home);
                  });
                } on FirebaseAuthException catch (e) {
                  showWarningSnackBar(context, e.code.getError());
                }
              }
            },
            style: OutlinedButton.styleFrom(
              side: BorderSide(
                color: themeData.colorScheme.primary.withOpacity(0.5),
                width: 1,
              ),
              backgroundColor: isPasswordValidate && _emailController.text.isValidEmail() ? themeData.colorScheme.primary : themeData.colorScheme.onPrimaryContainer,
              foregroundColor: isPasswordValidate && _emailController.text.isValidEmail() ? themeData.colorScheme.onPrimaryContainer : themeData.colorScheme.primary,
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            child: Text(
              'Login',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: isPasswordValidate && _emailController.text.isValidEmail() ? themeData.colorScheme.primaryContainer : themeData.colorScheme.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
