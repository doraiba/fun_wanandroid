// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'c_form_field.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$CFormField on _CFormField, Store {
  Computed<bool> _$validComputed;

  @override
  bool get valid =>
      (_$validComputed ??= Computed<bool>(() => super.valid)).value;

  final _$nameAtom = Atom(name: '_CFormField.name');

  @override
  String get name {
    _$nameAtom.context.enforceReadPolicy(_$nameAtom);
    _$nameAtom.reportObserved();
    return super.name;
  }

  @override
  set name(String value) {
    _$nameAtom.context.conditionallyRunInAction(() {
      super.name = value;
      _$nameAtom.reportChanged();
    }, _$nameAtom, name: '${_$nameAtom.name}_set');
  }

  final _$valueAtom = Atom(name: '_CFormField.value');

  @override
  String get value {
    _$valueAtom.context.enforceReadPolicy(_$valueAtom);
    _$valueAtom.reportObserved();
    return super.value;
  }

  @override
  set value(String value) {
    _$valueAtom.context.conditionallyRunInAction(() {
      super.value = value;
      _$valueAtom.reportChanged();
    }, _$valueAtom, name: '${_$valueAtom.name}_set');
  }

  final _$errorAtom = Atom(name: '_CFormField.error');

  @override
  String get error {
    _$errorAtom.context.enforceReadPolicy(_$errorAtom);
    _$errorAtom.reportObserved();
    return super.error;
  }

  @override
  set error(String value) {
    _$errorAtom.context.conditionallyRunInAction(() {
      super.error = value;
      _$errorAtom.reportChanged();
    }, _$errorAtom, name: '${_$errorAtom.name}_set');
  }

  final _$obscureTextAtom = Atom(name: '_CFormField.obscureText');

  @override
  bool get obscureText {
    _$obscureTextAtom.context.enforceReadPolicy(_$obscureTextAtom);
    _$obscureTextAtom.reportObserved();
    return super.obscureText;
  }

  @override
  set obscureText(bool value) {
    _$obscureTextAtom.context.conditionallyRunInAction(() {
      super.obscureText = value;
      _$obscureTextAtom.reportChanged();
    }, _$obscureTextAtom, name: '${_$obscureTextAtom.name}_set');
  }

  final _$validFuncAsyncAction = AsyncAction('validFunc');

  @override
  Future<void> validFunc(String val) {
    return _$validFuncAsyncAction.run(() => super.validFunc(val));
  }
}
