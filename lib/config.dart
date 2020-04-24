import 'package:flutter/material.dart';

class ThemeChanger extends ChangeNotifier {
  bool _darkStatus = false;

  isDark() => _darkStatus;

  setDarkStatus(bool status) {
    _darkStatus = status;

    notifyListeners();
  }

  // Brightness lightDark = Brightness.light;

  // void setThemeModeByContext(BuildContext context) {
  //   var deviceThemeMode = MediaQuery.of(context).platformBrightness;

  //   if (deviceThemeMode != lightDark) {
  //     lightDark = deviceThemeMode;
  //     notifyListeners();
  //   }
  // }
}
