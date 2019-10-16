// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'signin_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$SignInStore on _SignInStore, Store {
  final _$autovalidateAtom = Atom(name: '_SignInStore.autovalidate');

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

  final _$watchAtom = Atom(name: '_SignInStore.watch');

  @override
  bool get watch {
    _$watchAtom.context.enforceReadPolicy(_$watchAtom);
    _$watchAtom.reportObserved();
    return super.watch;
  }

  @override
  set watch(bool value) {
    _$watchAtom.context.conditionallyRunInAction(() {
      super.watch = value;
      _$watchAtom.reportChanged();
    }, _$watchAtom, name: '${_$watchAtom.name}_set');
  }

  final _$usernameAtom = Atom(name: '_SignInStore.username');

  @override
  String get username {
    _$usernameAtom.context.enforceReadPolicy(_$usernameAtom);
    _$usernameAtom.reportObserved();
    return super.username;
  }

  @override
  set username(String value) {
    _$usernameAtom.context.conditionallyRunInAction(() {
      super.username = value;
      _$usernameAtom.reportChanged();
    }, _$usernameAtom, name: '${_$usernameAtom.name}_set');
  }

  final _$passwordAtom = Atom(name: '_SignInStore.password');

  @override
  String get password {
    _$passwordAtom.context.enforceReadPolicy(_$passwordAtom);
    _$passwordAtom.reportObserved();
    return super.password;
  }

  @override
  set password(String value) {
    _$passwordAtom.context.conditionallyRunInAction(() {
      super.password = value;
      _$passwordAtom.reportChanged();
    }, _$passwordAtom, name: '${_$passwordAtom.name}_set');
  }

  final _$signFutureAtom = Atom(name: '_SignInStore.signFuture');

  @override
  ObservableFuture<User> get signFuture {
    _$signFutureAtom.context.enforceReadPolicy(_$signFutureAtom);
    _$signFutureAtom.reportObserved();
    return super.signFuture;
  }

  @override
  set signFuture(ObservableFuture<User> value) {
    _$signFutureAtom.context.conditionallyRunInAction(() {
      super.signFuture = value;
      _$signFutureAtom.reportChanged();
    }, _$signFutureAtom, name: '${_$signFutureAtom.name}_set');
  }

  final _$setWatchAsyncAction = AsyncAction('setWatch');

  @override
  Future setWatch(bool value) {
    return _$setWatchAsyncAction.run(() => super.setWatch(value));
  }

  final _$setAutovalidateAsyncAction = AsyncAction('setAutovalidate');

  @override
  Future setAutovalidate({@required bool value}) {
    return _$setAutovalidateAsyncAction
        .run(() => super.setAutovalidate(value: value));
  }

  final _$signAsyncAction = AsyncAction('sign');

  @override
  Future<User> sign({@required String username, @required String password}) {
    return _$signAsyncAction
        .run(() => super.sign(username: username, password: password));
  }
}
