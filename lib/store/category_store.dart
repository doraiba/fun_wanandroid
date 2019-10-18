import 'package:fun_wanandroid/model/navigation_site.dart';
import 'package:fun_wanandroid/model/tree.dart';
import 'package:fun_wanandroid/service/wan_android_repository.dart';
import 'package:mobx/mobx.dart';
part 'category_store.g.dart';

class CategorytStore = _CategorytStore with _$CategorytStore;

abstract class _CategorytStore with Store {
  _CategorytStore() {
    _setup();
  }

  ///==============================project=================
  @observable
  ObservableFuture<List<Tree>> treesFuture;

  @action
  Future fetchLatest() => treesFuture =
      ObservableFuture(WanAndroidRepository.fetchProjectCategories());

  ///==============================project=================

  ///==============================wechat=================
  @observable
  ObservableFuture<List<Tree>> wechatFuture;

  @action
  Future fetchWecahtLatest() => wechatFuture =
      ObservableFuture(WanAndroidRepository.fetchWechatAccounts());

  ///==============================wechat=================

  ///==============================体系=================
  @observable
  ObservableFuture<List<Tree>> structureFuture;
  @action
  Future fetchStructureLatest() => structureFuture =
      ObservableFuture(WanAndroidRepository.fetchTreeCategories());

  ///==============================体系=================

  ///==============================导航=================
  @observable
  ObservableFuture<List<NavigationSite>> navigtorFuture;
  @action
  Future fetchNavigtorLatest() => navigtorFuture =
      ObservableFuture(WanAndroidRepository.fetchNavigationSite());

  ///==============================导航=================

  void _setup() {
    this.fetchLatest();
    this.fetchWecahtLatest();
    this.fetchStructureLatest();
    this.fetchNavigtorLatest();
  }
}
