import 'package:fun_wanandroid/model/article.dart';
import 'package:fun_wanandroid/model/search.dart';
import 'package:fun_wanandroid/service/wan_android_repository.dart';
import 'package:fun_wanandroid/store/abs_page_store.dart';
import 'package:fun_wanandroid/store/preferences_service.dart';
import 'package:mobx/mobx.dart';

part 'search_store.g.dart';

class SearchStore = _SearchStore with _$SearchStore;

abstract class _SearchStore extends PageStore with Store {
  @observable
  String lastQuery = '';

  List<String> repository = ObservableList.of(<String>[]);

  @observable
  ObservableFuture<List<SearchHotKey>> searchHotFuture;

  PreferencesService _preferencesService;

  _SearchStore(this._preferencesService) : super(initialRefresh: false) {
    _setup();
  }

  ReactionDisposer disposer;

  @override
  void dispose() {
    super.dispose();
    this?.disposer();
  }

  void _setup() {
    this.loadHotSearch();
    this.disposer =
            reaction((_) => this.lastQuery, (__){
               this.retry();
               this.insert(__);
            });
    List<String> repo = _preferencesService.searchRepository;
    if (repo == null) return;
    repository.addAll(repo);
  }
  /////////////分页/////////////////////////

  @override
  Future<Map<String, dynamic>> load({int page}) {
    return WanAndroidRepository.fetchSearchResult(
        pageNum: page, key: lastQuery);
  }

  @override
  Article map(item) {
    return Article.fromMap(item);
  }
  /////////////热门搜索/////////////////////////

  void loadHotSearch() async {
    Future<List<SearchHotKey>> _f =
        ObservableFuture(WanAndroidRepository.fetchSearchHotKey());
    await _f;
    searchHotFuture = _f;
  }

  /////////////本地搜索方法/////////////////////////
  @action
  void insert(String q) {
    this.repository.remove(q);
    this.repository.insert(0, q);
    if (repository.length > 9) {
      this.repository.removeRange(9, repository.length - 1);
    }
  }

  @action
  bool remove(String q) {
    return this.repository.remove(q);
  }

  @action
  void clear() {
    this.repository.clear();
  }
}
