import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:fun_wanandroid/helper/widget_helper.dart';
import 'package:fun_wanandroid/model/article.dart';
import 'package:fun_wanandroid/model/navigation_site.dart';
import 'package:fun_wanandroid/model/tree.dart';
import 'package:fun_wanandroid/route/routes.dart';
import 'package:fun_wanandroid/store/category_store.dart';
import 'package:provider/provider.dart';

class ChaosPage extends StatefulWidget {
  ChaosPage({Key key}) : super(key: key);

  _ChaosPageState createState() => _ChaosPageState();
}

class _ChaosPageState extends State<ChaosPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  final List<String> list = ['体系', '导航'];
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          title: Container(
            child: NavigatorBuilder(
              data: list,
              builder: (e) => Tab(child: Text(e)),
            ),
          ),
        ),
        body: Consumer<CategorytStore>(
          builder: (_, store, __) => TabBarView(
            children: <Widget>[
              FutureObserver<List<Tree>>(
                refresh: store.fetchStructureLatest,
                supplier: () => store.structureFuture,
                builder: (_, data, __) => ChaosBody<Tree>(
                  list: data,
                  titleSupplier: (e) => e.name,
                  childrenSupplier: (e) {
                    List<Tree> _list = e.children;
                    return List.generate(
                        _list.length,
                        (i) => ActionChip(
                              onPressed: () {
                                Routes.router.navigateTo(
                                    context,
                                    Routes.chaosNav
                                        .replaceFirst(':id', e.id.toString())
                                        .replaceFirst(
                                            ':cid', _list[i].id.toString()),
                                    transition: TransitionType.cupertino);
                              },
                              label: Text(_list[i].name),
                            ));
                  },
                ),
              ),
              FutureObserver<List<NavigationSite>>(
                refresh: store.fetchNavigtorLatest,
                supplier: () => store.navigtorFuture,
                builder: (_, data, __) => ChaosBody<NavigationSite>(
                  list: data,
                  titleSupplier: (e) => e.name,
                  childrenSupplier: (e) {
                    List<Article> _list = e.articles;
                    return List.generate(
                        _list.length,
                        (i) => ActionChip(
                              onPressed: () {},
                              label: Text(_list[i].title),
                            ));
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// 每个子项
class ChaosItem extends StatelessWidget {
  /// 标题
  final String title;

  /// chip
  final List<Widget> children;
  const ChaosItem({Key key, this.title, this.children}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(title, style: Theme.of(context).textTheme.subtitle1),
          Wrap(
            runSpacing: 5,
            spacing: 8,
            children: children,
          )
        ],
      ),
    );
  }
}

class ChaosBody<T> extends StatelessWidget {
  final List<T> list;
  final String Function(T) titleSupplier;
  final List<Widget> Function(T) childrenSupplier;
  const ChaosBody(
      {Key key, this.list, this.titleSupplier, this.childrenSupplier})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      children: List.generate(
        list.length,
        (i) {
          T item = list[i];
          return ChaosItem(
            title: titleSupplier(item),
            children: childrenSupplier(item),
          );
        },
      ),
    );
  }
}
