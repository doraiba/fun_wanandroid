import 'dart:io';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fun_wanandroid/generated/i18n.dart';
import 'package:fun_wanandroid/helper/function_helper.dart';
import 'package:fun_wanandroid/helper/image_helper.dart';
import 'package:fun_wanandroid/helper/widget_helper.dart';
import 'package:fun_wanandroid/store/settings_store.dart';

class MyPage extends StatefulWidget {
  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Material(
                child: InkWell(
                  onTap: () {},
                  child: Container(
                    height: 250,
                    decoration: BoxDecoration(
                        color: themeSupplier(context,
                            truth: Colors.black38,
                            fal: Theme.of(context).accentColor),
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.elliptical(220, 70),
                          bottomRight: Radius.elliptical(220, 70),
                        )),
                  ),
                ),
              ),
              Container(
                child: Column(
                  children: <Widget>[
                    ClipOval(
                      child: Image.asset(
                        ImageHelper.wrapAssets("user_avatar.png"),
                        height: 80,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: Text(
                        "点我登录",
                        style: Theme.of(context)
                            .textTheme
                            .title
                            .copyWith(color: Colors.white70),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: <Widget>[
                ListTile(
                  onTap: () {},
                  leading: Icon(Icons.favorite_border,
                      color: iconColorSupplier(context)),
                  title: Text(I18n.of(context).favourites),
                  trailing: Icon(Icons.chevron_right),
                ),
                ConsumerObserver<SettingsStore>(
                  builder: (_, store, __) => ListTile(
                    onTap: () {
                      store.setDarkMode(value: !store.useDarkMode);
                    },
                    leading: Transform.rotate(
                      angle: -pi,
                      child: Icon(
                          themeSupplier(context,
                              truth: Icons.brightness_2,
                              fal: Icons.brightness_7),
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
                // ListTile(
                //   onTap: () {},
                //   leading:
                //       Icon(Icons.palette, color: iconColorSupplier(context)),
                //   title: Text(I18n.of(context).theme),
                //   trailing: Icon(
                //     Icons.keyboard_arrow_down,
                //   ),
                // ),
                ExpansionTile(
                  leading:
                      Icon(Icons.palette, color: iconColorSupplier(context)),
                  title: Text(I18n.of(context).theme),
                  trailing: Icon(
                    Icons.keyboard_arrow_down,
                  ),
                  children: <Widget>[],
                ),
                ListTile(
                  onTap: () {},
                  leading:
                      Icon(Icons.settings, color: iconColorSupplier(context)),
                  title: Text(I18n.of(context).setting),
                  trailing: Icon(Icons.chevron_right),
                ),
                if (Platform.isAndroid)
                  ListTile(
                    onTap: () {},
                    leading: Icon(Icons.system_update,
                        color: iconColorSupplier(context)),
                    title: Text(I18n.of(context).appUpdateCheckUpdate),
                    trailing: Icon(Icons.chevron_right),
                  )
              ],
            ),
          )
        ],
      ),
    );
  }
}
