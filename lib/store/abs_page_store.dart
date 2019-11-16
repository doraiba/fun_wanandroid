import 'package:mobx/mobx.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

part 'abs_page_store.g.dart';

abstract class PageStore<T> = _PageStore<T> with _$PageStore<T>;

abstract class _PageStore<T> with Store {
  final int initialPage;
  _PageStore({this.initialPage: 0}) : page = initialPage {
    _setup();
  }

  ReactionDisposer disposer;

  /// 初始化

  @observable
  ObservableList<T> list = ObservableList.of([]);
  @observable
  ObservableFuture<Map<String, dynamic>> fetchFutrue;

  /// 初始页数
  @observable
  int page;

  /// 默认请求数量 无用
  @observable
  int pageSize;

  /// 总数据
  @observable
  int total = 0;

  /// 页数 无用
  @computed
  int get pageCount => (total / pageSize ?? 0).ceil();
  @computed
  bool get has => (page + 1) < pageCount;

  void _setup() {
    disposer = autorun((_) => this.loadtemplate(page: this.page));
  }

  @override
  void dispose() {
    super.dispose();
    if (disposer != null) disposer();
  }

  @action
  void refresh() {
    this.page = initialPage;
  }

  @action
  void retry() {
    this.fetchFutrue = null;
    refresh();
  }

  @action
  void forward() {
    if (this.page >= pageCount) {
      return;
    }
    this.page++;
  }

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  RefreshController get refreshController => _refreshController;

  /// 基础模板
  @action
  Future<List<T>> loadtemplate({int page}) async {
    Map<String, dynamic> result;
    try {
      result = await load(page: page);
    } catch (e) {
      fetchFutrue = ObservableFuture.error(<String, dynamic>{});
      return list;
    }

    fetchFutrue = ObservableFuture.value(result);
    // page = result['curPage'];
    pageSize = result['size'];
    total = result['total'];

    final _list = result['datas'].map<T>(map).toList();
    if (page == this.initialPage) {
      list.clear();
    }
    list..addAll(_list);

    if (!has || page == this.initialPage) {
      if (page == this.initialPage) {
        refreshController.refreshCompleted(resetFooterState: true);
      }
      if (!has) {
        refreshController.loadNoData();
      }
    } else {
      refreshController.loadComplete();
    }

    return list;
  }

  /// 泛型无法直接条用fromJson构造器,交由子类进行处理??????
  T map(item);

  /// 调用具体方法获取数据
  Future<Map<String, dynamic>> load({int page});
}
