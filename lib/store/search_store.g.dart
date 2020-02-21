// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$SearchStore on _SearchStore, Store {
  final _$lastQueryAtom = Atom(name: '_SearchStore.lastQuery');

  @override
  String get lastQuery {
    _$lastQueryAtom.context.enforceReadPolicy(_$lastQueryAtom);
    _$lastQueryAtom.reportObserved();
    return super.lastQuery;
  }

  @override
  set lastQuery(String value) {
    _$lastQueryAtom.context.conditionallyRunInAction(() {
      super.lastQuery = value;
      _$lastQueryAtom.reportChanged();
    }, _$lastQueryAtom, name: '${_$lastQueryAtom.name}_set');
  }

  final _$searchHotFutureAtom = Atom(name: '_SearchStore.searchHotFuture');

  @override
  ObservableFuture<List<SearchHotKey>> get searchHotFuture {
    _$searchHotFutureAtom.context.enforceReadPolicy(_$searchHotFutureAtom);
    _$searchHotFutureAtom.reportObserved();
    return super.searchHotFuture;
  }

  @override
  set searchHotFuture(ObservableFuture<List<SearchHotKey>> value) {
    _$searchHotFutureAtom.context.conditionallyRunInAction(() {
      super.searchHotFuture = value;
      _$searchHotFutureAtom.reportChanged();
    }, _$searchHotFutureAtom, name: '${_$searchHotFutureAtom.name}_set');
  }

  final _$_SearchStoreActionController = ActionController(name: '_SearchStore');

  @override
  void insert(String q) {
    final _$actionInfo = _$_SearchStoreActionController.startAction();
    try {
      return super.insert(q);
    } finally {
      _$_SearchStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  bool remove(String q) {
    final _$actionInfo = _$_SearchStoreActionController.startAction();
    try {
      return super.remove(q);
    } finally {
      _$_SearchStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void clear() {
    final _$actionInfo = _$_SearchStoreActionController.startAction();
    try {
      return super.clear();
    } finally {
      _$_SearchStoreActionController.endAction(_$actionInfo);
    }
  }
}
