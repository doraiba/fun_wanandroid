import 'package:fun_wanandroid/model/tree.dart';
import 'package:fun_wanandroid/service/wan_android_repository.dart';
import 'package:mobx/mobx.dart';
part 'project_store.g.dart';

class ProjectStore = _ProjectStore with _$ProjectStore;

abstract class _ProjectStore with Store {
  _ProjectStore() {
    this.fetchLatest();
  }

  @observable
  ObservableFuture<List<Tree>> treesFuture;

  @action
  Future fetchLatest() => treesFuture =
      ObservableFuture(WanAndroidRepository.fetchProjectCategories());
}
