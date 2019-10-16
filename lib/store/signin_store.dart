import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fun_wanandroid/generated/i18n.dart';
import 'package:fun_wanandroid/model/user.dart';
import 'package:fun_wanandroid/service/wan_android_repository.dart';
import 'package:mobx/mobx.dart';
import 'package:validators/validators.dart';

part 'signin_store.g.dart';

class SignInStore = _SignInStore with _$SignInStore;

abstract class _SignInStore with Store {
  GlobalKey<FormState> signInFormKey = GlobalKey<FormState>();

  get context => signInFormKey.currentContext;

  @observable
  bool autovalidate = false;

  @observable
  bool watch = true;

  @action
  Future setWatch(bool value) async {
    this.watch = value;
  }

  @action
  Future setAutovalidate({@required bool value}) async {
    this.autovalidate = value;
  }

  @observable
  String username;
  @observable
  String password;

  String validUserName(String value) {
    if (isNull(value) || value.isEmpty) {
      return I18n.of(context).fieldNotNull;
    }
    return null;
  }

  String validPassWord(String value) {
    if (isNull(value) || value.isEmpty) {
      return I18n.of(context).fieldNotNull;
    }
    return null;
  }

  submit(void notify(username, password)) {
    return () async {
      signInFormKey.currentState.save();
      bool valid = signInFormKey.currentState.validate();
      if (!valid) {
        if (!autovalidate) setAutovalidate(value: !valid);
        return;
      }
      notify(username, password);
    };
  }

  @observable
  ObservableFuture<User> signFuture;

  @action
  Future<User> sign(
      {@required String username, @required String password}) async {
    return signFuture =
        ObservableFuture(WanAndroidRepository.login(username, password));
  }
}
