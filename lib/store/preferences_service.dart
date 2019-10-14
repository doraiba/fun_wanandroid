import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferencesService {
  PreferencesService({@required sharedPreferences})
      : this._sharedPreferences = sharedPreferences;

  static const String _useDarkModeKey = 'useDarkMode';
  static const String _lang = 'lang';
  static const String _icolor = 'i_of_color';
  SharedPreferences _sharedPreferences;

  Locale get locale {
    String lang = _sharedPreferences.get(_lang);
    if (lang == null) return null;
    List<String> localeInfo = lang.split('_');
    return Locale(localeInfo[0], localeInfo.length == 2 ? localeInfo[1] : null);
  }

  set locale(Locale locale) =>
      _sharedPreferences.setString(_lang, locale.toString());

  set useDarkMode(bool useDarkMode) {
    _sharedPreferences.setBool(_useDarkModeKey, useDarkMode);
  }

  bool get useDarkMode => _sharedPreferences.getBool(_useDarkModeKey) ?? false;

  int get icolor => _sharedPreferences.getInt(_icolor) ?? 0;

  set icolor(int value) => _sharedPreferences.setInt(_icolor, value);
}
