import 'package:flutter/foundation.dart';

enum AuthenticationState { wellCome, loginWithEmail, loginWithPhoneNumber, registerWithEmail, registerWithPhoneNumber }

class AuthenticationProvider with ChangeNotifier, DiagnosticableTreeMixin {
  AuthenticationProvider() : super();

  AuthenticationState authenticationState = AuthenticationState.wellCome;
  void changeHomeState(AuthenticationState state) {
    authenticationState = state;
    notifyListeners();
  }
}
