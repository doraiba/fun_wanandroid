import 'package:flutter/material.dart';
import 'package:fun_wanandroid/helper/event_bus_helper.dart';
import 'package:fun_wanandroid/helper/image_helper.dart';
import 'package:fun_wanandroid/helper/widget_helper.dart';
import 'package:fun_wanandroid/route/routes.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();

    /// 五秒没有监听到进行超时异常
    behaviorBus
        .on<AppLoadEvent>()
        .timeout(Duration(seconds: 5))
        .take(1)
        .listen(_toHome, onError: _toHome, cancelOnError: true);
  }

  void _toHome([_]) {
    Routes.router.navigateTo(context, Routes.home, replace: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScopeWidget(
        child: Stack(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(ImageHelper.wrapAssets('splash_bg.png')),
                    fit: BoxFit.cover),
              ),
            ),
            // Align(
            //   alignment: Alignment.bottomRight,
            //   child: StreamBuilder(
            //     stream: _subject,
            //     builder: (_, snapshot) {
            //       return Container(
            //         padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            //         margin: EdgeInsets.only(right: 20, bottom: 20),
            //         child: FlatButton(
            //           color: Colors.grey,
            //           child: Text('${snapshot.data}'),
            //           onPressed: _toHome,
            //         ),
            //       );
            //     },
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
