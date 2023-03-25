import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:money_saver/provider/authentication/authentication_provider.dart';
import 'package:money_saver/widgets/loader.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';

class VerificationCodePage extends StatefulWidget {
  final String verificationId;
  final Function(PhoneAuthCredential) onVerificationCompleted;
  const VerificationCodePage({super.key, required this.verificationId, required this.onVerificationCompleted});

  @override
  SMSVerificationScreenState createState() => SMSVerificationScreenState();
}

class SMSVerificationScreenState extends State<VerificationCodePage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _verificationCode = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final isLoading = context.watch<AuthenticationProvider>().isLoading;
    final themeData = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('SMS Verification'),
      ),
      body: isLoading
          ? const Center(child: Loader())
          : Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Pinput(
                        controller: _verificationCode,
                        length: 6,
                        showCursor: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the verification code';
                          }
                          return null;
                        },
                        defaultPinTheme: PinTheme(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: themeData.colorScheme.primary,
                            ),
                          ),
                          textStyle: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        autofocus: true,
                        onCompleted: (value) {
                          setState(() {
                            _verificationCode.text = value;
                          });
                          if (_formKey.currentState!.validate()) {
                            context.read<AuthenticationProvider>().verifyOtp(
                                context: context,
                                verificationId: widget.verificationId,
                                userOtp: _verificationCode.text,
                                onSuccess: () async {
                                  PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: widget.verificationId, smsCode: _verificationCode.text);
                                  await widget.onVerificationCompleted(credential);
                                });
                          }
                        },
                      ),
                      const SizedBox(height: 16.0),
                      TextButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            context.read<AuthenticationProvider>().verifyOtp(
                                context: context,
                                verificationId: widget.verificationId,
                                userOtp: _verificationCode.text,
                                onSuccess: () async {
                                  PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: widget.verificationId, smsCode: _verificationCode.text);
                                  await widget.onVerificationCompleted(credential);
                                });
                          }
                        },
                        child: const Text('Verify'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
