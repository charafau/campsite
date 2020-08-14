  import 'package:flutter/material.dart';

  class AppTheme {
    AppTheme()
        : data = ThemeData(
            accentColor: Colors.pinkAccent,
            primaryColor: Colors.indigo,
            brightness: Brightness.light,
          );

    final ThemeData data;
  }
 
  