import 'package:flutter/material.dart';
import 'package:fun_wanandroid/component/article_list_item.dart';
import 'package:fun_wanandroid/component/skeleton_component.dart';
import 'package:fun_wanandroid/generated/i18n.dart';
import 'package:fun_wanandroid/helper/image_helper.dart';
import 'package:fun_wanandroid/helper/widget_helper.dart';
import 'package:fun_wanandroid/model/search.dart';
import 'package:fun_wanandroid/store/search_store.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class CustomSearchHintDelegate extends SearchDelegate {
  CustomSearchHintDelegate({
    String hintText,
  }) : super(
          searchFieldLabel: hintText,
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.search,
        );

  @override
  Widget buildLeading(BuildContext context) => IconButton(
      onPressed: () => close(context, null),
      icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow, progress: transitionAnimation));

  @override
  Widget buildSuggestions(BuildContext context) => Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(I18n.of(context).searchHot),
                Consumer<SearchStore>(
                    builder: (_, store, __) => FlatButton.icon(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40)),
                          // splashColor: Colors.transparent,
                          // highlightColor: Colors.transparent,
                          icon: Icon(
                            Icons.refresh,
                            color: Colors.grey[400],
                            size: 18,
                          ),
                          label: Text(
                            I18n.of(context).searchShake,
                            style: Theme.of(context).textTheme.caption,
                          ),
                          onPressed: store.loadHotSearch,
                        ))
              ],
            ),
            ConsumerFutureObserver<SearchStore, List<SearchHotKey>>(
              supplier: (store) => store.searchHotFuture,
              builder: (_, data, refresh) => Wrap(
                spacing: 10,
                children: data
                    .map((e) => ActionChip(
                          label: Text(e.name),
                          onPressed: () {
                            query = e.name;
                            showResults(context);
                          },
                        ))
                    .toList(),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(I18n.of(context).searchHistory),
                Consumer<SearchStore>(
                  builder: (context, store, child) => FlatButton.icon(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40)),
                    // splashColor: Colors.transparent,
                    // highlightColor: Colors.transparent,
                    icon: Icon(
                      Icons.clear,
                      color: Colors.grey[400],
                      size: 18,
                    ),
                    label: Text(
                      I18n.of(context).clear,
                      style: Theme.of(context).textTheme.caption,
                    ),
                    onPressed: store.clear,
                  ),
                )
              ],
            ),
            ConsumerObserver<SearchStore>(
              builder: (_, store, __) => Wrap(
                spacing: 10,
                runSpacing: 20,
                children: store.repository
                    .map((e) => InputChip(
                          label: Text('$e'),
                          onPressed: () {
                            query = e;
                            showResults(context);
                          },
                          deleteIcon: CircleAvatar(
                            backgroundColor: Colors.black,
                            child: Icon(
                              Icons.clear,
                              color: Colors.white,
                            ),
                          ),
                          onDeleted: () => store.remove(e),
                        ))
                    .toList(),
              ),
            ),
          ],
        ),
      );

  @override
  Widget buildResults(BuildContext context) {
    if (query.isEmpty) {
      showSuggestions(context);
      return SizedBox.shrink();
    }
    return Center(
      child: Consumer<SearchStore>(
        builder: (_, store, __) {
          //更新搜索字符
          store.lastQuery = query;
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
                      ArticleListItem(
                    article: list[index],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  @override
  List<Widget> buildActions(BuildContext context) => [
        IconButton(
          icon: AnimatedIcon(
            icon: AnimatedIcons.menu_close,
            progress: transitionAnimation,
          ),
          onPressed: () {
            if (query.isEmpty) {
              close(context, null);
            } else {
              query = '';
              showSuggestions(context);
            }
          },
        )
      ];
}
