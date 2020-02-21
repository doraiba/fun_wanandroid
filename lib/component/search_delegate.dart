import 'package:flutter/material.dart';
import 'package:fun_wanandroid/generated/i18n.dart';

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
                FlatButton.icon(
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
                  onPressed: () {},
                )
              ],
            ),
            Wrap(
              spacing: 10,
              runSpacing: 20,
              children: <Widget>[
                ActionChip(
                  label: Text('data'),
                  onPressed: () {},
                ),
                ActionChip(
                  label: Text('data'),
                  onPressed: () {},
                ),
                ActionChip(
                  label: Text('data'),
                  onPressed: () {},
                ),
                ActionChip(
                  label: Text('data'),
                  onPressed: () {},
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(I18n.of(context).searchHistory),
                FlatButton.icon(
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
                  onPressed: () {},
                )
              ],
            ),
            Wrap(
              spacing: 10,
              runSpacing: 20,
              children: <Widget>[
                ActionChip(
                  label: Text('data'),
                  onPressed: () {},
                ),
                ActionChip(
                  label: Text('data'),
                  onPressed: () {},
                ),
                ActionChip(
                  label: Text('data'),
                  onPressed: () {},
                ),
                ActionChip(
                  label: Text('data'),
                  onPressed: () {},
                ),
              ],
            ),
          ],
        ),
      );

  @override
  Widget buildResults(BuildContext context) => Text('results');

  @override
  List<Widget> buildActions(BuildContext context) => [
        IconButton(
          icon: AnimatedIcon(
            icon: AnimatedIcons.add_event,
            progress: transitionAnimation,
          ),
          onPressed: () {},
        )
      ];
}
