import 'package:flutter/material.dart';
import 'package:fun_wanandroid/model/tree.dart';
import 'package:fun_wanandroid/page/article_list_page.dart';
import 'package:fun_wanandroid/store/category_store.dart';
import 'package:provider/provider.dart';

class ChaosNavConsumer extends StatelessWidget {
  final String id;
  final String cid;
  const ChaosNavConsumer({Key key, this.id, this.cid}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<CategorytStore>(
      builder: (_, store, __) {
        final item =
            store.structureList.firstWhere((e) => e.id.toString() == id);
        return ChaosNavPage(
            item: MapEntry<Tree, int>(
                item,
                item.children
                    .asMap()
                    .entries
                    .firstWhere((e) => e.value.id.toString() == cid)
                    .key));
      },
    );
  }
}

class ChaosNavPage extends StatelessWidget {
  final MapEntry<Tree, int> item;

  const ChaosNavPage({Key key, this.item}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Tree _tree = item.key;
    int _index = item.value;

    return DefaultTabController(
      length: _tree.children.length,
      initialIndex: _index,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(_tree.name),
          bottom: TabBar(
            isScrollable: true,
            tabs: List.generate(
                _tree.children.length,
                (i) => Tab(
                      child: Text(_tree.children[i].name),
                    )),
          ),
        ),
        body: TabBarView(
          children: List.generate(
              _tree.children.length,
              (i) => ArticleListPage(
                    cid: _tree.children[i].id,
                  )),
        ),
      ),
    );
  }
}
