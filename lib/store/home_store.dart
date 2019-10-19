import 'package:fun_wanandroid/helper/event_bus_helper.dart';
import 'package:mobx/mobx.dart' hide Observable;

part 'home_store.g.dart';

class HomeStore = _HomeStore with _$HomeStore;

abstract class _HomeStore with Store {
  _HomeStore() {
    _setup();
  }

  void _setup() {
    Future.delayed(Duration(seconds: 13))
        .then((_) => behaviorBus.fire(AppLoadEvent()));
  }
}
