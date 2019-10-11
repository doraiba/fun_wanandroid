import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fun_wanandroid/helper/image_helper.dart';
import 'package:fun_wanandroid/route/routes.dart';
import 'package:rxdart/rxdart.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  StreamSubscription<int> _subscription;
  @override
  void initState() {
    super.initState();
    _subscription = Observable.timer(0, Duration(seconds: 1)).listen(
        (_) => Routes.router.navigateTo(context, Routes.home, replace: true));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Image.asset(
            ImageHelper.wrapAssets('ic_splash_birth.webp'),
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.fitWidth,
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _subscription.cancel();
  }
}
