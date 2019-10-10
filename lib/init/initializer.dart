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
    Routes.configureRoutes();
    if (Platform.isAndroid) {
      SystemChrome.setSystemUIOverlayStyle(
          SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    }
    prefs = await SharedPreferences.getInstance();
    await DioHelper.init();
  }
}
