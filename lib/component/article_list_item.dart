
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:fun_wanandroid/helper/image_helper.dart';
import 'package:fun_wanandroid/helper/widget_helper.dart';
import 'package:fun_wanandroid/model/article.dart';
import 'package:fun_wanandroid/route/routes.dart';
import 'package:fun_wanandroid/store/user_store.dart';

/// 文章列表item
class ArticleListItem extends StatelessWidget {
  final Article article;
  final Widget mark;
  final bool hiddenFav;
  const ArticleListItem({Key key, @required this.article, this.mark, this.hiddenFav: false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Material(
          // color: Theme.of(context).accentColor.withAlpha(10),
          child: InkWell(
            onTap: () {
              Routes.router.navigateTo(context,
                  '${Routes.webview}?url=${FluroConvertUtils.fluroCnParamsEncode(article.link)}&title=${FluroConvertUtils.fluroCnParamsEncode(article.title)}',
                  transition: TransitionType.cupertino);
            },
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
                      mark ?? SizedBox.shrink(),
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
            child: hiddenFav ? SizedBox.shrink(): ConsumerObserver<UserStore>(
              builder: (context, userStore, child) {
                bool has = userStore.hasFav(article.id);
                return GestureDetector(
                  child: Icon(has
                      ? Icons.favorite
                      : Icons.favorite_border),
                  onTap: () {
                    has ? userStore.removeFav(article.id): userStore.like(article.id);
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
      defaultTextStyle: Theme.of(context).textTheme.subtitle2,
    );
  }
}
