import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:fun_wanandroid/route/route_handlers.dart';
import 'dart:convert';

class Routes {
  static String root = '/';
  static final Router router = Router.appRouter;

  static final String home = '/home';
  static final String setting = '/setting';
  static final String login = '/login';

  static final String register = '/register';

  static final String chaosNav = '/chaos/:id/:cid';
  static final String webview = '/webview';
  static final String share = '/share';
  static final String collect = '/collect';

  static void configureRoutes() {
    router.notFoundHandler = Handler(
        handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      return Scaffold(
        body: Center(
          child: Text('NOT FOUND'),
        ),
      );
    });

    /// 第一个参数是路由地址，第二个参数是页面跳转和传参，第三个参数是默认的转场动画，可以看上图
    /// 我这边先不设置默认的转场动画，转场动画在下面会讲，可以在另外一个地方设置（可以看NavigatorUtil类）
    router.define(root, handler: rootHandler);
    router.define(home, handler: homeHandler);
    router.define(login, handler: signInHandler);
    router.define(register, handler: signUpHandler);
    router.define(chaosNav, handler: chaosNavHandler);
    router.define(webview, handler: webviewFlutterHandler);
    router.define(share, handler: shareHandler);
    router.define(collect, handler: collectHandler);
  }
}

class FluroConvertUtils {
  /// fluro 传递中文参数前，先转换，fluro 不支持中文传递
  static String fluroCnParamsEncode(String originalCn) {
    return jsonEncode(Utf8Encoder().convert(originalCn));
  }

  /// fluro 传递后取出参数，解析
  static String fluroCnParamsDecode(String encodeCn) {
    var list = List<int>();
    ///字符串解码
    jsonDecode(encodeCn).forEach(list.add);
    String value = Utf8Decoder().convert(list);
    return value;
  }
}
