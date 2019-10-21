import 'dart:math';

import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fun_wanandroid/generated/i18n.dart';
import 'package:fun_wanandroid/helper/function_helper.dart';
import 'package:fun_wanandroid/helper/image_helper.dart';
import 'package:fun_wanandroid/helper/widget_helper.dart';
import 'package:fun_wanandroid/route/routes.dart';
import 'package:fun_wanandroid/store/settings_store.dart';
import 'package:fun_wanandroid/store/user_store.dart';
import 'package:fun_wanandroid/store/userinfo_store.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class UserPage extends StatefulWidget {
  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ConsumerObserver<UserStore>(
      child: NotAuthUserPage(),
      builder: (_, store, child) => store.auth == null
          ? child
          : Provider(
              builder: (_) => UserInfoStore(),
              child: AuthUserPage(),
            ),
    );
  }
}

class UserAccountHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer2<UserStore, UserInfoStore>(
      builder: (_, userStore, userInfoStore, __) => Container(
        margin: EdgeInsets.only(top: 50.0),
        height: 240.0,
        child: Stack(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(
                  top: 40.0, left: 40.0, right: 40.0, bottom: 10.0),
              child: Material(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                elevation: 5.0,
                color: themeSupplier(context,
                    truth: Theme.of(context).accentColor, fal: Colors.white),
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 50.0,
                    ),
                    Text(
                      userStore.auth.nickname,
                      style: Theme.of(context).textTheme.title,
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    FutureObserver<int>(
                        supplier: () => userInfoStore.coinStore.coinFuture,
                        loading: CupertinoActivityIndicator(),
                        rejected: Text(I18n.of(context).operatorError),
                        builder: (_, data, ___) {
                          return Text(
                            "${I18n.of(context).coin}: $data",
                            textAlign: TextAlign.start,
                            style:
                                TextStyle(decoration: TextDecoration.underline),
                          );
                        }),
                    SizedBox(
                      height: 13.0,
                    ),
                    Container(
                      height: 40.0,
                      child: Row(
                        // mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          // Expanded(
                          //   child: ListTile(
                          //     title: FutureObserver(
                          //       supplier: () => userInfoStore.articleStore,
                          //     ),
                          //     subtitle: Text(
                          //         I18n.of(context).tabProject.toUpperCase(),
                          //         textAlign: TextAlign.center,
                          //         style: TextStyle(fontSize: 12.0)),
                          //   ),
                          // ),
                          Expanded(
                            child: ListTile(
                              title: FutureObserver<int>(
                                loading: CupertinoActivityIndicator(),
                                rejected: Text(I18n.of(context).operatorError),
                                supplier: () =>
                                    userInfoStore.articleStore.shareFuture,
                                builder: (_, data, __) => Text(
                                  "$data",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                              subtitle: Text(
                                  I18n.of(context).share.toUpperCase(),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 12.0)),
                            ),
                          ),
                          Expanded(
                            child: ListTile(
                              title: FutureObserver<int>(
                                loading: CupertinoActivityIndicator(),
                                rejected: Text(I18n.of(context).operatorError),
                                supplier: () =>
                                    userInfoStore.articleStore.collectFuture,
                                builder: (_, data, __) => Text(
                                  "$data",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                              subtitle: Text(
                                  I18n.of(context).favourites.toUpperCase(),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 12.0)),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Material(
                  elevation: 5.0,
                  shape: CircleBorder(),
                  child: CircleAvatar(
                    radius: 40.0,
                    backgroundImage: AssetImage(
                      ImageHelper.wrapAssets("user_avatar.png"),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class UserSetting extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        padding: EdgeInsets.symmetric(horizontal: 10),
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        children: <Widget>[
          ConsumerObserver<SettingsStore>(
            name: "darkMode",
            builder: (_, store, __) => ListTile(
              onTap: () {
                store.setDarkMode(value: !store.useDarkMode);
              },
              leading: Transform.rotate(
                angle: -pi,
                child: Icon(
                    themeSupplier(context,
                        truth: Icons.brightness_2, fal: Icons.brightness_7),
                    color: iconColorSupplier(context)),
              ),
              title: Text(I18n.of(context).darkMode),
              trailing: CupertinoSwitch(
                onChanged: (bool value) {
                  store.setDarkMode(value: value);
                },
                value: store.useDarkMode,
              ),
            ),
          ),
          Consumer<SettingsStore>(
            builder: (_, store, __) => ThemeTile(
              current: store.icolor,
              child: Icon(Icons.flag),
              onTap: (index) {
                store.setIColor(value: index);
              },
            ),
          ),
          Consumer<SettingsStore>(
            builder: (_, store, __) {
              return LanguageTile(
                locale: store.locale,
                onChanged: (locale) => store.setLocale(value: locale),
              );
            },
          ),
        ],
      ),
    );
  }
}

class AuthUserPage extends StatefulWidget {
  AuthUserPage({Key key}) : super(key: key);

  _AuthUserPageState createState() => _AuthUserPageState();
}

class _AuthUserPageState extends State<AuthUserPage> {
  List<Widget> _list = [
    UserAccountHeader(),
    UserSetting(),
  ];

  var _controller = RefreshController();

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            height: 200,
            decoration: BoxDecoration(
              color: themeSupplier(
                context,
                truth: Colors.black38,
                fal: Theme.of(context).accentColor,
              ),
            ),
          ),
          Consumer<UserInfoStore>(
            builder: (_, store, __) => SmartRefresher(
              header: MaterialClassicHeader(),
              onRefresh: () async {
                try {
                  await store.refresh();
                } finally {
                  _controller.refreshCompleted();
                }
              },
              controller: _controller,
              child: ListView.builder(
                itemCount: 2,
                itemBuilder: _itemBuilder,
              ),
            ),
          ),
          SafeArea(
            child: Align(
              alignment: Alignment.topRight,
              child: Consumer<UserStore>(
                builder: (_, store, __) {
                  return IconButton(
                    tooltip: I18n.of(context).logout,
                    onPressed: store.logout,
                    icon: Icon(Icons.exit_to_app, size: 28),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _itemBuilder(BuildContext context, int index) => _list[index];
}

class NotAuthUserPage extends StatefulWidget {
  @override
  _NotAuthUserPageState createState() => _NotAuthUserPageState();
}

class _NotAuthUserPageState extends State<NotAuthUserPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFD300),
      body: Builder(
        builder: (BuildContext context) => Column(
          // fit: StackFit.expand,
          children: <Widget>[
            Flexible(
              flex: 8,
              child: FlareActor(
                'assets/flare/bus.flr',
                alignment: Alignment.center,
                fit: BoxFit.contain,
                animation: 'driving',
              ),
            ),
            Flexible(
              flex: 2,
              child: RaisedButton(
                onPressed: () {
                  Routes.router.navigateTo(context, Routes.login);
                },
                child: Container(
                  child: Text(I18n.of(context).needLogin),
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50)),
                elevation: 4,
                color: Color(0xFFFFB900),
              ),
            )
          ],
        ),
      ),
    );
  }
}
