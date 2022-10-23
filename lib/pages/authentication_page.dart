import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:money_saver/extensions/input_decorations.dart';
import 'package:money_saver/extensions/string_extensions.dart';
import 'package:money_saver/mixin/dialog_composer.dart';
import 'package:money_saver/provider/application/application.dart';
import 'package:money_saver/provider/application/application_provider.dart';
import 'package:money_saver/widgets/password_validator/password_validator.dart';
import 'package:provider/provider.dart';

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
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              isLoggingMode ? 'Login Form' : 'Register Form',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: themeData.colorScheme.primary,
              ),
            ),
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
    );
  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> with DialogComposer {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool isHidden = true;
  bool isPasswordValidate = false;
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
            onChanged: (value) => setState(() {}),
          ),
          if ((_passwordController.text.isNotEmpty)) const SizedBox(height: 12),
          if ((_passwordController.text.isNotEmpty))
            Align(
              alignment: Alignment.centerLeft,
              child: PasswordValidator(
                successColor: themeData.focusColor,
                failureColor: themeData.colorScheme.primary,
                minLength: 8,
                uppercaseCharCount: 0,
                numericCharCount: 3,
                specialCharCount: 1,
                normalCharCount: 3,
                height: 100,
                onSuccess: () {
                  isPasswordValidate = true;
                },
                onFail: () {
                  isPasswordValidate = false;
                },
                controller: _passwordController,
              ),
            ),
          const SizedBox(height: 12),
          InkWell(
            onTap: () async {
              if (isPasswordValidate && _emailController.text.isValidEmail()) {
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
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                border: Border.all(
                  color: themeData.colorScheme.primary.withOpacity(0.5),
                  width: 1,
                ),
                color: isPasswordValidate && _emailController.text.isValidEmail() ? themeData.colorScheme.primary : themeData.colorScheme.onPrimaryContainer,
              ),
              child: Text(
                'Login',
                style: TextStyle(
                  color: isPasswordValidate && _emailController.text.isValidEmail() ? themeData.colorScheme.primaryContainer : themeData.colorScheme.primary,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class RegisterForm extends StatefulWidget {
  const RegisterForm({Key? key}) : super(key: key);

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> with DialogComposer {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _familyNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool isHidden = true;
  bool isPasswordValidate = false;
  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          TextFormField(
            controller: _firstNameController,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: inputDecoration(themeData, 'Name'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your name';
              }
              return null;
            },
            onChanged: (value) => setState(() {}),
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: _familyNameController,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: inputDecoration(themeData, 'Surname'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your surname';
              }
              return null;
            },
            onChanged: (value) => setState(() {}),
          ),
          const SizedBox(height: 12),
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
            onChanged: (value) => setState(() {}),
          ),
          if ((_passwordController.text.isNotEmpty)) const SizedBox(height: 12),
          if ((_passwordController.text.isNotEmpty))
            Align(
              alignment: Alignment.centerLeft,
              child: PasswordValidator(
                successColor: themeData.focusColor,
                failureColor: themeData.colorScheme.primary,
                minLength: 8,
                uppercaseCharCount: 0,
                numericCharCount: 3,
                specialCharCount: 1,
                normalCharCount: 3,
                height: 100,
                onSuccess: () {
                  isPasswordValidate = true;
                },
                onFail: () {
                  isPasswordValidate = false;
                },
                controller: _passwordController,
              ),
            ),
          const SizedBox(height: 12),
          InkWell(
            onTap: () async {
              if (_firstNameController.text.isNotEmpty && _familyNameController.text.isNotEmpty && isPasswordValidate && _emailController.text.isValidEmail()) {
                try {
                  await FirebaseAuth.instance.createUserWithEmailAndPassword(email: _emailController.text, password: _passwordController.text).then((value) {
                    FirebaseFirestore.instance.collection('users').doc(value.user!.uid).set({
                      'firstName': _firstNameController.text,
                      'familyName': _familyNameController.text,
                      'email': _emailController.text,
                      'uid': value.user!.uid,
                      'nationalIdentityNo': '',
                    }).then((value) {});
                  });
                } on FirebaseAuthException catch (e) {
                  showWarningSnackBar(context, e.code.getError());
                }
              }
            },
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                border: Border.all(
                  color: themeData.colorScheme.primary.withOpacity(0.5),
                  width: 1,
                ),
                color: _firstNameController.text.isNotEmpty && _familyNameController.text.isNotEmpty && isPasswordValidate && _emailController.text.isValidEmail()
                    ? themeData.colorScheme.primary
                    : themeData.colorScheme.onPrimaryContainer,
              ),
              child: Text(
                'Register',
                style: TextStyle(
                  color: _firstNameController.text.isNotEmpty && _familyNameController.text.isNotEmpty && isPasswordValidate && _emailController.text.isValidEmail()
                      ? themeData.colorScheme.primaryContainer
                      : themeData.colorScheme.primary,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
