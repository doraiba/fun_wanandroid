import 'package:fun_wanandroid/model/user.dart';
import 'package:fun_wanandroid/service/wan_android_repository.dart';
import 'package:fun_wanandroid/store/preferences_service.dart';
import 'package:mobx/mobx.dart';

part 'user_store.g.dart';

class UserStore = _UserStore with _$UserStore;

abstract class _UserStore with Store {
  PreferencesService _preferencesService;

  _UserStore(this._preferencesService) {
    _setup();
  }

  void _setup() {
    lastLoginName = _preferencesService.lastLoginName;
    auth = _preferencesService.auth;
  }

  /// 最后一次登录成功的登录名
  @observable
  String lastLoginName;

  @observable
  User auth;

  @action
  Future setAuth({User value}) async {
    _preferencesService.auth = value;
    auth = value;
  }

  @action
  Future<void> setLastLoginName(String name) async {
    _preferencesService.lastLoginName = name;
    lastLoginName = name;
  }

  @action
  Future logout() async {
    await WanAndroidRepository.logout();
    this.setAuth(value: null);
  }
}
