import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fun_wanandroid/generated/i18n.dart';
import 'package:fun_wanandroid/helper/function_helper.dart';
import 'package:fun_wanandroid/helper/image_helper.dart';
import 'package:fun_wanandroid/helper/widget_helper.dart';
import 'package:fun_wanandroid/store/settings_store.dart';
import 'package:provider/provider.dart';

class MyPage extends StatefulWidget {
  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  List<Widget> _list = [
    UserAccountHeader(),
    UserSetting(),
  ];

  @override
  Widget build(BuildContext context) {
    super.build(context);
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
          ListView.builder(
            itemCount: 2,
            itemBuilder: _itemBuilder,
          )
        ],
      ),
    );
  }

  Widget _itemBuilder(BuildContext context, int index) => _list[index];
}

class UserAccountHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
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
                    "iterminal",
                    style: Theme.of(context).textTheme.title,
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  Text(
                    "${I18n.of(context).coin}: 10",
                    textAlign: TextAlign.start,
                    style: TextStyle(decoration: TextDecoration.underline),
                  ),
                  SizedBox(
                    height: 13.0,
                  ),
                  Container(
                    height: 40.0,
                    child: Row(
                      // mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                          child: ListTile(
                            title: Text(
                              "302",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(
                                I18n.of(context).tabProject.toUpperCase(),
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 12.0)),
                          ),
                        ),
                        Expanded(
                          child: ListTile(
                            title: Text(
                              "10.3K",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(I18n.of(context).share.toUpperCase(),
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 12.0)),
                          ),
                        ),
                        Expanded(
                          child: ListTile(
                            title: Text(
                              "120",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontWeight: FontWeight.bold),
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
              leading: Icon(Icons.palette, color: iconColorSupplier(context)),
              title: Text(I18n.of(context).theme),
              trailing: Icon(
                Icons.keyboard_arrow_down,
              ),
              onTap: (index) {
                store.setIColor(value: index);
              },
            ),
          ),
          Consumer<SettingsStore>(
            builder: (_, store, __) {
              return ExpansionTile(
                leading: Icon(
                  Icons.language,
                  color: iconColorSupplier(context),
                ),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(I18n.of(context).settingLanguage),
                    Text(
                      {
                        null: () => I18n.of(context).autoBySystem,
                        ...I18n.delegate.locales
                      }
                          .entries
                          .firstWhere((e) => e.key == store.locale)
                          .value(),
                      style: Theme.of(context).textTheme.caption,
                    ),
                  ],
                ),
                children: [
                  RadioListTile(
                    groupValue: store.locale,
                    value: null,
                    onChanged: (value) {
                      store.setLocale(value: value);
                    },
                    title: Text(I18n.of(context).autoBySystem),
                  )
                ]..addAll(I18n.delegate.supportedLocales
                    .map((item) => RadioListTile(
                          groupValue: store.locale,
                          value: item,
                          title: Text(I18n.delegate.localeName(item)),
                          onChanged: (value) {
                            print("set $value");
                            store.setLocale(value: value);
                          },
                        ))
                    .toList()),
              );
            },
          ),
        ],
      ),
    );
  }
}
