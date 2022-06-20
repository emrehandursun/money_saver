import 'package:flutter/foundation.dart';

class SettingsProvider with ChangeNotifier, DiagnosticableTreeMixin {
  SettingsProvider({
    required this.themeStatus,
  }) : super();
  int themeStatus;

  Future<void> setThemeStatus(int status) async {
    themeStatus = status;
    notifyListeners();
  }
}
