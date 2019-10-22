import 'package:fun_wanandroid/helper/event_bus_helper.dart';
import 'package:fun_wanandroid/model/article.dart';
import 'package:fun_wanandroid/model/nav_banner.dart';
import 'package:fun_wanandroid/service/wan_android_repository.dart';
import 'package:fun_wanandroid/store/abs_page_store.dart';
import 'package:mobx/mobx.dart' hide Observable;

part 'home_store.g.dart';

class HomeStore = _HomeStore with _$HomeStore;

abstract class _HomeStore extends PageStore<Article> with Store {
  _HomeStore() {
    _setup();
  }

  void _setup() async {
    // Future.doWhile(()=>)
    Future.wait(<Future>[
      fetchBanner(),
      fetchTop(),
      Future.doWhile(() => Future.delayed(
              Duration(milliseconds: 300), () => super.fetchFutrue == null))
          .then((_) => super.fetchFutrue)
    ]).then((_) {
      behaviorBus.fire(AppLoadEvent());
    });
  }

  @observable
  ObservableFuture<List<NavBanner>> bannerFuture;

  @action
  Future<List<NavBanner>> fetchBanner() async {
    return bannerFuture = ObservableFuture(WanAndroidRepository.fetchBanners());
  }

  @observable
  ObservableFuture<List<Article>> topFuture;

  @action
  Future<List<Article>> fetchTop() async {
    final _future = WanAndroidRepository.fetchTopArticles();
    return topFuture = ObservableFuture.value(await _future);
  }

  @override
  Future<Map<String, dynamic>> load({int page}) {
    return WanAndroidRepository.fetchArticles(page);
  }

  @override
  Article map(item) {
    return Article.fromMap(item);
  }
}
