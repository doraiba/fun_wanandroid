// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$HomeStore on _HomeStore, Store {
  final _$bannerFutureAtom = Atom(name: '_HomeStore.bannerFuture');

  @override
  ObservableFuture<List<NavBanner>> get bannerFuture {
    _$bannerFutureAtom.context.enforceReadPolicy(_$bannerFutureAtom);
    _$bannerFutureAtom.reportObserved();
    return super.bannerFuture;
  }

  @override
  set bannerFuture(ObservableFuture<List<NavBanner>> value) {
    _$bannerFutureAtom.context.conditionallyRunInAction(() {
      super.bannerFuture = value;
      _$bannerFutureAtom.reportChanged();
    }, _$bannerFutureAtom, name: '${_$bannerFutureAtom.name}_set');
  }

  final _$fetchBannerAsyncAction = AsyncAction('fetchBanner');

  @override
  Future<List<NavBanner>> fetchBanner() {
    return _$fetchBannerAsyncAction.run(() => super.fetchBanner());
  }

  final _$fetchTopAsyncAction = AsyncAction('fetchTop');

  @override
  Future<List<Article>> fetchTop() {
    return _$fetchTopAsyncAction.run(() => super.fetchTop());
  }
}
