import 'package:flutter/material.dart';

class AppTheme {

  ThemeData getTheme(){
    final seedColor = Colors.blue[200];

    return ThemeData(
        useMaterial3: true,
        colorSchemeSeed: seedColor,
        listTileTheme: ListTileThemeData(
          iconColor: seedColor
        )
    );
  }

}