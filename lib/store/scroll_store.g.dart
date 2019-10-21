// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scroll_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ScrollStore on _ScrollStore, Store {
  Computed<bool> _$overHeavenComputed;

  @override
  bool get overHeaven =>
      (_$overHeavenComputed ??= Computed<bool>(() => super.overHeaven)).value;

  final _$scrollOffsetAtom = Atom(name: '_ScrollStore.scrollOffset');

  @override
  double get scrollOffset {
    _$scrollOffsetAtom.context.enforceReadPolicy(_$scrollOffsetAtom);
    _$scrollOffsetAtom.reportObserved();
    return super.scrollOffset;
  }

  @override
  set scrollOffset(double value) {
    _$scrollOffsetAtom.context.conditionallyRunInAction(() {
      super.scrollOffset = value;
      _$scrollOffsetAtom.reportChanged();
    }, _$scrollOffsetAtom, name: '${_$scrollOffsetAtom.name}_set');
  }

  final _$_ScrollStoreActionController = ActionController(name: '_ScrollStore');

  @override
  void setScrollOffset(double scrollOffset) {
    final _$actionInfo = _$_ScrollStoreActionController.startAction();
    try {
      return super.setScrollOffset(scrollOffset);
    } finally {
      _$_ScrollStoreActionController.endAction(_$actionInfo);
    }
  }
}
