import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:fun_wanandroid/generated/i18n.dart';
import 'package:fun_wanandroid/helper/image_helper.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

typedef WrapBuilder<T> = Widget Function(
    BuildContext context, T data, VoidFutureCallBack refresh);
typedef FutureFunction<S, T> = ObservableFuture<T> Function(S store);
typedef FutureSupplier<T> = ObservableFuture<T> Function();
typedef Func<T> = Widget Function(T item);

class WidgetHelper {
  static WillPopCallback _onWillPop() {
    DateTime _lastPressed;
    return () async {
      if (_lastPressed == null ||
          DateTime.now().difference(_lastPressed) > Duration(seconds: 1)) {
        //两次点击间隔超过1秒则重新计时
        _lastPressed = DateTime.now();
        return false;
      }
      return true;
    };
  }

  static Widget popScope({@required Widget child, Key key}) {
    return WillPopScope(
      key: key,
      onWillPop: _onWillPop(),
      child: child,
    );
  }

  static Widget observerWrap<T>(
      {@required FutureSupplier supplier,
      @required WrapBuilder<T> builder,
      VoidFutureCallBack refresh,
      Widget loading}) {
    return Observer(
      builder: (context) {
        ObservableFuture future = supplier();
        debugPrint(
            '==============future.status:${future.status}==============');
        switch (future.status) {
          case FutureStatus.pending:
            return loading ??
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    CircularProgressIndicator(),
                    Text('Loading items...'),
                  ],
                );

          case FutureStatus.rejected:
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                  'Failed to load items.',
                  style: TextStyle(color: Colors.red),
                ),
                RaisedButton(
                  child: const Text('Tap to try again'),
                  onPressed: refresh,
                )
              ],
            );

          default:
            final T result = future.result;
            return builder(context, result, refresh);
        }
      },
    );
  }

  static Widget navigator<T>(
      {@required List<T> data,
      @required Func<T> builder,
      BoxDecoration decoration,
      EdgeInsetsGeometry margin = const EdgeInsets.only(right: 20)}) {
    return Container(
      margin: margin,
      decoration: decoration,
      child: TabBar(
          isScrollable: true,
          indicatorSize: TabBarIndicatorSize.tab,
          tabs: List.generate(
            data.length,
            (i) => builder(data[i]),
          )),
    );
  }
}

class OnlyTips extends StatelessWidget {
  final Widget header;
  final String tips;
  final String buttonTips;
  final VoidCallback onPressed;
  const OnlyTips(
      {Key key,
      this.header,
      this.tips,
      this.buttonTips,
      @required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          header ??
              Icon(IconFonts.pageError, size: 80, color: Colors.grey[500]),
          Padding(
            padding: EdgeInsets.fromLTRB(30, 20, 30, 150),
            child: Text(
              tips ?? I18n.of(context).operatorError,
              style: Theme.of(context)
                  .textTheme
                  .body1
                  .copyWith(color: Colors.grey),
            ),
          ),
          OutlineButton(
            onPressed: onPressed,
            child: Text(buttonTips ?? I18n.of(context).back,
                style: TextStyle(wordSpacing: 5)),
            highlightedBorderColor: Theme.of(context).splashColor,
            splashColor: Theme.of(context).splashColor,
            textColor: Colors.grey,
          ),
        ],
      ),
    );
  }
}

class ConsumerObserver<T> extends StatelessWidget {
  final Widget Function(BuildContext context, T value, Widget child) builder;
  final Widget child;

  const ConsumerObserver({Key key, this.builder, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<T>(
      builder: (_, store, __) {
        return Observer(
          builder: (BuildContext context) {
            return builder(context, store, __);
          },
        );
      },
      child: child,
    );
  }
}

class ConsumerObserver2<T1, T2> extends StatelessWidget {
  final Widget Function(BuildContext context, T1 t1, T2 t2, Widget child)
      builder;
  final Widget child;

  const ConsumerObserver2({Key key, this.builder, this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer2<T1, T2>(
      builder: (_, t1, t2, __) {
        return Observer(
          builder: (BuildContext context) {
            return builder(context, t1, t2, __);
          },
        );
      },
      child: child,
    );
  }
}
