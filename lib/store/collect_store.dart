import 'package:fun_wanandroid/model/article.dart';
import 'package:fun_wanandroid/service/wan_android_repository.dart';
import 'package:fun_wanandroid/store/abs_page_store.dart';

class CollectStore extends PageStore<Article> {

  CollectStore();

  @override
  Article map(item) {
    return Article.fromMap(item);
  }

  @override
  Future<Map<String, dynamic>> load({int page}) {
    return WanAndroidRepository.fetchCollect(page);
  }
}
