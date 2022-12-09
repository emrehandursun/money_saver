import 'package:flutter/material.dart';
import 'package:money_saver/provider/authentication/authentication_provider.dart';
import 'package:provider/provider.dart';

class WellcomePage extends StatelessWidget {
  const WellcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthenticationProvider authenticationProvider = context.watch<AuthenticationProvider>();
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const Text('Wellcome'),
          if (authenticationProvider.authenticationState == AuthenticationState.wellCome)
            TextButton(
              onPressed: () {
                authenticationProvider.changeHomeState(AuthenticationState.login);
              },
              child: const Text('Lets get started'),
            )
        ],
      ),
    );
  }
}
