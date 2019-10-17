// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'userinfo_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$UserInfoStore on _UserInfoStore, Store {}

mixin _$CoinStore on _CoinStore, Store {
  final _$coinFutureAtom = Atom(name: '_CoinStore.coinFuture');

  @override
  ObservableFuture<int> get coinFuture {
    _$coinFutureAtom.context.enforceReadPolicy(_$coinFutureAtom);
    _$coinFutureAtom.reportObserved();
    return super.coinFuture;
  }

  @override
  set coinFuture(ObservableFuture<int> value) {
    _$coinFutureAtom.context.conditionallyRunInAction(() {
      super.coinFuture = value;
      _$coinFutureAtom.reportChanged();
    }, _$coinFutureAtom, name: '${_$coinFutureAtom.name}_set');
  }
}

mixin _$ArticleStore on _ArticleStore, Store {
  final _$shareFutureAtom = Atom(name: '_ArticleStore.shareFuture');

  @override
  ObservableFuture<int> get shareFuture {
    _$shareFutureAtom.context.enforceReadPolicy(_$shareFutureAtom);
    _$shareFutureAtom.reportObserved();
    return super.shareFuture;
  }

  @override
  set shareFuture(ObservableFuture<int> value) {
    _$shareFutureAtom.context.conditionallyRunInAction(() {
      super.shareFuture = value;
      _$shareFutureAtom.reportChanged();
    }, _$shareFutureAtom, name: '${_$shareFutureAtom.name}_set');
  }

  final _$collectFutureAtom = Atom(name: '_ArticleStore.collectFuture');

  @override
  ObservableFuture<int> get collectFuture {
    _$collectFutureAtom.context.enforceReadPolicy(_$collectFutureAtom);
    _$collectFutureAtom.reportObserved();
    return super.collectFuture;
  }

  @override
  set collectFuture(ObservableFuture<int> value) {
    _$collectFutureAtom.context.conditionallyRunInAction(() {
      super.collectFuture = value;
      _$collectFutureAtom.reportChanged();
    }, _$collectFutureAtom, name: '${_$collectFutureAtom.name}_set');
  }

  final _$websiteFutureAtom = Atom(name: '_ArticleStore.websiteFuture');

  @override
  ObservableFuture<int> get websiteFuture {
    _$websiteFutureAtom.context.enforceReadPolicy(_$websiteFutureAtom);
    _$websiteFutureAtom.reportObserved();
    return super.websiteFuture;
  }

  @override
  set websiteFuture(ObservableFuture<int> value) {
    _$websiteFutureAtom.context.conditionallyRunInAction(() {
      super.websiteFuture = value;
      _$websiteFutureAtom.reportChanged();
    }, _$websiteFutureAtom, name: '${_$websiteFutureAtom.name}_set');
  }

  final _$fetchShareAsyncAction = AsyncAction('fetchShare');

  @override
  Future<int> fetchShare() {
    return _$fetchShareAsyncAction.run(() => super.fetchShare());
  }

  final _$fetchCollectAsyncAction = AsyncAction('fetchCollect');

  @override
  Future<int> fetchCollect() {
    return _$fetchCollectAsyncAction.run(() => super.fetchCollect());
  }

  final _$fetchWebsiteAsyncAction = AsyncAction('fetchWebsite');

  @override
  Future<int> fetchWebsite() {
    return _$fetchWebsiteAsyncAction.run(() => super.fetchWebsite());
  }
}
