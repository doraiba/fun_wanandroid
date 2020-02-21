import 'package:fun_wanandroid/model/article.dart';
import 'package:fun_wanandroid/service/wan_android_repository.dart';
import 'package:fun_wanandroid/store/abs_page_store.dart';

class ShareStore extends PageStore<Article> {

  ShareStore();
  @override
  Article map(item) {
    return Article.fromMap(item);
  }

  @override
  Future<Map<String, dynamic>> load({int page}) {
    return WanAndroidRepository.fetchShare(page);
  }
}
