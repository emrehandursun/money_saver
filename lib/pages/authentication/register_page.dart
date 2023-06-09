import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:money_saver/extensions/input_decorations.dart';
import 'package:money_saver/extensions/string_extensions.dart';
import 'package:money_saver/mixin/dialog_composer.dart';
import 'package:money_saver/models/user/user.dart' as model;
import 'package:money_saver/pages/authentication/verification_page.dart';
import 'package:money_saver/widgets/password_validator/password_validator.dart';
import 'package:provider/provider.dart';

import '../../models/customer/customer.dart';
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
                    if (authenticationProvider.authenticationState == AuthenticationState.loginWithEmail || authenticationProvider.authenticationState == AuthenticationState.registerWithEmail)
                      _registerWithEmail(authenticationProvider, themeData, context),
                    if (authenticationProvider.authenticationState == AuthenticationState.loginWithPhoneNumber ||
                        authenticationProvider.authenticationState == AuthenticationState.registerWithPhoneNumber)
                      _registerWithPhoneNumber(authenticationProvider, themeData, context),
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
      ),
    );
  }

  Widget _registerWithEmail(AuthenticationProvider authenticationProvider, ThemeData themeData, BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          child: RegisterWithEmailForm(context: context),
        ),
        TextButton(
          onPressed: () {
            authenticationProvider.changeHomeState(AuthenticationState.loginWithEmail);
          },
          child: Text(
            'Already have an account? Login here',
            style: TextStyle(fontSize: 16, color: themeData.colorScheme.primary),
          ),
        ),
      ],
    );
  }

  Widget _registerWithPhoneNumber(AuthenticationProvider authenticationProvider, ThemeData themeData, BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          child: RegisterWithPhoneNumberForm(context: context),
        ),
        TextButton(
          onPressed: () {
            authenticationProvider.changeHomeState(AuthenticationState.loginWithPhoneNumber);
          },
          child: Text(
            'Already have an account? Login here',
            style: TextStyle(fontSize: 16, color: themeData.colorScheme.primary),
          ),
        ),
      ],
    );
  }
}

class RegisterWithEmailForm extends StatefulWidget {
  final BuildContext context;
  const RegisterWithEmailForm({Key? key, required this.context}) : super(key: key);

  @override
  State<RegisterWithEmailForm> createState() => _RegisterWithEmailFormState();
}

class _RegisterWithEmailFormState extends State<RegisterWithEmailForm> with DialogComposer {
  model.User user = model.User();
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
      if (controller.authenticationState == AuthenticationState.loginWithEmail) {
        _firstNameController.clear();
        _familyNameController.clear();
        _emailController.clear();
        _passwordController.clear();
      } else if (controller.authenticationState == AuthenticationState.registerWithEmail) {
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
                fillUserData();
                try {
                  await FirebaseAuth.instance.createUserWithEmailAndPassword(email: _emailController.text, password: _passwordController.text).then((value) {
                    user.uid = value.user!.uid;
                    FirebaseFirestore.instance.collection('users').doc(value.user!.uid).set(user.toMap());
                  });
                } on FirebaseAuthException catch (e) {
                  showFlushBar(context, e.code.getError());
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
        ],
      ),
    );
  }

  void fillUserData() {
    user.email = _emailController.text;
    user.firstName = _firstNameController.text;
    user.familyName = _familyNameController.text;
    user.nationalIdentityNo = '';
    user.phoneNumber = '';
    user.userFullName ??= '${user.firstName} ${user.familyName}';
  }
}

class RegisterWithPhoneNumberForm extends StatefulWidget {
  final BuildContext context;
  const RegisterWithPhoneNumberForm({super.key, required this.context});

  @override
  State<RegisterWithPhoneNumberForm> createState() => _RegisterWithPhoneNumberFormState();
}

class _RegisterWithPhoneNumberFormState extends State<RegisterWithPhoneNumberForm> with DialogComposer {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _familyNameController = TextEditingController();
  bool _isValidPhoneNumber = false;
  String initialCountry = 'TR';
  PhoneNumber phoneNumber = PhoneNumber(isoCode: 'TR');
  bool isHidden = true;
  bool isPasswordValidate = false;
  PhoneAuthCredential? credential;
  model.User user = model.User();
  var controller = AuthenticationProvider();
  @override
  void initState() {
    controller = widget.context.watch<AuthenticationProvider>();
    controller.addListener(() {
      if (controller.authenticationState == AuthenticationState.loginWithEmail) {
        _firstNameController.clear();
        _familyNameController.clear();
        phoneNumber = PhoneNumber(isoCode: 'TR');
      } else if (controller.authenticationState == AuthenticationState.registerWithEmail) {
        _firstNameController.clear();
        _familyNameController.clear();
        phoneNumber = PhoneNumber(isoCode: 'TR');
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
          InternationalPhoneNumberInput(
            textStyle: TextStyle(color: themeData.colorScheme.primary),
            inputDecoration: inputDecoration(themeData, 'Phone Number'),
            onInputChanged: (PhoneNumber number) {
              phoneNumber = number;
              debugPrint(phoneNumber.phoneNumber);
            },
            selectorConfig: const SelectorConfig(
              selectorType: PhoneInputSelectorType.DIALOG,
            ),
            ignoreBlank: false,
            autoValidateMode: AutovalidateMode.disabled,
            selectorTextStyle: TextStyle(color: themeData.colorScheme.primary),
            initialValue: phoneNumber,
            onInputValidated: (isValid) => _isValidPhoneNumber = isValid,
            formatInput: true,
            keyboardType: const TextInputType.numberWithOptions(signed: true, decimal: true),
            inputBorder: const OutlineInputBorder(),
          ),
          const SizedBox(height: 12),
          OutlinedButton(
            onPressed: () async {
              if (_firstNameController.text.isNotEmpty && _familyNameController.text.isNotEmpty && _isValidPhoneNumber) {
                Customer? customer = await context.read<AuthenticationProvider>().getUserAccordingToPhoneNumber(phoneNumber.phoneNumber!);
                if (customer != null) {
                  // ignore: use_build_context_synchronously
                  if (!context.mounted) return;
                  showFlushBar(context, 'This phone number is already registered');
                  return;
                }
                fillUserData();
                await FirebaseAuth.instance.verifyPhoneNumber(
                    phoneNumber: phoneNumber.phoneNumber!,
                    verificationCompleted: (PhoneAuthCredential credential) async {
                      await FirebaseAuth.instance.signInWithCredential(credential);
                    },
                    verificationFailed: (FirebaseAuthException e) {},
                    codeSent: (verificationId, forceResendingToken) {
                      showFlushBar(context, 'Code Sent');
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => VerificationCodePage(
                            verificationId: verificationId,
                            onVerificationCompleted: (phoneAuthCredential) async {
                              try {
                                await FirebaseAuth.instance.signInWithCredential(phoneAuthCredential).then((value) async {
                                  user.uid = value.user!.uid;
                                  Customer? customer = await context.read<AuthenticationProvider>().getUserAccordingToUid(user.uid!);
                                  if (customer == null) {
                                    FirebaseFirestore.instance.collection('users').doc(value.user!.uid).set(user.toMap());
                                  }
                                });
                              } finally {
                                Navigator.popUntil(context, (route) => route.isFirst);
                              }
                            },
                          ),
                        ),
                      );
                    },
                    codeAutoRetrievalTimeout: (verificationId) {});
              }
            },
            style: OutlinedButton.styleFrom(
              side: BorderSide(
                color: themeData.colorScheme.primary.withOpacity(0.5),
                width: 1,
              ),
              backgroundColor:
                  _firstNameController.text.isNotEmpty && _familyNameController.text.isNotEmpty && _isValidPhoneNumber ? themeData.colorScheme.primary : themeData.colorScheme.onPrimaryContainer,
              foregroundColor:
                  _firstNameController.text.isNotEmpty && _familyNameController.text.isNotEmpty && _isValidPhoneNumber ? themeData.colorScheme.onPrimaryContainer : themeData.colorScheme.primary,
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
                color: _firstNameController.text.isNotEmpty && _familyNameController.text.isNotEmpty && _isValidPhoneNumber ? themeData.colorScheme.primaryContainer : themeData.colorScheme.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void fillUserData() {
    user.firstName = _firstNameController.text;
    user.familyName = _familyNameController.text;
    user.phoneNumber = phoneNumber.phoneNumber!;
    user.nationalIdentityNo = '';
    user.email = '';
    user.userFullName ??= '${user.firstName} ${user.familyName}';
  }
}
