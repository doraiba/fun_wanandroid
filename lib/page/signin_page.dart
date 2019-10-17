import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:fun_wanandroid/generated/i18n.dart';
import 'package:fun_wanandroid/helper/dio_helper.dart';
import 'package:fun_wanandroid/helper/image_helper.dart';
import 'package:fun_wanandroid/helper/widget_helper.dart';
import 'package:fun_wanandroid/model/user.dart';
import 'package:fun_wanandroid/route/routes.dart';
import 'package:fun_wanandroid/store/signin_store.dart';
import 'package:fun_wanandroid/store/user_store.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';

class SignInPage extends StatefulWidget {
  SignInPage({Key key}) : super(key: key);

  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  SignInStore store = SignInStore();

  var _usernameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _usernameController.text =
        Provider.of<UserStore>(context, listen: false).lastLoginName;
  }

  @override
  void dispose() {
    super.dispose();
    _usernameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Theme.of(context).accentColor.withOpacity(.7),
        child: ListView(
          // physics: BouncingScrollPhysics(),
          children: <Widget>[
            SizedBox(height: 30),
            CircleAvatar(
              child: Image.asset(ImageHelper.wrapAssets('origami.png')),
              maxRadius: 50,
              backgroundColor: Colors.transparent,
            ),
            SizedBox(height: 20),
            _buildForm(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                FlatButton(
                  onPressed: () async {
                    final nickname = await Routes.router
                        .navigateTo(context, Routes.register);
                    if (nickname != null) {
                      _usernameController.text = nickname;
                    }
                  },
                  child: Text(
                    I18n.of(context).signUp,
                    style: TextStyle(
                        color: Theme.of(context).accentColor, fontSize: 18),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildForm() {
    return Builder(
      builder: (context) => Form(
        key: store.signInFormKey,
        autovalidate: store.autovalidate,
        child: Container(
          padding: EdgeInsets.all(20),
          child: Stack(
            children: <Widget>[
              ClipPath(
                clipper: RoundedDiagonalPathClipper(),
                child: Container(
                  padding: EdgeInsets.all(10),
                  height: 400,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      color: Colors.white24),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(height: 90),
                        Container(
                          child: TextFormField(
                            controller: _usernameController,
                            decoration: InputDecoration(
                              // labelText: userStore.lastLoginName,
                              hintText: I18n.of(context).userName,
                              hintStyle: TextStyle(
                                  color: Theme.of(context).buttonColor),
                              // border: InputBorder.none,
                              prefixIcon: Icon(
                                Icons.perm_identity,
                                color: Theme.of(context).buttonColor,
                              ),
                            ),
                            onSaved: (val) => store.username = val,
                            validator: store.validUserName,
                          ),
                        ),
                        Container(padding: EdgeInsets.only(bottom: 10)),
                        Container(
                            child: Observer(
                          builder: (_) => TextFormField(
                            obscureText: store.watch,
                            decoration: InputDecoration(
                              hintText: I18n.of(context).password,
                              hintStyle: TextStyle(
                                  color: Theme.of(context).buttonColor),
                              // border: InputBorder.none,
                              prefixIcon: Icon(
                                Icons.lock,
                                color: Theme.of(context).buttonColor,
                              ),
                              suffixIcon: GestureDetector(
                                onTap: () {
                                  store.setWatch(!store.watch);
                                },
                                child: Icon(
                                  CupertinoIcons.eye,
                                  size: 30,
                                  color: store.watch
                                      ? Theme.of(context).hintColor
                                      : Theme.of(context).accentColor,
                                ),
                              ),
                            ),
                            onSaved: (val) => store.password = val,
                            validator: store.validPassWord,
                          ),
                        )),
                        Container(
                          padding: EdgeInsets.only(bottom: 10),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            FlatButton(
                              onPressed: null,
                              child: Text(I18n.of(context).forgot),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CircleAvatar(
                    child: Icon(Icons.person),
                    radius: 40,
                    backgroundColor: Theme.of(context).accentColor,
                  )
                ],
              ),
              Container(
                height: 420,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Consumer<UserStore>(
                    builder: (_, userStore, __) {
                      return Observer(
                        builder: (_) {
                          var future = store.signFuture;
                          if (future?.status == FutureStatus.pending) {
                            return RaiseButtonLading();
                          }
                          return RaisedButton(
                            onPressed: store.submit((username, password) async {
                              try {
                                AsyncAction('\$\$login').run(() async {
                                  print("======$username,$password======");
                                  User user = await store.sign(
                                      username: username, password: password);
                                  userStore.setAuth(value: user);
                                  userStore.setLastLoginName(user.nickname);
                                  Navigator.of(context).pop(user);
                                });
                              } catch (e) {
                                Scaffold.of(context).showSnackBar(SnackBar(
                                  content: Text(DioHelper.parseError(e)),
                                ));
                              }
                            }),
                            child: Text(
                              I18n.of(context).signIn,
                              style: TextStyle(color: Colors.white),
                            ),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(40)),
                            color: Theme.of(context).accentColor,
                          );
                        },
                      );
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
