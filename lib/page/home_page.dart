import 'package:flutter/material.dart';
import 'package:fun_wanandroid/generated/i18n.dart';
import 'package:fun_wanandroid/store/settings_store.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('flutter i18n'),
      ),
      body: Container(
        child: Consumer<SettingsStore>(
          builder: (_, settingsStore, __) => Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(),
                child: Text(I18n.of(_).appName),
              ),
              ButtonBar(
                alignment: MainAxisAlignment.center,
                children: <Widget>[
                  FlatButton.icon(
                    onPressed: () {
                      settingsStore.setLocale(value: Locale("en", "US"));
                    },
                    label: Text('en'),
                    icon: Icon(Icons.language),
                  ),
                  FlatButton.icon(
                    onPressed: () {
                      settingsStore.setLocale(value: Locale('zh', 'CN'));
                    },
                    label: Text('zh'),
                    icon: Icon(Icons.language),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
