import 'package:fluro/fluro.dart';
import 'package:fun_wanandroid/page/chaos_nav_page.dart';
import 'package:fun_wanandroid/page/signin_page.dart';
import 'package:fun_wanandroid/page/navigator_page.dart';
import 'package:fun_wanandroid/page/signup_page.dart';
import 'package:fun_wanandroid/page/splash_page.dart';
import 'package:fun_wanandroid/page/webview_flutter_page.dart';
import 'package:fun_wanandroid/route/routes.dart';

var rootHandler = Handler(handlerFunc: (_, __) => SplashPage());

var homeHandler = Handler(handlerFunc: (_, __) => NavigatorPage());

var signInHandler = Handler(handlerFunc: (_, __) => SignInPage());

var signUpHandler = Handler(handlerFunc: (_, __) => SignUpPage());

var chaosNavHandler = Handler(
    handlerFunc: (_, Map<String, List<String>> params) =>
        ChaosNavConsumer(id: params['id'].first, cid: params['cid'].first));
var webviewFlutterHandler = Handler(
    handlerFunc: (_, Map<String, List<String>> params) => WebViewFlutterPage(
        title: FluroConvertUtils.fluroCnParamsDecode(params['title'].first),
        url: FluroConvertUtils.fluroCnParamsDecode(params['url'].first)));
