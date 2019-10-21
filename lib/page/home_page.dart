import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:fun_wanandroid/generated/i18n.dart';
import 'package:fun_wanandroid/helper/image_helper.dart';
import 'package:fun_wanandroid/helper/widget_helper.dart';
import 'package:fun_wanandroid/model/nav_banner.dart';
import 'package:fun_wanandroid/store/home_store.dart';
import 'package:fun_wanandroid/store/scroll_store.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final expandedHeight = MediaQuery.of(context).size.width * .43;
    return Provider(
      builder: (_) => ScrollStore(
          scrollController: PrimaryScrollController.of(context),
          offset: expandedHeight - kToolbarHeight),
      dispose: (_, ScrollStore store) => store.dispose(),
      child: Scaffold(
        body: Consumer2<HomeStore, ScrollStore>(
          builder: (_, homeStore, scrollStore, __) => CustomScrollView(
            controller: scrollStore.scrollController,
            slivers: <Widget>[
              SliverAppBar(
                pinned: true,
                title: Observer(
                    builder: (_) => ChildSwitcher(
                          display: scrollStore.overHeaven,
                          child: Text(I18n.of(context).appName),
                        )),
                centerTitle: true,
                actions: <Widget>[
                  Observer(
                    builder: (_) => ChildSwitcher(
                      display: scrollStore.overHeaven,
                      child: IconButton(
                        icon: Icon(Icons.search),
                        onPressed: () {},
                      ),
                    ),
                  )
                ],
                expandedHeight: expandedHeight,
                flexibleSpace: FlexibleSpaceBar(
                  background: FutureObserver<List<NavBanner>>(
                    supplier: () => homeStore.bannerFuture,
                    builder: (_, data, __) => NavBannerHeader(itemList: data),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Container(
                  height: 1800,
                  color: Colors.red,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class NavBannerHeader extends StatelessWidget {
  final List<NavBanner> itemList;

  const NavBannerHeader({Key key, @required this.itemList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Swiper(
        loop: true,
        autoplay: true,
        autoplayDelay: 3000,
        pagination: SwiperPagination(),
        itemCount: itemList.length,
        itemBuilder: (_, i) => GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => WebviewScaffold(
                          // clearCookies: false,
                          withJavascript: true,
                          appBar: AppBar(
                            title: Text(
                              itemList[i].title,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          url: itemList[i].url,
                        )));
          },
          child: ImageHelper.imageCache(
              width: 200,
              height: 100,
              url: ImageHelper.wrapUrl(itemList[i].imagePath),
              fit: BoxFit.fill),
        ),
      ),
    );
  }
}
