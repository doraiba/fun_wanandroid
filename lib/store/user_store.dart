import 'package:fun_wanandroid/model/user.dart';
import 'package:fun_wanandroid/store/preferences_service.dart';
import 'package:mobx/mobx.dart';

part 'user_store.g.dart';

class UserStore = _UserStore with _$UserStore;

abstract class _UserStore with Store {
  PreferencesService preferencesService;

  /// 最后一次登录成功的登录名
  @observable
  String lastLoginName;

  @observable
  User auth;

  @action
  Future<void> setLastLoginName(String name) async {
    preferencesService.lastLoginName = name;
    lastLoginName = name;
  }

  _UserStore(this.preferencesService) {
    _setup();
  }

  void _setup() {
    lastLoginName = preferencesService.lastLoginName;
    auth = preferencesService.auth;
  }
}
