import 'package:chat_app/localization/demo_localization.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

String getTran(BuildContext context, String key) =>
    DemoLocalizations.of(context).getTraValues(key);

//lang Code
const String FRANCAIS = 'fr';
const String ENGLSIH = 'en';
const String ESPANOL = 'es';
const String ARABS = 'ar';

const String LANGUGE_CODE = 'langugeCode';

Future<Locale> setLocale(String langugeCode) async {
  SharedPreferences _perfs = await SharedPreferences.getInstance();
  await _perfs.setString(LANGUGE_CODE, langugeCode);
  return _locale(langugeCode);
}

Locale _locale(String langugeCode) {
  Locale _tmp;
  switch (langugeCode) {
    case FRANCAIS:
      _tmp = Locale(langugeCode, 'FR');
      break;
    case ESPANOL:
      _tmp = Locale(langugeCode, 'ES');
      break;
    case ENGLSIH:
      _tmp = Locale(langugeCode, 'US');
      break;
    case ARABS:
      _tmp = Locale(langugeCode, 'TN');
      break;
    default:
      _tmp = Locale(FRANCAIS, 'FR');
  }
  return _tmp;
}

Future<Locale> getLocale() async {
  SharedPreferences _perfs = await SharedPreferences.getInstance();
  String langugeCode = _perfs.getString(LANGUGE_CODE) ?? FRANCAIS;
  return _locale(langugeCode);
}
