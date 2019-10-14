import 'package:flutter/material.dart';
import 'package:fun_wanandroid/generated/i18n.dart';
import 'package:fun_wanandroid/helper/function_helper.dart';

class SettingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(I18n.of(context).setting),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: ListView(
          children: <Widget>[
            ExpansionTile(
              leading: Icon(
                Icons.language,
                color: iconColorSupplier(context),
              ),
              trailing: Icon(Icons.chevron_right),
              title: Text(I18n.of(context).settingLanguage),
              children: <Widget>[
                RadioListTile(
                  value: 0,
                  onChanged: (i) {},
                  title: Text("data"),
                ),
                RadioListTile(
                  onChanged: (i) {},
                  title: Text("data"),
                ),
                RadioListTile(
                  onChanged: (i) {},
                  title: Text("data"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
