import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fun_wanandroid/generated/i18n.dart';
import 'package:fun_wanandroid/store/preferences_service.dart';
import 'package:mobx/mobx.dart';

part 'settings_store.g.dart';

class SettingsStore = _SettingsStore with _$SettingsStore;

abstract class _SettingsStore with Store {
  var _disposer;

  _SettingsStore(this._preferencesService) {
    _setup();
  }

  final PreferencesService _preferencesService;

  @observable
  bool useDarkMode = false;

  @observable
  Locale locale;

  @action
  Future<void> setDarkMode({@required bool value}) async {
    _preferencesService.useDarkMode = value;
    useDarkMode = value;
  }

  @action
  Future<void> setLocale({@required Locale value}) async {
    if (value.languageCode == locale?.languageCode) return;
    _preferencesService.locale = value;
    locale = value;
  }

  _setup() {
    useDarkMode = _preferencesService.useDarkMode;
    locale = _preferencesService.locale;
    _disposer = autorun((_) {
      I18n.locale = locale;
    });
  }

  @override
  void dispose() {
    super.dispose();
    _disposer.dispose();
  }
}
