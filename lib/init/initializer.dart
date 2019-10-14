import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fun_wanandroid/helper/dio_helper.dart';
import 'package:fun_wanandroid/route/routes.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Application {
  static bool get isRelease => bool.fromEnvironment("dart.vm.product");
  static SharedPreferences prefs;

  static Future<void> init() async {
    WidgetsFlutterBinding.ensureInitialized();

    ///初始化路由
    Routes.configureRoutes();
    if (Platform.isAndroid) {
      ////Android 头部透明
      SystemChrome.setSystemUIOverlayStyle(
          SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    }

    ///初始化本地存储
    prefs = await SharedPreferences.getInstance();

    ///初始化网络请求配置
    await DioHelper.init();
  }
}
