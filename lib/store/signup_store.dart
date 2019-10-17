import 'package:flutter/material.dart';
import 'package:fun_wanandroid/generated/i18n.dart';
import 'package:fun_wanandroid/model/user.dart';
import 'package:fun_wanandroid/service/wan_android_repository.dart';
import 'package:fun_wanandroid/store/c_form_field.dart';
import 'package:mobx/mobx.dart';
import 'package:validators/validators.dart';

part 'signup_store.g.dart';

class SignUpField {
  static final String username = 'username';
  static final String password = 'password';
  static final String repassword = 'repassword';
}

class SignUpStore = _SignUpStore with _$SignUpStore;

abstract class _SignUpStore with Store, SignUpField {
  /// 挂在一个根节点方便获取context  用来做国际化
  GlobalKey<dynamic> gKey = GlobalKey();

  get context => gKey.currentContext;

  @observable
  bool autovalidate = false;

  @observable
  ObservableFuture<User> signUpFuture;

  @action
  Future<User> signup(
      {@required String username,
      @required String password,
      @required String repassword}) async {
    return signUpFuture = ObservableFuture(
        WanAndroidRepository.register(username, password, repassword));
  }

  @observable
  ObservableList<CFormField> list;

  List<ReactionDisposer> _disposers;
  _SignUpStore() {
    _setup();
  }

  void _setup() {
    list = ObservableList.of([
      CFormField(
          prefixIconData: Icons.perm_identity,
          name: SignUpField.username,
          validFunction: validUsername,
          hintText: (context) => I18n.of(context).userName),
      CFormField(
          obscureText: true,
          prefixIconData: Icons.lock,
          name: SignUpField.password,
          validFunction: validPassword,
          hintText: (context) => I18n.of(context).password),
      CFormField(
          obscureText: true,
          prefixIconData: Icons.lock,
          name: SignUpField.repassword,
          validFunction: validRepassword,
          hintText: (context) => I18n.of(context).rePassword),
    ]);
  }

  @override
  void dispose() {
    super.dispose();
    _disposers?.forEach((d) => d());
  }

  @action
  Future validUsername(String val) async {
    if (isNull(val) || val.isEmpty) {
      return I18n.of(context).fieldNotNull;
    }
    return null;
  }

  @action
  Future validPassword(String val) async {
    if (isNull(val) || val.isEmpty) {
      return I18n.of(context).fieldNotNull;
    }
    return null;
  }

  @action
  Future<String> validRepassword(String val) async {
    if (isNull(val) || val.isEmpty) {
      return I18n.of(context).fieldNotNull;
    }
    String password =
        list.firstWhere((e) => e.name == SignUpField.password).value;
    if (val != password) {
      return I18n.of(context).twoPwdDifferent;
    }
    return null;
  }

  @action
  void Function() submit(Function(Map<String, dynamic>) call) {
    return () async {
      if (!autovalidate) {
        autovalidate = !autovalidate;

        _disposers =
            list.map((e) => reaction((_) => e.value, e.validFunc)).toList();
      }

      await Future.wait(
          List.generate(list.length, (i) => list[i].validFunc(list[i].value)));

      bool valid = list.every((e) => e.valid);
      if (!valid) {
        return;
      }
      Map<String, dynamic> map =
          Map.fromIterable(list, key: (e) => e.name, value: (e) => e.value);
      call(map);
    };
  }
}
