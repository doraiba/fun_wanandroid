import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:fun_wanandroid/page/navigator_page.dart';
import 'package:fun_wanandroid/page/splash_page.dart';

var rootHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return SplashPage();
});

var homeHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return NavigatorPage();
});
