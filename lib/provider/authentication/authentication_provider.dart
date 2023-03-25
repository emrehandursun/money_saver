import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:money_saver/models/user/user.dart' as models;
import '../../mixin/dialog_composer.dart';
import '../../models/customer/customer.dart';

enum AuthenticationState { wellCome, loginWithEmail, loginWithPhoneNumber, registerWithEmail, registerWithPhoneNumber }

class AuthenticationProvider with ChangeNotifier, DiagnosticableTreeMixin, DialogComposer {
  Customer? currentCustomer;
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  AuthenticationProvider() : super();

  AuthenticationState authenticationState = AuthenticationState.wellCome;
  void changeHomeState(AuthenticationState state) {
    authenticationState = state;
    notifyListeners();
  }

  void verifyOtp({
    required BuildContext context,
    required String verificationId,
    required String userOtp,
    required Function onSuccess,
  }) async {
    _isLoading = true;
    notifyListeners();
    try {
      PhoneAuthCredential phoneAuthCredential = PhoneAuthProvider.credential(verificationId: verificationId, smsCode: userOtp);
      User? user = (await FirebaseAuth.instance.signInWithCredential(phoneAuthCredential)).user;
      if (user != null) {
        onSuccess();
      }
      _isLoading = false;
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      showFlushBar(context, e.message.toString());
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> checkExistingUser(String uid) async {
    DocumentSnapshot snapshot = await FirebaseFirestore.instance.collection("users").doc(uid).get();
    if (snapshot.exists) {
      return true;
    } else {
      return false;
    }
  }

  Future<Customer?> getCurrent() async {
    models.User? user;
    if (FirebaseAuth.instance.currentUser != null) {
      user = await FirebaseFirestore.instance.collection('users').where('Uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid).get().then(
            (value) => models.User.fromMap(
              value.docs.first.data(),
            ),
          );
    }
    if (user != null) {
      final Customer customer = Customer();
      customer.user = user;
      currentCustomer = customer;
      return customer;
    }
    notifyListeners();
    return null;
  }

  Future<Customer?> getUserAccordingToUid(String uid) async {
    models.User? user;
    user = await FirebaseFirestore.instance.collection('users').where('Uid', isEqualTo: uid).get().then((value) {
      if (value.docs.isEmpty) {
        return null;
      } else {
        return models.User.fromMap(
          value.docs.first.data(),
        );
      }
    });
    if (user != null) {
      final Customer customer = Customer();
      customer.user = user;
      currentCustomer = customer;
      return customer;
    }
    notifyListeners();
    return null;
  }

  Future<Customer?> getUserAccordingToPhoneNumber(String phoneNumber) async {
    models.User? user;
    user = await FirebaseFirestore.instance.collection('users').where('PhoneNumber', isEqualTo: phoneNumber).get().then((value) {
      if (value.docs.isEmpty) {
        return null;
      } else {
        return models.User.fromMap(
          value.docs.first.data(),
        );
      }
    });
    if (user != null) {
      final Customer customer = Customer();
      customer.user = user;
      currentCustomer = customer;
      return customer;
    }
    notifyListeners();
    return null;
  }
}
