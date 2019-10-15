import 'package:fluro/fluro.dart';
import 'package:fun_wanandroid/page/login_page.dart';
import 'package:fun_wanandroid/page/navigator_page.dart';
import 'package:fun_wanandroid/page/setting_page.dart';
import 'package:fun_wanandroid/page/splash_page.dart';

var rootHandler = Handler(handlerFunc: (_, __) => SplashPage());

var homeHandler = Handler(handlerFunc: (_, __) => NavigatorPage());

var settingHandler = Handler(handlerFunc: (_, __) => SettingPage());

var loginHandler = Handler(handlerFunc: (_, __) => LoginPage());
