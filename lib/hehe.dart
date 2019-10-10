import 'package:mobx/mobx.dart';

void main() async {

  var a = Future.value(0);
  var b = ObservableFuture(a);
  print(b.status);
}
