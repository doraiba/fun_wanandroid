import 'package:fun_wanandroid/model/article.dart';
import 'package:fun_wanandroid/model/banner.dart';
import 'package:fun_wanandroid/model/coin_record.dart';
import 'package:fun_wanandroid/model/navigation_site.dart';
import 'package:fun_wanandroid/model/search.dart';
import 'package:fun_wanandroid/model/tree.dart';
import 'package:fun_wanandroid/model/user.dart';
import 'package:fun_wanandroid/helper/dio_helper.dart';

class WanAndroidRepository {
  // 轮播
  static Future fetchBanners() async {
    var response = await dio.get('banner/json');
    return response.data
        .map<Banner>((item) => Banner.fromJsonMap(item))
        .toList();
  }

  // 置顶文章
  static Future fetchTopArticles() async {
    var response = await dio.get('article/top/json');
    return response.data.map<Article>((item) => Article.fromMap(item)).toList();
  }

  // 文章
  static Future<Map<String, dynamic>> fetchArticles(int pageNum,
      {int cid}) async {
//    await Future.delayed(Duration(seconds: 1));
    var response = await dio.get('article/list/$pageNum/json',
        queryParameters: (cid != null ? {'cid': cid} : null));
    return response.data;
  }

  // 项目分类
  static Future<List<Tree>> fetchTreeCategories() async {
    var response = await dio.get('tree/json');
    return response.data.map<Tree>((item) => Tree.fromJsonMap(item)).toList();
  }

  // 体系分类
  static Future<List<Tree>> fetchProjectCategories() async {
    var response = await dio.get('project/tree/json');
    return response.data.map<Tree>((item) => Tree.fromJsonMap(item)).toList();
  }

  // 导航
  static Future<List<NavigationSite>> fetchNavigationSite() async {
    var response = await dio.get('navi/json');
    return response.data
        .map<NavigationSite>((item) => NavigationSite.fromMap(item))
        .toList();
  }

  // 公众号分类
  static Future<List<Tree>> fetchWechatAccounts() async {
    var response = await dio.get('wxarticle/chapters/json');
    return response.data.map<Tree>((item) => Tree.fromJsonMap(item)).toList();
  }

  // 公众号文章
  static Future<Map<String, dynamic>> fetchWechatAccountArticles(
      int pageNum, int id) async {
    var response = await dio.get('wxarticle/list/$id/$pageNum/json');
    return response.data;
    // ['datas'].map<Article>((item) => Article.fromMap(item))
    // .toList();
  }

  // 搜索热门记录
  static Future<List<SearchHotKey>> fetchSearchHotKey() async {
    var response = await dio.get('hotkey/json');
    return response.data
        .map<SearchHotKey>((item) => SearchHotKey.fromMap(item))
        .toList();
  }

  // 搜索结果
  static Future<List<Article>> fetchSearchResult(
      {key = "", int pageNum = 0}) async {
    var response =
        await dio.post<Map>('article/query/$pageNum/json', queryParameters: {
      'k': key,
    });
    return response.data['datas']
        .map<Article>((item) => Article.fromMap(item))
        .toList();
  }

  /// 登录
  /// [dio._init] 添加了拦截器 设置了自动cookie.
  static Future<User> login(String username, String password) async {
    var response = await dio.post<Map>('user/login', queryParameters: {
      'username': username,
      'password': password,
    });
    return User.fromJsonMap(response.data);
  }

  /// 注册
  static Future<User> register(
      String username, String password, String rePassword) async {
    var response = await dio.post<Map>('user/register', queryParameters: {
      'username': username,
      'password': password,
      'repassword': rePassword,
    });
    return User.fromJsonMap(response.data);
  }

  /// 登出
  static logout() async {
    /// 自动移除cookie
    await dio.get('user/logout/json');
  }

  static testLoginState() async {
    await dio.get('lg/todo/listnotdo/0/json/1');
  }

  // 收藏列表
  static Future fetchCollectList(int pageNum) async {
    var response = await dio.get<Map>('lg/collect/list/$pageNum/json');
    return response.data['datas']
        .map<Article>((item) => Article.fromMap(item))
        .toList();
  }

  // 收藏
  static collect(id) async {
    await dio.post('lg/collect/$id/json');
  }

  // 取消收藏
  static unCollect(id) async {
    await dio.post('lg/uncollect_originId/$id/json');
  }

  // 取消收藏2
  static unMyCollect({id, originId}) async {
    await dio.post('lg/uncollect/$id/json',
        queryParameters: {'originId': originId ?? -1});
  }

  // 个人积分
  static Future fetchCoin() async {
    var response = await dio.get('lg/coin/getcount/json');
    return response.data;
  }

  // 我的积分记录
  static Future fetchCoinRecordList(int pageNum) async {
    var response = await dio.get('lg/coin/list/$pageNum/json');
    return response.data['datas']
        .map<CoinRecord>((item) => CoinRecord.fromMap(item))
        .toList();
  }

  // 积分排行榜
  /// {
  ///        "coinCount": 448,
  ///        "username": "S**24n"
  ///      },
  static Future fetchRankingList(int pageNum) async {
    var response = await dio.get('coin/rank/$pageNum/json');
    return response.data['datas'];
  }
}
