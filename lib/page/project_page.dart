import 'package:flutter/material.dart';
import 'package:fun_wanandroid/helper/widget_helper.dart';
import 'package:fun_wanandroid/model/tree.dart';
import 'package:fun_wanandroid/page/article_list_page.dart';
import 'package:fun_wanandroid/store/project_store.dart';

class ProjectPage extends StatefulWidget {
  @override
  _ProjectPageState createState() => _ProjectPageState();
}

class _ProjectPageState extends State<ProjectPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  ProjectStore projectStore = ProjectStore();

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return WidgetHelper.observerWrap<List<Tree>>(
        supplier: () => projectStore.treesFuture,
        refresh: () async => projectStore.fetchLatest(),
        builder: (c, data, _) {
          return DefaultTabController(
            length: data.length,
            child: Scaffold(
              appBar: AppBar(
                title: Stack(
                  children: <Widget>[
                    WidgetHelper.navigator(
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
  }
}
