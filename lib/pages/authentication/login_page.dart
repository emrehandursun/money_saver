import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
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
                  if (authenticationProvider.authenticationState == AuthenticationState.loginWithEmail || authenticationProvider.authenticationState == AuthenticationState.registerWithEmail)
                    _loginWithEmail(authenticationProvider, themeData, context),
                  if (authenticationProvider.authenticationState == AuthenticationState.loginWithPhoneNumber ||
                      authenticationProvider.authenticationState == AuthenticationState.registerWithPhoneNumber)
                    _loginWithPhoneNumber(authenticationProvider, themeData, context),
                  TextButton(
                    onPressed: () {
                      authenticationProvider.changeHomeState(AuthenticationState.wellCome);
                    },
                    child: Text(
                      'Back',
                      style: TextStyle(fontSize: 14, color: themeData.colorScheme.primary),
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

  Widget _loginWithEmail(AuthenticationProvider authenticationProvider, ThemeData themeData, BuildContext context) {
    return Column(
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
          child: LoginWithEmailForm(context: context),
        ),
        TextButton(
          onPressed: () {
            authenticationProvider.changeHomeState(AuthenticationState.registerWithEmail);
          },
          child: Text(
            'Don\'t have an account? Register here',
            style: TextStyle(fontSize: 16, color: themeData.colorScheme.primary),
          ),
        ),
      ],
    );
  }

  Widget _loginWithPhoneNumber(AuthenticationProvider authenticationProvider, ThemeData themeData, BuildContext context) {
    return Column(
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
          child: LoginWithPhoneNumberForm(context: context),
        ),
        TextButton(
          onPressed: () {
            authenticationProvider.changeHomeState(AuthenticationState.registerWithPhoneNumber);
          },
          child: Text(
            'Don\'t have an account? Register here',
            style: TextStyle(fontSize: 16, color: themeData.colorScheme.primary),
          ),
        ),
      ],
    );
  }
}

class LoginWithEmailForm extends StatefulWidget {
  final BuildContext context;
  const LoginWithEmailForm({Key? key, required this.context}) : super(key: key);

  @override
  State<LoginWithEmailForm> createState() => _LoginWithEmailFormState();
}

class _LoginWithEmailFormState extends State<LoginWithEmailForm> with DialogComposer {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool isHidden = true;
  bool isPasswordValidate = false;

  var controller = AuthenticationProvider();
  @override
  void initState() {
    controller = widget.context.watch<AuthenticationProvider>();
    controller.addListener(() {
      if (controller.authenticationState == AuthenticationState.loginWithEmail) {
        _emailController.clear();
        _passwordController.clear();
      } else if (controller.authenticationState == AuthenticationState.registerWithEmail) {
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
                  context.loaderOverlay.show();
                  await FirebaseAuth.instance.signInWithEmailAndPassword(email: _emailController.text, password: _passwordController.text).then((value) {
                    final ApplicationProvider applicationProvider = Provider.of<ApplicationProvider>(context, listen: false);
                    applicationProvider.setNavigationBarPage(NavigationBarPage.home);
                  });
                } on FirebaseAuthException catch (e) {
                  showFlushBar(context, e.code.getError());
                } finally {
                  context.loaderOverlay.hide();
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

class LoginWithPhoneNumberForm extends StatefulWidget {
  final BuildContext context;
  const LoginWithPhoneNumberForm({super.key, required this.context});

  @override
  State<LoginWithPhoneNumberForm> createState() => _LoginWithPhoneNumberFormState();
}

class _LoginWithPhoneNumberFormState extends State<LoginWithPhoneNumberForm> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
