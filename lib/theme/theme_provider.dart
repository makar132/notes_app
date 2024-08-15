import 'package:flutter/material.dart';
import 'package:notes_app/theme/theme.dart';

class ThemeProvider with ChangeNotifier {
  ThemeData _themeData = darkTheme;

  ThemeData get themeData => _themeData;

  bool get isDarkMode => _themeData == darkTheme;
  set themeData(ThemeData themeData) {
    _themeData = themeData;
    notifyListeners();
  }

  void toggleTheme() {
    if (_themeData == lightTheme) {
      themeData = darkTheme;
    } else {
      themeData = lightTheme;
    }
  }
}
