// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'abs_page_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$PageStore<T> on _PageStore<T>, Store {
  Computed<int> _$pageCountComputed;

  @override
  int get pageCount =>
      (_$pageCountComputed ??= Computed<int>(() => super.pageCount)).value;
  Computed<bool> _$hasComputed;

  @override
  bool get has => (_$hasComputed ??= Computed<bool>(() => super.has)).value;

  final _$listAtom = Atom(name: '_PageStore.list');

  @override
  ObservableList<T> get list {
    _$listAtom.context.enforceReadPolicy(_$listAtom);
    _$listAtom.reportObserved();
    return super.list;
  }

  @override
  set list(ObservableList<T> value) {
    _$listAtom.context.conditionallyRunInAction(() {
      super.list = value;
      _$listAtom.reportChanged();
    }, _$listAtom, name: '${_$listAtom.name}_set');
  }

  final _$fetchFutrueAtom = Atom(name: '_PageStore.fetchFutrue');

  @override
  ObservableFuture<Map<String, dynamic>> get fetchFutrue {
    _$fetchFutrueAtom.context.enforceReadPolicy(_$fetchFutrueAtom);
    _$fetchFutrueAtom.reportObserved();
    return super.fetchFutrue;
  }

  @override
  set fetchFutrue(ObservableFuture<Map<String, dynamic>> value) {
    _$fetchFutrueAtom.context.conditionallyRunInAction(() {
      super.fetchFutrue = value;
      _$fetchFutrueAtom.reportChanged();
    }, _$fetchFutrueAtom, name: '${_$fetchFutrueAtom.name}_set');
  }

  final _$pageAtom = Atom(name: '_PageStore.page');

  @override
  int get page {
    _$pageAtom.context.enforceReadPolicy(_$pageAtom);
    _$pageAtom.reportObserved();
    return super.page;
  }

  @override
  set page(int value) {
    _$pageAtom.context.conditionallyRunInAction(() {
      super.page = value;
      _$pageAtom.reportChanged();
    }, _$pageAtom, name: '${_$pageAtom.name}_set');
  }

  final _$pageSizeAtom = Atom(name: '_PageStore.pageSize');

  @override
  int get pageSize {
    _$pageSizeAtom.context.enforceReadPolicy(_$pageSizeAtom);
    _$pageSizeAtom.reportObserved();
    return super.pageSize;
  }

  @override
  set pageSize(int value) {
    _$pageSizeAtom.context.conditionallyRunInAction(() {
      super.pageSize = value;
      _$pageSizeAtom.reportChanged();
    }, _$pageSizeAtom, name: '${_$pageSizeAtom.name}_set');
  }

  final _$totalAtom = Atom(name: '_PageStore.total');

  @override
  int get total {
    _$totalAtom.context.enforceReadPolicy(_$totalAtom);
    _$totalAtom.reportObserved();
    return super.total;
  }

  @override
  set total(int value) {
    _$totalAtom.context.conditionallyRunInAction(() {
      super.total = value;
      _$totalAtom.reportChanged();
    }, _$totalAtom, name: '${_$totalAtom.name}_set');
  }

  final _$loadtemplateAsyncAction = AsyncAction('loadtemplate');

  @override
  Future<List<T>> loadtemplate({int page = _PageStore.initialPage}) {
    return _$loadtemplateAsyncAction.run(() => super.loadtemplate(page: page));
  }

  final _$_PageStoreActionController = ActionController(name: '_PageStore');

  @override
  void refresh() {
    final _$actionInfo = _$_PageStoreActionController.startAction();
    try {
      return super.refresh();
    } finally {
      _$_PageStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void retry() {
    final _$actionInfo = _$_PageStoreActionController.startAction();
    try {
      return super.retry();
    } finally {
      _$_PageStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void forward() {
    final _$actionInfo = _$_PageStoreActionController.startAction();
    try {
      return super.forward();
    } finally {
      _$_PageStoreActionController.endAction(_$actionInfo);
    }
  }
}
