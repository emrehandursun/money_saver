import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:money_saver/pages/authentication/authentication_page.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'provider/application/application.dart';
import 'provider/application/application_provider.dart';
import 'widgets/loader.dart';
import 'widgets/main_app_bar.dart';
import 'widgets/navigation_bar.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  void initState() {
    super.initState();
    clearSecureStorageOnReinstall();
    WidgetsBinding.instance.addPostFrameCallback((_) => _initializeApplication(context));
  }

  Future _initializeApplication(BuildContext context) async {
    final applicationProvider = context.read<ApplicationProvider>();
    if (applicationProvider.status != ProgramStatus.readyApp) {
      await applicationProvider.initializeApplication(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final applicationProvider = context.watch<ApplicationProvider>();
    switch (applicationProvider.status) {
      case ProgramStatus.applicationError:
        return Scaffold(
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Icon(Icons.error, size: 64, color: themeData.colorScheme.error),
              const Text(
                'Application Initilization Error',
                textAlign: TextAlign.center,
              ),
            ],
          ),
        );

      case ProgramStatus.readyApp:
        return StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Scaffold(
                appBar: const MainAppBar(),
                body: applicationProvider.selectedNavigationBarPageWidget,
                backgroundColor: themeData.colorScheme.primaryContainer,
                bottomNavigationBar: const MainNavigationBar(),
              );
            }
            return const AuthenticationPage();
          },
        );

      case ProgramStatus.initializingDevice:

      default:
        return Scaffold(
          backgroundColor: themeData.colorScheme.onPrimaryContainer,
          body: Center(
            child: Loader(color: themeData.colorScheme.primary),
          ),
        );
    }
  }
}

Future<void> clearSecureStorageOnReinstall() async {
  String key = 'hasRunBefore';
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool hasRunBefore = prefs.getBool(key) ?? false;
  if (!hasRunBefore) {
    FlutterSecureStorage storage = const FlutterSecureStorage();
    await storage.deleteAll();
    FirebaseAuth.instance.signOut();
    prefs.setBool(key, true);
  }
}
