import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fun_wanandroid/generated/i18n.dart';
import 'package:fun_wanandroid/store/preferences_service.dart';
import 'package:mobx/mobx.dart';

part 'settings_store.g.dart';

/// 系统设置相关
class SettingsStore = _SettingsStore with _$SettingsStore;

abstract class _SettingsStore with Store {
  
  var _disposer;

  _SettingsStore(this._preferencesService) {
    _setup();
  }

  final PreferencesService _preferencesService;

  @observable
  bool useDarkMode = false;

  @action
  Future<void> setDarkMode({@required bool value}) async {
    _preferencesService.useDarkMode = value;
    useDarkMode = value;
  }

  @observable
  Locale locale;

  @action
  Future<void> setLocale({@required Locale value}) async {
    if (value == locale) return;
    _preferencesService.locale = value;
    locale = value;
  }

  @observable
  int icolor;

  @action
  Future<void> setIColor({@required int value}) async {
    if (value == icolor) return;
    _preferencesService.icolor = value;
    icolor = value;
  }

  _setup() {
    useDarkMode = _preferencesService.useDarkMode;
    locale = _preferencesService.locale;
    icolor = _preferencesService.icolor;
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
