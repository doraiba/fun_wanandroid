import 'package:flutter/material.dart';
import 'package:fun_wanandroid/helper/widget_helper.dart';
import 'package:fun_wanandroid/model/tree.dart';
import 'package:fun_wanandroid/page/article_list_page.dart';
import 'package:fun_wanandroid/store/category_store.dart';
import 'package:provider/provider.dart';

class ProjectPage extends StatefulWidget {
  @override
  _ProjectPageState createState() => _ProjectPageState();
}

class _ProjectPageState extends State<ProjectPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Consumer<CategorytStore>(
      builder: (_, store, __) {
        return FutureObserver<List<Tree>>(
            supplier: () => store.treesFuture,
            refresh: () async => store.fetchLatest(),
            builder: (c, data, _) {
              return DefaultTabController(
                length: data.length,
                child: Scaffold(
                  appBar: AppBar(
                    title: Stack(
                      children: <Widget>[
                        NavigatorBuilder(
                          data: data,
                          builder: (item) => Tab(
                            text: '${item.name}',
                          ),
                        )
                      ],
                    ),
                  ),
                  body: TabBarView(
                    children: List.generate(
                        data.length,
                        (i) => ArticleListPage(
                              cid: data[i].id,
                            )),
                  ),
                ),
              );
            });
      },
    );
  }
}
