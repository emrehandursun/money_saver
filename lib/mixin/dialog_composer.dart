import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';

mixin DialogComposer {
  Flushbar showFlushBar(BuildContext context, String message, [Duration? duration]) {
    final ThemeData themeData = Theme.of(context);
    return Flushbar(
      margin: const EdgeInsets.all(8),
      borderRadius: BorderRadius.circular(8),
      flushbarPosition: FlushbarPosition.BOTTOM,
      flushbarStyle: FlushbarStyle.FLOATING,
      backgroundColor: themeData.colorScheme.primary,
      messageText: Text(
        message,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: themeData.colorScheme.primaryContainer,
        ),
      ),
      duration: duration ?? const Duration(milliseconds: 2000),
    )..show(context);
  }
}
