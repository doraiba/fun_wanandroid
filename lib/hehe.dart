
import 'dart:convert';

import 'package:fun_wanandroid/model/user.dart';

void main()  {
  User user = User.fromJsonMap({"email":""});
  var a = json.encode(user);
  print(a);
}
