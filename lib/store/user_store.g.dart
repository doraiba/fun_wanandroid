// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$UserStore on _UserStore, Store {
  final _$lastLoginNameAtom = Atom(name: '_UserStore.lastLoginName');

  @override
  String get lastLoginName {
    _$lastLoginNameAtom.context.enforceReadPolicy(_$lastLoginNameAtom);
    _$lastLoginNameAtom.reportObserved();
    return super.lastLoginName;
  }

  @override
  set lastLoginName(String value) {
    _$lastLoginNameAtom.context.conditionallyRunInAction(() {
      super.lastLoginName = value;
      _$lastLoginNameAtom.reportChanged();
    }, _$lastLoginNameAtom, name: '${_$lastLoginNameAtom.name}_set');
  }

  final _$authAtom = Atom(name: '_UserStore.auth');

  @override
  User get auth {
    _$authAtom.context.enforceReadPolicy(_$authAtom);
    _$authAtom.reportObserved();
    return super.auth;
  }

  @override
  set auth(User value) {
    _$authAtom.context.conditionallyRunInAction(() {
      super.auth = value;
      _$authAtom.reportChanged();
    }, _$authAtom, name: '${_$authAtom.name}_set');
  }

  final _$setAuthAsyncAction = AsyncAction('setAuth');

  @override
  Future setAuth({User value}) {
    return _$setAuthAsyncAction.run(() => super.setAuth(value: value));
  }

  final _$setLastLoginNameAsyncAction = AsyncAction('setLastLoginName');

  @override
  Future<void> setLastLoginName(String name) {
    return _$setLastLoginNameAsyncAction
        .run(() => super.setLastLoginName(name));
  }

  final _$logoutAsyncAction = AsyncAction('logout');

  @override
  Future logout() {
    return _$logoutAsyncAction.run(() => super.logout());
  }
}
