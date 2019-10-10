// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ProjectStore on _ProjectStore, Store {
  final _$treesFutureAtom = Atom(name: '_ProjectStore.treesFuture');

  @override
  ObservableFuture<List<Tree>> get treesFuture {
    _$treesFutureAtom.context.enforceReadPolicy(_$treesFutureAtom);
    _$treesFutureAtom.reportObserved();
    return super.treesFuture;
  }

  @override
  set treesFuture(ObservableFuture<List<Tree>> value) {
    _$treesFutureAtom.context.conditionallyRunInAction(() {
      super.treesFuture = value;
      _$treesFutureAtom.reportChanged();
    }, _$treesFutureAtom, name: '${_$treesFutureAtom.name}_set');
  }

  final _$_ProjectStoreActionController =
      ActionController(name: '_ProjectStore');

  @override
  Future fetchLatest() {
    final _$actionInfo = _$_ProjectStoreActionController.startAction();
    try {
      return super.fetchLatest();
    } finally {
      _$_ProjectStoreActionController.endAction(_$actionInfo);
    }
  }
}
