// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'signup_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$SignUpStore on _SignUpStore, Store {
  final _$autovalidateAtom = Atom(name: '_SignUpStore.autovalidate');

  @override
  bool get autovalidate {
    _$autovalidateAtom.context.enforceReadPolicy(_$autovalidateAtom);
    _$autovalidateAtom.reportObserved();
    return super.autovalidate;
  }

  @override
  set autovalidate(bool value) {
    _$autovalidateAtom.context.conditionallyRunInAction(() {
      super.autovalidate = value;
      _$autovalidateAtom.reportChanged();
    }, _$autovalidateAtom, name: '${_$autovalidateAtom.name}_set');
  }

  final _$signUpFutureAtom = Atom(name: '_SignUpStore.signUpFuture');

  @override
  ObservableFuture<User> get signUpFuture {
    _$signUpFutureAtom.context.enforceReadPolicy(_$signUpFutureAtom);
    _$signUpFutureAtom.reportObserved();
    return super.signUpFuture;
  }

  @override
  set signUpFuture(ObservableFuture<User> value) {
    _$signUpFutureAtom.context.conditionallyRunInAction(() {
      super.signUpFuture = value;
      _$signUpFutureAtom.reportChanged();
    }, _$signUpFutureAtom, name: '${_$signUpFutureAtom.name}_set');
  }

  final _$listAtom = Atom(name: '_SignUpStore.list');

  @override
  ObservableList<CFormField> get list {
    _$listAtom.context.enforceReadPolicy(_$listAtom);
    _$listAtom.reportObserved();
    return super.list;
  }

  @override
  set list(ObservableList<CFormField> value) {
    _$listAtom.context.conditionallyRunInAction(() {
      super.list = value;
      _$listAtom.reportChanged();
    }, _$listAtom, name: '${_$listAtom.name}_set');
  }

  final _$signupAsyncAction = AsyncAction('signup');

  @override
  Future<User> signup(
      {@required String username,
      @required String password,
      @required String repassword}) {
    return _$signupAsyncAction.run(() => super.signup(
        username: username, password: password, repassword: repassword));
  }

  final _$validUsernameAsyncAction = AsyncAction('validUsername');

  @override
  Future validUsername(String val) {
    return _$validUsernameAsyncAction.run(() => super.validUsername(val));
  }

  final _$validPasswordAsyncAction = AsyncAction('validPassword');

  @override
  Future validPassword(String val) {
    return _$validPasswordAsyncAction.run(() => super.validPassword(val));
  }

  final _$validRepasswordAsyncAction = AsyncAction('validRepassword');

  @override
  Future<String> validRepassword(String val) {
    return _$validRepasswordAsyncAction.run(() => super.validRepassword(val));
  }

  final _$_SignUpStoreActionController = ActionController(name: '_SignUpStore');

  @override
  void Function() submit(dynamic Function(Map<String, dynamic>) call) {
    final _$actionInfo = _$_SignUpStoreActionController.startAction();
    try {
      return super.submit(call);
    } finally {
      _$_SignUpStoreActionController.endAction(_$actionInfo);
    }
  }
}
