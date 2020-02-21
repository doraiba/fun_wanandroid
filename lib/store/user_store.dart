import 'package:fun_wanandroid/model/user.dart';
import 'package:fun_wanandroid/service/wan_android_repository.dart';
import 'package:fun_wanandroid/store/preferences_service.dart';
import 'package:mobx/mobx.dart';

part 'user_store.g.dart';

class UserStore = _UserStore with _$UserStore;

abstract class _UserStore with Store {
  PreferencesService _preferencesService;

  List<ReactionDisposer> disposers;

  _UserStore(this._preferencesService) {
    _setup();
  }

  void _setup() {
    lastLoginName = _preferencesService.lastLoginName;
    auth = _preferencesService.auth;
    this.disposers = [
      autorun((_) => this.collectIds.addAll(auth?.collectIds ?? <Object>[])),
      reaction((_) => this.collectIds.length, (__) {
        if (this.auth == null) {
          return;
        }
        this.auth.collectIds = this.collectIds;
        this.setAuth(value: this.auth);
      })
    ];
  }

  @override
  void dispose() {
    super.dispose();
    this?.disposers?.forEach((element) {
      element();
    });
  }

  /// 最后一次登录成功的登录名
  @observable
  String lastLoginName;

  @observable
  User auth;

  List<Object> collectIds = ObservableList<Object>.of(<Object>[]);

  bool hasFav(Object id) {
    return this.collectIds.contains(id);
  }

  Future<void> removeFav(Object id) async {
    runInAction(() => this.collectIds.remove(id));
    try {
      await WanAndroidRepository.unCollect(id);
    } catch (_) {
      runInAction(() => this.collectIds.insert(0, id));
    }
  }

  Future<void> like(Object id) async {
    runInAction(() => this.collectIds.insert(0, id));
    try {
      await WanAndroidRepository.collect(id);
    } catch (_) {
      runInAction(() => this.collectIds.remove(id));
    }
  }

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
    this.collectIds.clear();
  }
}
