import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:fun_wanandroid/component/skeleton_component.dart';
import 'package:fun_wanandroid/generated/i18n.dart';
import 'package:fun_wanandroid/helper/image_helper.dart';
import 'package:fun_wanandroid/helper/widget_helper.dart';
import 'package:fun_wanandroid/model/article.dart';
import 'package:fun_wanandroid/model/nav_banner.dart';
import 'package:fun_wanandroid/page/article_list_page.dart';
import 'package:fun_wanandroid/store/home_store.dart';
import 'package:fun_wanandroid/store/scroll_store.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:webview_flutter/webview_flutter.dart';

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
    final top = MediaQuery.of(context).padding.top;
    print('-bar- ============================================= $top ');
    return Provider(
      builder: (_) => ScrollStore(
          scrollController: PrimaryScrollController.of(context),
          offset: expandedHeight - kToolbarHeight),
      dispose: (_, ScrollStore store) => store.dispose(),
      child: Scaffold(
        body: Consumer2<HomeStore, ScrollStore>(
          builder: (_, homeStore, scrollStore, __) => SmartRefresher(
            controller: homeStore.refreshController,
            onRefresh: () {
              homeStore.fetchTop().then((_) => homeStore.refresh());
            },
            enablePullUp: homeStore.list.isNotEmpty,
            onLoading: homeStore.forward,
            child: CustomScrollView(
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
                FutureObserver<List<Article>>(
                  supplier: () => homeStore.topFuture,
                  refresh: homeStore.fetchTop,
                  loading: SliverToBoxAdapter(),
                  rejected: SliverToBoxAdapter(),
                  builder: (_, list, __) {
                    return SliverList(
                      delegate: SliverChildBuilderDelegate(
                          (_, i) => ArticleListItem(
                                mark: Container(
                                  margin: EdgeInsets.only(right: 5),
                                  child: Icon(
                                    Icons.whatshot,
                                    color: Colors.red[700],
                                    size: 18,
                                  ),
                                ),
                                article: list[i],
                              ),
                          childCount: list?.length ?? 0),
                    );
                  },
                ),
                FutureObserver(
                  supplier: () => homeStore.fetchFutrue,
                  refresh: homeStore.refresh,
                  loading: SliverToBoxAdapter(
                    child: SkeletonList(builder: (_, i) => SkeletonListItem()),
                  ),
                  builder: (_, list, __) {
                    var list = homeStore.list;
                    if (list.isEmpty) {
                      return OnlyTips(
                        header: const Icon(
                          IconFonts.pageEmpty,
                          size: 100,
                          color: Colors.grey,
                        ),
                        tips: I18n.of(context).viewStateMessageEmpty,
                        onPressed: homeStore.retry,
                        buttonTips: I18n.of(context).viewStateButtonRefresh,
                      );
                    }
                    return SliverList(
                      delegate: SliverChildBuilderDelegate(
                          (_, i) => ArticleListItem(
                                article: list[i],
                              ),
                          childCount: list.length),
                    );
                  },
                )
              ],
            ),
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
                    builder: (_) => Scaffold(
                          // clearCookies: false,
                          appBar: AppBar(
                            title: Text(
                              itemList[i].title,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          body: WebView(
                            initialUrl: itemList[i].url,
                            javascriptMode: JavascriptMode.unrestricted,
                          ),
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
