import 'package:flutter/material.dart';

class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MainAppBar({Key? key}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(50);

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return AppBar(
      title: Text(
        'Money Saver',
        style: themeData.appBarTheme.titleTextStyle,
      ),
      backgroundColor: themeData.appBarTheme.backgroundColor,
    );
  }
}
