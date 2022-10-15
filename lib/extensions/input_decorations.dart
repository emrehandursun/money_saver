import 'package:flutter/material.dart';

InputDecoration inputDecoration(ThemeData themeData, String labelText) {
  return InputDecoration(
    labelStyle: const TextStyle(fontSize: 16),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: themeData.colorScheme.onPrimary),
      borderRadius: const BorderRadius.all(Radius.circular(4)),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: themeData.colorScheme.onPrimary),
      borderRadius: const BorderRadius.all(Radius.circular(4)),
    ),
    errorStyle: TextStyle(color: themeData.colorScheme.primary),
    hintStyle: TextStyle(color: themeData.colorScheme.primary),
    focusedErrorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: themeData.colorScheme.onPrimary),
      borderRadius: const BorderRadius.all(Radius.circular(4)),
    ),
    errorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: themeData.colorScheme.onPrimary),
      borderRadius: const BorderRadius.all(Radius.circular(4)),
    ),
    focusColor: themeData.colorScheme.onPrimary,
    border: OutlineInputBorder(
      borderSide: BorderSide(color: themeData.colorScheme.onPrimary),
      borderRadius: const BorderRadius.all(Radius.circular(4)),
    ),
    labelText: labelText,
  );
}
