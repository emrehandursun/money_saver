import 'package:flutter/material.dart';
import 'package:money_saver/extensions/input_decorations.dart';
import 'package:money_saver/extensions/string_extensions.dart';
import 'package:money_saver/widgets/password_validator/password_validator.dart';

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

class _LoginFormState extends State<LoginForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
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
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: inputDecoration(themeData, 'Password'),
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
            onTap: () {
              if (isPasswordValidate && _emailController.text.isValidEmail()) {}
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

class _RegisterFormState extends State<RegisterForm> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _surnameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool isPasswordValidate = false;
  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          TextFormField(
            controller: _nameController,
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
            controller: _surnameController,
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
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: inputDecoration(themeData, 'Password'),
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
            onTap: () {
              if (isPasswordValidate && _emailController.text.isValidEmail()) {}
            },
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                border: Border.all(
                  color: themeData.colorScheme.primary.withOpacity(0.5),
                  width: 1,
                ),
                color: _nameController.text.isNotEmpty && _surnameController.text.isNotEmpty && isPasswordValidate && _emailController.text.isValidEmail()
                    ? themeData.colorScheme.primary
                    : themeData.colorScheme.onPrimaryContainer,
              ),
              child: Text(
                'Register',
                style: TextStyle(
                  color: _nameController.text.isNotEmpty && _surnameController.text.isNotEmpty && isPasswordValidate && _emailController.text.isValidEmail()
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
