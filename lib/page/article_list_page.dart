import 'package:flutter/material.dart';
import 'package:fun_wanandroid/component/article_list_item.dart';
import 'package:fun_wanandroid/component/skeleton_component.dart';
import 'package:fun_wanandroid/generated/i18n.dart';
import 'package:fun_wanandroid/helper/image_helper.dart';
import 'package:fun_wanandroid/helper/widget_helper.dart';
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
          return FutureObserver<Map<String, dynamic>>(
            loading: SkeletonList(
              builder: (BuildContext context, int index) => SkeletonListItem(),
            ),
            supplier: () => store.fetchFutrue,
            refresh: store.refresh,
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
