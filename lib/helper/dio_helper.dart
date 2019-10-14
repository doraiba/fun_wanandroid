import 'dart:io';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

Dio _dio = Dio();

Dio get dio => _dio;

class Api {
  static const String BASE_URL = "https://www.wanandroid.com/";
  static const int ERROR_CODE_UN_LOGIN = -1001;
}

class DioHelper {
  static Future init() async {
    dio.options.baseUrl = Api.BASE_URL;
    dio.options.connectTimeout = 5 * 1000;
    dio.options.sendTimeout = 5 * 1000;
    dio.options.receiveTimeout = 3 * 1000;

    //todo 网络环境监听
    dio.interceptors.add(LogInterceptor());
    dio.interceptors.add(ApiInterceptor());

    // dio.interceptors.add(WanAndroidErrorInterceptors());

    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path + "/dioCookie";
    print('DioUtil : http cookie path = $tempPath');
    CookieJar cj = PersistCookieJar(dir: tempPath);
    dio.interceptors.add(CookieManager(cj));
  }

  static String parseError(error, {String defErrorString = '网络连接超时或者服务器未响应'}) {
    String errStr;
    if (error is DioError) {
      if (error.type == DioErrorType.CONNECT_TIMEOUT ||
          error.type == DioErrorType.SEND_TIMEOUT ||
          error.type == DioErrorType.RECEIVE_TIMEOUT) {
        errStr = defErrorString;
      } else {
        errStr = error.message;
      }
    }
    return errStr ?? defErrorString;
  }
}

/// 玩Android API
class ApiInterceptor extends InterceptorsWrapper {

  @override
  onResponse(Response response) {
    RespData respData = RespData.fromJson(response.data);
    if (respData.success) {
      response.data = respData.data;
      return dio.resolve(response);
    } else {
      return handleFailed(respData);
    }
  }

  Future<Response> handleFailed(RespData respData) {
    debugPrint('---api-response--->error---->$respData');
    if (respData.code == -1001) {
      // 如果cookie过期,需要清除本地存储的登录信息
      // StorageManager.localStorage.deleteItem(UserModel.keyUser);
      // 需要登录
      throw const UnAuthorizedException();
    }
    return dio.reject(respData.message);
  }
}

class UnAuthorizedException implements Exception {
  const UnAuthorizedException();

  @override
  String toString() => 'UnAuthorizedException';
}

class RespData {
  dynamic data;
  int code = 0;
  String message;

  bool get success => 0 == code;

  RespData({this.data, this.code, this.message});

  @override
  String toString() {
    return 'RespData{data: $data, status: $code, message: $message}';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['errorCode'] = this.code;
    data['errorMsg'] = this.message;
    data['data'] = this.data;
    return data;
  }

  RespData.fromJson(Map<String, dynamic> json) {
    code = json['errorCode'];
    message = json['errorMsg'];
    data = json['data'];
  }
}
