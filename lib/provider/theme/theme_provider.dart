import 'package:flutter/material.dart';

class ThemeProvider with ChangeNotifier {
  ThemeData get darkTheme {
    return ThemeData(
      focusColor: const Color(0xff5FC85B),
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xff2C2B2A),
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 24.0,
        ),
      ),
      iconTheme: const IconThemeData(
        color: Color(0xffDBDADA),
        size: 24.0,
      ),
      textTheme: const TextTheme(
        headlineLarge: TextStyle(
          color: Color(0xffDBDADA),
          fontSize: 24.0,
        ),
        headlineMedium: TextStyle(
          color: Color(0xffDBDADA),
          fontSize: 20.0,
        ),
        headlineSmall: TextStyle(
          color: Color(0xffDBDADA),
          fontSize: 16.0,
        ),
        bodyLarge: TextStyle(
          color: Color(0xffDBDADA),
          fontSize: 24.0,
        ),
        bodyMedium: TextStyle(
          color: Color(0xffDBDADA),
          fontSize: 20.0,
        ),
        bodySmall: TextStyle(
          color: Color(0xffDBDADA),
          fontSize: 16.0,
        ),
        titleLarge: TextStyle(
          color: Color(0xffDBDADA),
          fontSize: 24.0,
        ),
        titleMedium: TextStyle(
          color: Color(0xffDBDADA),
          fontSize: 20.0,
        ),
        titleSmall: TextStyle(
          color: Color(0xffDBDADA),
          fontSize: 16.0,
        ),
      ),
      colorScheme: const ColorScheme.dark(
        primary: Color(0xffDBDADA),
        onPrimary: Color(0xff4B4A49),
        primaryContainer: Color(0xff232121),
        onPrimaryContainer: Color(0xff2D2A2A),
        secondaryContainer: Color(0xff4B4949),
      ).copyWith(error: const Color.fromARGB(255, 244, 65, 53)),
    );
  }

  ThemeData get lightTheme {
    return ThemeData(
      focusColor: const Color(0xff53B749),
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xffEEECEB),
        titleTextStyle: TextStyle(
          color: Color(0xff2C2B2A),
          fontSize: 24.0,
        ),
      ),
      iconTheme: const IconThemeData(
        color: Color(0xff3D3C3C),
        size: 24.0,
      ),
      textTheme: const TextTheme(
        headlineLarge: TextStyle(
          color: Color(0xff3D3C3C),
          fontSize: 24.0,
        ),
        headlineMedium: TextStyle(
          color: Color(0xff3D3C3C),
          fontSize: 20.0,
        ),
        headlineSmall: TextStyle(
          color: Color(0xff3D3C3C),
          fontSize: 16.0,
        ),
        bodyLarge: TextStyle(
          color: Color(0xff3D3C3C),
          fontSize: 24.0,
        ),
        bodyMedium: TextStyle(
          color: Color(0xff3D3C3C),
          fontSize: 20.0,
        ),
        bodySmall: TextStyle(
          color: Color(0xff3D3C3C),
          fontSize: 16.0,
        ),
        titleLarge: TextStyle(
          color: Color(0xff3D3C3C),
          fontSize: 24.0,
        ),
        titleMedium: TextStyle(
          color: Color(0xff3D3C3C),
          fontSize: 20.0,
        ),
        titleSmall: TextStyle(
          color: Color(0xff3D3C3C),
          fontSize: 16.0,
        ),
      ),
      colorScheme: const ColorScheme.light(
        primary: Color(0xff3D3C3C),
        onPrimary: Color(0xffAEACAC),
        primaryContainer: Color(0xffF3F2F1),
        onPrimaryContainer: Color(0xffEEECEB),
        secondaryContainer: Color(0xffDCDAD9),
      ).copyWith(error: const Color.fromARGB(255, 244, 65, 53)),
    );
  }
}
