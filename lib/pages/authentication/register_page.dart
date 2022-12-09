import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:money_saver/extensions/input_decorations.dart';
import 'package:money_saver/extensions/string_extensions.dart';
import 'package:money_saver/mixin/dialog_composer.dart';
import 'package:money_saver/widgets/password_validator/password_validator.dart';
import 'package:provider/provider.dart';

import '../../provider/authentication/authentication_provider.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthenticationProvider authenticationProvider = context.read<AuthenticationProvider>();
    final ThemeData themeData = Theme.of(context);
    return Center(
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
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(
                        color: themeData.colorScheme.primary.withOpacity(0.2),
                        width: 2,
                      ),
                      color: themeData.colorScheme.onPrimaryContainer,
                    ),
                    child: const RegisterForm(),
                  ),
                  TextButton(
                    onPressed: () {
                      authenticationProvider.changeHomeState(AuthenticationState.login);
                    },
                    child: const Text('Already have an account? Login here'),
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