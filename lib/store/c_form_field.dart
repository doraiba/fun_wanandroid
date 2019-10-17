import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

part 'c_form_field.g.dart';

class CFormField = _CFormField with _$CFormField;

typedef FutureFunc = Future Function(String);

abstract class _CFormField with Store {
  @observable
  String name;
  @observable
  String value;
  @observable
  String error;
  @observable
  bool obscureText;

  final IconData prefixIconData;

  final String Function(BuildContext) hintText;

  final FutureFunc validFunction;
  @action
  Future<void> validFunc(String val) async {
    var fn = validFunction ?? (String val) async => null;
    String error = await fn(val);
    this.error = error;
  }

  _CFormField(
      {@required this.name,
      @required this.validFunction,
      @required this.hintText,
      this.prefixIconData: Icons.list,
      this.obscureText: false});

  @computed
  bool get valid => error == null || error.isEmpty;
}
