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
import 'package:fun_wanandroid/store/signup_store.dart';
import 'package:fun_wanandroid/store/user_store.dart';
import 'package:mobx/mobx.dart';
import 'package:oktoast/oktoast.dart';

class SignUpPage extends StatefulWidget {
  SignUpPage({Key key}) : super(key: key);

  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  SignUpStore store = SignUpStore();

  @override
  void dispose() {
    super.dispose();
    store.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor:  Theme.of(context).accentColor.withOpacity(.7),
      body: Container(
        color: Theme.of(context).accentColor.withOpacity(.7),
        child: ListView(
          // shrinkWrap: true,
          children: <Widget>[
            SizedBox(height: 30),
            CircleAvatar(
              child: Image.asset(ImageHelper.wrapAssets('origami.png')),
              maxRadius: 50,
              backgroundColor: Colors.transparent,
            ),
            SizedBox(height: 20),
            buildForm(),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                FloatingActionButton(
                  mini: true,
                  onPressed: () {
                    Routes.router.pop(context);
                  },
                  child: Icon(
                    Icons.arrow_back,
                  ),
                  backgroundColor: Theme.of(context).accentColor,
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget buildForm() {
    return Container(
      key: store.gKey,
      padding: EdgeInsets.all(20),
      child: Stack(
        children: <Widget>[
          ClipPath(
            clipper: RoundedDiagonalPathClipper(),
            child: Container(
              height: 400,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white24,
                borderRadius: BorderRadius.circular(40),
              ),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 90),
                    ...store.list
                        .map((item) => Container(
                              padding: EdgeInsets.only(bottom: 10),
                              child: Observer(
                                builder: (_) {
                                  return TextField(
                                    onChanged: (val) => item.value = val,
                                    obscureText: item.obscureText,
                                    decoration: InputDecoration(
                                        prefixIcon: Icon(
                                          item.prefixIconData,
                                          color: Theme.of(context).buttonColor,
                                        ),
                                        hintText: item.hintText(context),
                                        hintStyle: TextStyle(
                                            color:
                                                Theme.of(context).buttonColor),
                                        errorText: item.error,
                                        suffixIcon: item.obscureText == true
                                            ? GestureDetector(
                                                onTap: () => item.obscureText =
                                                    !item.obscureText,
                                                child: Icon(
                                                  CupertinoIcons.eye,
                                                  size: 30,
                                                  color: item.obscureText
                                                      ? Theme.of(context)
                                                          .hintColor
                                                      : Theme.of(context)
                                                          .accentColor,
                                                ),
                                              )
                                            : null),
                                  );
                                },
                              ),
                            ))
                        .toList()
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
              child: ConsumerObserver<UserStore>(
                builder: (_, userStore, __) {
                  var future = store.signUpFuture;
                  if (future?.status == FutureStatus.pending) {
                    return RaiseButtonLading();
                  }
                  return RaisedButton(
                    onPressed: store.submit((map) {
                      AsyncAction('\$\$signup').run(() async {
                        try {
                          User user = await store.signup(
                              username: map[SignUpField.username],
                              password: map[SignUpField.password],
                              repassword: map[SignUpField.repassword]);
                          userStore.setLastLoginName(user.nickname);
                          Navigator.of(context).pop(user.nickname);
                        } catch (e) {
                          showToast(DioHelper.parseError(e));
                        }
                      });
                    }),
                    child: Text(
                      I18n.of(context).signUp,
                      style: TextStyle(color: Colors.white),
                    ),
                    color: Theme.of(context).accentColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40)),
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
