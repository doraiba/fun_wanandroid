import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

part 'scroll_store.g.dart';

class ScrollStore = _ScrollStore with _$ScrollStore;

abstract class _ScrollStore with Store {
  final Duration duration = Duration(milliseconds: 300);

  final ScrollController scrollController;
  final double offset;

  /// 滚动距离
  @observable
  double scrollOffset;

  /// 滚动距离是否超过指定偏移量
  @computed
  bool get overHeaven => scrollOffset >= offset;

  _ScrollStore({@required this.scrollController, this.offset: 0})
      : scrollOffset = scrollController.initialScrollOffset {
    _setup();
  }

  @action
  void setScrollOffset(double scrollOffset) {
    this.scrollOffset = scrollOffset;
  }

  /// 点击返回顶部
  Future tapToTop() async {
    scrollController.animateTo(0,
        duration: duration, curve: Curves.easeOutCubic);
  }

  void _setup() {
    scrollController.addListener(overHeavenListener);
  }

  void overHeavenListener() {
    setScrollOffset(scrollController.offset);
  }

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
  }
}
