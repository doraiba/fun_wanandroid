import 'package:flutter/material.dart';
import 'package:fun_wanandroid/generated/i18n.dart';
import 'package:fun_wanandroid/helper/widget_helper.dart';
import 'package:fun_wanandroid/page/home_page.dart';
import 'package:fun_wanandroid/page/user_page.dart';
import 'package:fun_wanandroid/page/project_page.dart';
import 'package:fun_wanandroid/page/wechat_page.dart';

class NavigatorPage extends StatefulWidget {
  @override
  _NavigatorPageState createState() => _NavigatorPageState();
}

class _NavigatorPageState extends State<NavigatorPage> {
  static int initialPage = 0;
  int _currentIndex = initialPage;
  PageController _pageController = PageController(
      // initialPage: initialPage,
      );

  var _list = <Widget>[
    HomePage(),
    ProjectPage(),
    WechatPage(),
    Container(),
    UserPage(),
  ];

  void _pageChanged(int page) {
    setState(() {
      _currentIndex = page;
    });
  }

  void _tap(int page) {
    // _pageChanged(page);
    _pageController.jumpToPage(page);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScopeWidget(
        child: PageView(
          physics: NeverScrollableScrollPhysics(),
          controller: _pageController,
          onPageChanged: _pageChanged,
          children: _list,
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  _buildBottomNavigationBar() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: _currentIndex,
      onTap: _tap,
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
            icon: Icon(Icons.home), title: Text(I18n.of(context).tabHome)),
        BottomNavigationBarItem(
            icon: Icon(Icons.format_list_bulleted),
            title: Text(I18n.of(context).tabProject)),
        BottomNavigationBarItem(
            icon: Icon(Icons.group_work),
            title: Text(I18n.of(context).wechatAccount)),
        BottomNavigationBarItem(
            icon: Icon(Icons.call_split),
            title: Text(I18n.of(context).tabStructure)),
        BottomNavigationBarItem(
            icon: Icon(Icons.insert_emoticon),
            title: Text(I18n.of(context).tabUser)),
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }
}
