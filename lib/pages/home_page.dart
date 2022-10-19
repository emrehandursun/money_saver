import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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
        onTap: () {
          FirebaseAuth.instance.signOut();
        },
        child: Text(
          user?.email ?? '',
          style: themeData.textTheme.bodyLarge,
        ),
      ),
    );
  }
}
