import 'dart:convert';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:fun_wanandroid/model/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferencesService {
  PreferencesService({@required sharedPreferences})
      : this._sharedPreferences = sharedPreferences;

  static const String _useDarkModeKey = 'useDarkMode';
  static const String _lang = 'lang';
  static const String _icolor = 'i_of_color';
  static const String _lastLoginName = 'last_login_name';
  static const String _auth = "auth_user";
  SharedPreferences _sharedPreferences;

  Locale get locale {
    String lang = _sharedPreferences.get(_lang);
    if (lang == null) return null;
    List<String> localeInfo = lang.split('_');
    return Locale(localeInfo[0], localeInfo.length == 2 ? localeInfo[1] : null);
  }

  String get lastLoginName => _sharedPreferences.get(_lastLoginName);

  set lastLoginName(String lastLoginName) {
    _sharedPreferences.setString(_lastLoginName, lastLoginName);
  }

  set locale(Locale locale) => _sharedPreferences.setString(
      _lang, locale == null ? null : locale.toString());

  set useDarkMode(bool useDarkMode) {
    _sharedPreferences.setBool(_useDarkModeKey, useDarkMode);
  }

  bool get useDarkMode => _sharedPreferences.getBool(_useDarkModeKey) ?? false;

  int get icolor =>
      _sharedPreferences.getInt(_icolor) ??
      math.Random().nextInt(Colors.primaries.length);

  set icolor(int value) => _sharedPreferences.setInt(_icolor, value);

  User get auth {
    String localJson = _sharedPreferences.getString(_auth);
    if (localJson == null) return null;
    return User.fromJsonMap(json.decode(localJson));
  }

  set auth(User user) {
    _sharedPreferences.setString(
        _auth, user == null ? null : json.encode(user));
  }
}
