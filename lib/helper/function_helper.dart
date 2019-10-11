import 'package:flutter/material.dart';

typedef AnyReturnBuilder<T, R> = R Function(T t);
R themeFunction<R>(BuildContext context, AnyReturnBuilder<bool, R> builder) {
  return builder(Theme.of(context).brightness == Brightness.dark);
}

R themeSupplier<R>(BuildContext context, {R truth, R fal}) {
  return themeFunction<R>(context, (isDark) => isDark ? truth : fal);
}

Color iconColorSupplier(BuildContext context) {
  return Theme.of(context).accentColor;
}
