import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferencesService {
  PreferencesService({@required sharedPreferences})
      : this._sharedPreferences = sharedPreferences;

  static const String _useDarkModeKey = 'useDarkMode';
  static const String _lang = 'lang';
  SharedPreferences _sharedPreferences;

  Locale get locale => _sharedPreferences.get(_lang) == null
      ? null
      : Locale(_sharedPreferences.get(_lang));
  set locale(Locale locale) =>
      _sharedPreferences.setString(_lang, locale.languageCode);

  set useDarkMode(bool useDarkMode) {
    _sharedPreferences.setBool(_useDarkModeKey, useDarkMode);
  }

  bool get useDarkMode => _sharedPreferences.getBool(_useDarkModeKey) ?? false;
}
