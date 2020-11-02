import 'package:flutter/cupertino.dart';

class ThemeNotifier extends ChangeNotifier {
  String _themeName = 'Light';

  get theme => _themeName;

  toggletheme() {
    if (_themeName == 'Light') {
      _themeName = 'dartk';
    } else {
      _themeName = 'Light';
    }
    notifyListeners();
  }
}
