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

  void _setup() {
    this.fetchLatest();
    this.fetchWecahtLatest();
  }
}
