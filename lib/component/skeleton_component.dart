import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class SkeletonList extends StatelessWidget {
  final int length;
  final EdgeInsetsGeometry padding;
  final IndexedWidgetBuilder builder;
  const SkeletonList(
      {Key key,
      this.length = 6,
      this.padding = const EdgeInsets.all(7),
      @required this.builder})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: NeverScrollableScrollPhysics(),
      child: Container(
        padding: padding,
        child: Shimmer.fromColors(
          baseColor: Colors.grey[350],
          highlightColor: Colors.grey[200],
          child: Column(
            children: List.generate(length, (i) => builder(context, i)),
          ),
        ),
      ),
    );
  }
}

class SkeletonListItem extends StatelessWidget {
  final int sort;
  const SkeletonListItem({Key key, this.sort}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      padding: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
      decoration: BoxDecoration(
          border: Border(
              bottom: Divider.createBorderSide(context,
                  color: Colors.grey, width: .7))),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                  height: 20,
                  width: 20,
                  decoration: SkeletonDecoration(circle: true)),
              Container(
                  margin: EdgeInsets.only(left: 10),
                  width: 100,
                  height: 5,
                  decoration: SkeletonDecoration()),
              Expanded(child: SizedBox.shrink()),
              Container(
                height: 5,
                width: 30,
                decoration: SkeletonDecoration(),
              )
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                height: 6.5,
                width: width * 0.7,
                margin: EdgeInsets.only(top: 10),
                decoration: SkeletonDecoration(),
              ),
              Container(
                margin: EdgeInsets.only(top: 10),
                height: 6.5,
                width: width * 0.8,
                decoration: SkeletonDecoration(),
              ),
              Container(
                height: 6.5,
                width: width * 0.5,
                margin: EdgeInsets.only(top: 10),
                decoration: SkeletonDecoration(),
              )
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(right: 10),
                height: 8,
                width: 20,
                decoration: SkeletonDecoration(),
              ),
              Container(
                height: 8,
                width: 80,
                decoration: SkeletonDecoration(),
              ),
              Expanded(
                child: SizedBox.shrink(),
              ),
              Container(
                height: 20,
                width: 20,
                decoration: SkeletonDecoration(),
              )
            ],
          )
        ],
      ),
    );
  }
}

class SkeletonDecoration extends BoxDecoration {
  final bool circle;

  SkeletonDecoration({this.circle = false})
      : super(
            color: Colors.grey[350],
            shape: circle ? BoxShape.circle : BoxShape.rectangle);
}
