import 'package:flutter/material.dart';
import 'package:fun_wanandroid/generated/i18n.dart';
import 'package:mobx/mobx.dart';
import 'package:validators/validators.dart';

part 'signup_store.g.dart';

class SignUpStore = _SignUpStore with _$SignUpStore;

abstract class _SignUpStore with Store {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  get context => formKey.currentContext;

  @observable
  bool autovalidate = false;

  static final String username = 'username';
  static final String password = 'password';
  static final String repassword = 'repassword';

  @observable
  ObservableMap<String, FormField> map = ObservableMap.of(<String, FormField>{
    username: FormField(),
    password: FormField(),
    repassword: FormField()
  });

  List<ReactionDisposer> _disposers;
  _SignUpStore() {
    // _disposers = [
    //   reaction((_) => map[username].value, validUsername),
    //   reaction((_) => map[password].value, validPassword),
    //   reaction((_) => map[repassword].value, validRepassword),
    // ];
  }

  @override
  void dispose() {
    super.dispose();
    _disposers?.forEach((d) => d());
  }

  @action
  Future validUsername(String val) async {
    if (isNull(val) || val.isEmpty) {
      map[username].error = I18n.of(context).fieldNotNull;
      return;
    }
    map[username].error = null;
  }

  @action
  Future validPassword(String val) async {
    if (isNull(val) || val.isEmpty) {
      map[password].error = I18n.of(context).fieldNotNull;
      return;
    }
    map[password].error = null;
  }

  @action
  Future validRepassword(String val) async {
    if (isNull(val) || val.isEmpty) {
      map[repassword].error = I18n.of(context).fieldNotNull;
      return;
    }
    // Future.value(123).
    if (map[password] != map[repassword]) {
      map[repassword].error = I18n.of(context).twoPwdDifferent;
      return;
    }
    map[repassword].error = null;
  }

  @action
  void Function() submit(Function(String username, String password) call) {
    return () async {
      if (!autovalidate) {
        autovalidate = !autovalidate;
        _disposers = [
          reaction((_) => map[username].value, validUsername),
          reaction((_) => map[password].value, validPassword),
          reaction((_) => map[repassword].value, validRepassword),
        ];
      }
      await validUsername(map[username].value);
      await validPassword(map[password].value);
      await validRepassword(map[repassword].value);
      bool valid = map.entries.every((e) => e.value.valid);
      if (!valid) {
        map.entries.forEach((e) => print('${e.key}:${e.value.value}'));
        return;
      }

      call(username, password);
    };
  }
}

class FormField = _FormField with _$FormField;

abstract class _FormField with Store {
  @observable
  String value;
  @observable
  String error;
  @computed
  bool get valid => isNull(error) || error.isEmpty;
}
