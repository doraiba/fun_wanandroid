import 'package:flutter/material.dart';
import 'package:fun_wanandroid/helper/image_helper.dart';
import 'package:fun_wanandroid/helper/widget_helper.dart';
import 'package:fun_wanandroid/route/routes.dart';
import 'package:rxdart/rxdart.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  var _subject = BehaviorSubject();
  @override
  void initState() {
    super.initState();
    _subject.addStream(
        Observable.fromIterable([3, 2, 1]).interval(Duration(seconds: 1)));
    _subject.take(3).listen((_) => _, onDone: _toHome);
  }

  void _toHome() {
    Routes.router.navigateTo(context, Routes.home, replace: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WidgetHelper.popScope(
        child: Stack(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(ImageHelper.wrapAssets('splash_bg.png')),
                    fit: BoxFit.cover),
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: StreamBuilder(
                stream: _subject,
                builder: (_, snapshot) {
                  return Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    margin: EdgeInsets.only(right: 20, bottom: 20),
                    child: FlatButton(
                      color: Colors.grey,
                      child: Text('${snapshot.data}'),
                      onPressed: _toHome,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _subject.close();
  }
}
