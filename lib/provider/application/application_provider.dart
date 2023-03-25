import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:money_saver/provider/authentication/authentication_provider.dart';
import '../../firebase_options.dart';
import '../../pages/home_page.dart';
import '../../pages/profile_page.dart';
import 'application.dart';

class ApplicationProvider with ChangeNotifier, DiagnosticableTreeMixin {
  ApplicationProvider({
    required this.selectedNavigationBarPage,
    required this.selectedNavigationBarPageWidget,
    required this.status,
  }) : super();
  NavigationBarPage selectedNavigationBarPage;
  Widget selectedNavigationBarPageWidget;
  ProgramStatus status;
  Future<void> initializeApplication(BuildContext context) async {
    try {
      if (status == ProgramStatus.none) {
        status = ProgramStatus.initializingDevice;
      }
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
      await AuthenticationProvider().getCurrent();
      status = ProgramStatus.readyApp;
    } catch (e) {
      status = ProgramStatus.applicationError;
    } finally {
      notifyListeners();
    }
  }

  Future<void> changeStatus(ProgramStatus status) async {
    this.status = status;
    notifyListeners();
  }

  void setNavigationBarPage(NavigationBarPage page) {
    selectedNavigationBarPage = page;
    switch (page) {
      case NavigationBarPage.home:
        selectedNavigationBarPageWidget = const HomePage();
        break;

      case NavigationBarPage.profile:
        selectedNavigationBarPageWidget = const ProfilePage();
        break;

      default:
        selectedNavigationBarPageWidget = const HomePage();
        break;
    }
    notifyListeners();
  }
}
