import 'package:flutter/material.dart';
import 'package:money_saver/provider/authentication/authentication_provider.dart';
import 'package:provider/provider.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    final AuthenticationProvider authenticationProvider = context.watch<AuthenticationProvider>();
    return Center(
      child: Column(
        mainAxisAlignment: authenticationProvider.authenticationState == AuthenticationState.wellCome ? MainAxisAlignment.spaceEvenly : MainAxisAlignment.end,
        children: [
          Text(
            'Welcome',
            style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.bold,
              color: themeData.colorScheme.primary,
            ),
          ),
          if (authenticationProvider.authenticationState == AuthenticationState.wellCome) const SizedBox(height: 60),
          authenticationProvider.authenticationState == AuthenticationState.wellCome
              ? InkWell(
                  onTap: () {
                    authenticationProvider.changeHomeState(AuthenticationState.login);
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: themeData.colorScheme.primary.withOpacity(0.2),
                    ),
                    child: Text(
                      'Lets get started',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: themeData.colorScheme.primary,
                      ),
                    ),
                  ),
                )
              : const SizedBox(
                  height: 60,
                ),
        ],
      ),
    );
  }
}
