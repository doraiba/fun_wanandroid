import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ImageHelper {
  static const String baseUrl = 'http://www.meetingplus.cn';
  static const String imagePrefix = '$baseUrl/uimg/';

  static String wrapUrl(String url) {
    if (url.startsWith('http')) {
      return url;
    } else {}
    return imagePrefix + url;
  }

  static String wrapAssets(String url) {
    return "assets/images/" + url;
  }

  static Widget placeHolder({double width, double height}) {
    return SizedBox(
        width: width,
        height: height,
        child: CupertinoActivityIndicator(radius: min(10.0, width / 3)));
  }

  static Widget error({double width, double height, double size}) {
    return SizedBox(
        width: width,
        height: height,
        child: Icon(
          Icons.error_outline,
          size: size,
        ));
  }

  static String randomUrl(
      {int width = 100, int height = 100, Object key = ''}) {
    return 'http://placeimg.com/$width/$height/${key.hashCode.toString() + key.toString()}';
  }

  static CachedNetworkImage imageCache(
      {@required String url,
      double width,
      double height,
      ImageType imageType: ImageType.normal,
      BoxFit fit = BoxFit.cover}) {
    return CachedNetworkImage(
      imageUrl: _imageUrl(imageType, url, width, height),
      width: width,
      height: height,
      placeholder: (_, __) =>
          ImageHelper.placeHolder(width: width, height: height),
      errorWidget: (_, __, ___) =>
          ImageHelper.error(width: width, height: height),
      fit: fit,
    );
  }

  static String _imageUrl(
      ImageType imageType, String url, double width, double height) {
    switch (imageType) {
      case ImageType.random:
        return ImageHelper.randomUrl(
            key: url, width: width.toInt(), height: height.toInt());
      case ImageType.assets:
        return ImageHelper.wrapAssets(url);
      case ImageType.normal:
        return url;
    }
    return url;
  }
}

class IconFonts {
  IconFonts._();

  static const String fontFamily = 'iconfont';

  static const IconData pageEmpty = IconData(0xe63c, fontFamily: fontFamily);
  static const IconData pageError = IconData(0xe600, fontFamily: fontFamily);
  static const IconData pageUnAuthorized =
      IconData(0xe65f, fontFamily: fontFamily);
  static const IconData train = IconData(0xe89a, fontFamily: fontFamily);
  static const IconData hotel = IconData(0xe8a0, fontFamily: fontFamily);
}

enum ImageType {
  normal,
  random, //随机
  assets, //资源目录
}
