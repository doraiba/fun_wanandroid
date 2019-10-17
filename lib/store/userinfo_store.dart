import 'package:fun_wanandroid/service/wan_android_repository.dart';
import 'package:mobx/mobx.dart';

part 'userinfo_store.g.dart';

class UserInfoStore = _UserInfoStore with _$UserInfoStore;

abstract class _UserInfoStore with Store {
  final CoinStore coinStore = CoinStore();
  final ArticleStore articleStore = ArticleStore();

  Future<void> refresh() async {
    await coinStore.refresh();
  }
}

class CoinStore = _CoinStore with _$CoinStore;

abstract class _CoinStore with Store {
  _CoinStore() {
    _setup();
  }

  refresh() async {
    await fetchCoin();
  }

  @observable
  ObservableFuture<int> coinFuture;

  Future<int> fetchCoin() async {
    final _future = ObservableFuture(WanAndroidRepository.fetchCoin());
    return coinFuture = _future;
  }

  void _setup() async {
    refresh();
  }
}

class ArticleStore = _ArticleStore with _$ArticleStore;

abstract class _ArticleStore with Store {
  _ArticleStore() {
    _setup();
  }

  @observable
  ObservableFuture<int> shareFuture;

  @action
  Future<int> fetchShare() async {
    final _future = ObservableFuture(
        WanAndroidRepository.fetchShare(1).then((map) => map['total']));
    return shareFuture = _future;
  }

  @observable
  ObservableFuture<int> collectFuture;
  @action
  Future<int> fetchCollect() async {
    final _future = ObservableFuture(
        WanAndroidRepository.fetchCollect(1).then((map) => map['total']));
    return collectFuture = _future;
  }

  @observable
  ObservableFuture websiteFuture;
  @action
  Future<int> fetchWebsite() async {
    final _future =
        ObservableFuture(WanAndroidRepository.fetchSite().asStream().length);
    return websiteFuture = _future;
  }

  _setup() async {
    refresh();
  }

  Future<void> refresh() async {
    fetchShare();
    fetchCollect();
    fetchWebsite();
  }
}
