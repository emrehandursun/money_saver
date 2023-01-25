import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:money_saver/provider/authentication/authentication_provider.dart';
import 'package:money_saver/provider/customer/customer_provider.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  User? user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Center(
      child: InkWell(
        onTap: () async {
          try {
            context.loaderOverlay.show();
            context.read<AuthenticationProvider>().changeHomeState(AuthenticationState.wellCome);
            final customer = await context.read<CustomerProvider>().getCurrent();
            debugPrint(customer?.user?.email ?? "-");
            FirebaseAuth.instance.signOut();
          } finally {
            context.loaderOverlay.hide();
          }
        },
        child: Text(
          user?.email ?? '',
          style: themeData.textTheme.bodyLarge,
        ),
      ),
    );
  }
}
