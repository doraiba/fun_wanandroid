import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:fun_wanandroid/route/route_handlers.dart';

class Routes {
  static String root = '/';
  static final Router router = Router.appRouter;

  static final String home = '/home';
  static final String setting = '/setting';
  static final String login = '/login';

  static final String register = '/register';

  static void configureRoutes() {
    router.notFoundHandler = Handler(
        handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      return Center(
        child: Text('NOT FOUND'),
      );
    });

    /// 第一个参数是路由地址，第二个参数是页面跳转和传参，第三个参数是默认的转场动画，可以看上图
    /// 我这边先不设置默认的转场动画，转场动画在下面会讲，可以在另外一个地方设置（可以看NavigatorUtil类）
    router.define(root, handler: rootHandler);
    router.define(home, handler: homeHandler);
    router.define(setting, handler: settingHandler);
    router.define(login, handler: signInHandler);
    router.define(register, handler: signUpHandler);
  }
}
