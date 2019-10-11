import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:fun_wanandroid/component/skeleton_component.dart';
import 'package:fun_wanandroid/generated/i18n.dart';
import 'package:fun_wanandroid/helper/image_helper.dart';
import 'package:fun_wanandroid/helper/widget_helper.dart';
import 'package:fun_wanandroid/model/article.dart';
import 'package:fun_wanandroid/store/project_page_store.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ArticleListPage extends StatefulWidget {
  final int cid;

  const ArticleListPage({Key key, @required this.cid}) : super(key: key);
  @override
  _ArticleListPageState createState() => _ArticleListPageState();
}

class _ArticleListPageState extends State<ArticleListPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Provider(
      builder: (_) => ProjectPageStore(widget.cid),
      dispose: (_, store) => store.dispose(),
      child: Consumer<ProjectPageStore>(
        builder: (_, store, __) {
          return WidgetHelper.observerWrap<Map<String, dynamic>>(
            loading: SkeletonList(
              builder: (BuildContext context, int index) => SkeletonListItem(),
            ),
            supplier: () => store.fetchFutrue,
            builder: (c, data, refresh) {
              var list = store.list;
              if (list.isEmpty) {
                return OnlyTips(
                  header: const Icon(
                    IconFonts.pageEmpty,
                    size: 100,
                    color: Colors.grey,
                  ),
                  tips: I18n.of(context).viewStateMessageEmpty,
                  onPressed: store.retry,
                  buttonTips: I18n.of(context).viewStateButtonRefresh,
                );
              }
              return SmartRefresher(
                header: WaterDropMaterialHeader(),
                controller: store.refreshController,
                onRefresh: store.refresh,
                onLoading: store.forward,
                enablePullUp: true,
                child: ListView.builder(
                  itemCount: list.length,
                  itemBuilder: (BuildContext context, int index) =>
                      ArticleListItem(article: list[index]),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

/// 文章列表item
class ArticleListItem extends StatelessWidget {
  final Article article;
  const ArticleListItem({Key key, @required this.article}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Material(
          // color: Theme.of(context).accentColor.withAlpha(10),
          child: InkWell(
            onTap: () {},
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              padding: EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                  border: Border(
                      bottom: Divider.createBorderSide(context, width: .7))),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Container(
                        child: ClipOval(
                          child: ImageHelper.imageCache(
                            imageType: ImageType.random,
                            url: article.author,
                            height: 20,
                            width: 20,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 5),
                        child: Text(
                          article.author,
                          style: Theme.of(context).textTheme.caption,
                        ),
                      ),
                      Expanded(
                        child: SizedBox.shrink(),
                      ),
                      Container(
                        child: Text(
                          article.niceDate,
                          style: Theme.of(context).textTheme.caption,
                        ),
                      )
                    ],
                  ),
                  if (article.envelopePic.isEmpty)
                    Padding(
                      padding: EdgeInsets.only(top: 7),
                      child: _buildTitle(context, article.title),
                    )
                  else
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              _buildTitle(context, article.title),
                              Container(
                                margin: EdgeInsetsDirectional.only(top: 2),
                                child: Text(article.desc,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: Theme.of(context).textTheme.caption),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 5),
                          child: ImageHelper.imageCache(
                            url: article.envelopePic,
                            height: 60,
                            width: 60,
                          ),
                        )
                      ],
                    ),
                  Row(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 5),
                        child: Text(
                          (article.superChapterName != null
                                  ? article.superChapterName + ' · '
                                  : '') +
                              (article.chapterName ?? ''),
                          style: Theme.of(context).textTheme.overline,
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: Padding(
            padding: EdgeInsets.only(bottom: 10, right: 20),
            child: Consumer<ProjectPageStore>(
              builder: (_, pageStore, __) {
                return GestureDetector(
                  child: Icon(Icons.favorite),
                  onTap: () {
                    pageStore.refresh();
                  },
                );
              },
            ),
          ),
        )
      ],
    );
  }

  _buildTitle(BuildContext context, String title) {
    return Html(
      data: title,
      useRichText: false,
      padding: EdgeInsets.symmetric(vertical: 5),
      defaultTextStyle: Theme.of(context).textTheme.subtitle,
    );
  }
}
