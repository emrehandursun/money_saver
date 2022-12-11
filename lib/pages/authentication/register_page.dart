import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:money_saver/extensions/input_decorations.dart';
import 'package:money_saver/extensions/string_extensions.dart';
import 'package:money_saver/mixin/dialog_composer.dart';
import 'package:money_saver/widgets/password_validator/password_validator.dart';
import 'package:provider/provider.dart';

import '../../provider/authentication/authentication_provider.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    final AuthenticationProvider authenticationProvider = context.watch<AuthenticationProvider>();
    final ThemeData themeData = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        color: themeData.colorScheme.onPrimary.withOpacity(0.2),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
      ),
      child: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                const SizedBox(height: 40),
                Text(
                  'Register Form',
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
                      child: RegisterForm(context: context),
                    ),
                    TextButton(
                      onPressed: () {
                        authenticationProvider.changeHomeState(AuthenticationState.login);
                      },
                      child: Text(
                        'Already have an account? Login here',
                        style: TextStyle(fontSize: 16, color: themeData.colorScheme.primary),
                      ),
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

class RegisterForm extends StatefulWidget {
  final BuildContext context;
  const RegisterForm({Key? key, required this.context}) : super(key: key);

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

  var controller = AuthenticationProvider();
  @override
  void initState() {
    controller = widget.context.watch<AuthenticationProvider>();
    controller.addListener(() {
      if (controller.authenticationState == AuthenticationState.login) {
        _firstNameController.clear();
        _familyNameController.clear();
        _emailController.clear();
        _passwordController.clear();
      } else if (controller.authenticationState == AuthenticationState.register) {
        _firstNameController.clear();
        _familyNameController.clear();
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
          OutlinedButton(
            onPressed: () async {
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
            style: OutlinedButton.styleFrom(
              side: BorderSide(
                color: themeData.colorScheme.primary.withOpacity(0.5),
                width: 1,
              ),
              backgroundColor: _firstNameController.text.isNotEmpty && _familyNameController.text.isNotEmpty && isPasswordValidate && _emailController.text.isValidEmail()
                  ? themeData.colorScheme.primary
                  : themeData.colorScheme.onPrimaryContainer,
              foregroundColor: _firstNameController.text.isNotEmpty && _familyNameController.text.isNotEmpty && isPasswordValidate && _emailController.text.isValidEmail()
                  ? themeData.colorScheme.onPrimaryContainer
                  : themeData.colorScheme.primary,
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            child: Text(
              'Register',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: _firstNameController.text.isNotEmpty && _familyNameController.text.isNotEmpty && isPasswordValidate && _emailController.text.isValidEmail()
                    ? themeData.colorScheme.primaryContainer
                    : themeData.colorScheme.primary,
              ),
            ),
          ),
          /* InkWell(
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
          ), */
        ],
      ),
    );
  }
}
