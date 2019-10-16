import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:fun_wanandroid/generated/i18n.dart';
import 'package:fun_wanandroid/helper/function_helper.dart';
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
  final String name;
  const ConsumerObserver({Key key, this.builder, this.child, this.name})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<T>(
      builder: (_, store, __) {
        return Observer(
          name: name,
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

class ThemeTile extends StatelessWidget {
  final Widget leading;
  final Widget title;
  final Widget trailing;

  final ValueChanged<bool> onExpansionChanged;
  final int current;
  final Widget child;
  final Color backgroundColor;
  final bool initiallyExpanded;
  final ValueChanged<int> onTap;
  const ThemeTile({
    Key key,
    this.leading,
    this.title,
    this.backgroundColor,
    this.onExpansionChanged,
    this.child,
    this.trailing,
    this.initiallyExpanded = false,
    this.onTap,
    this.current,
  })  : assert(initiallyExpanded != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      leading:
          leading ?? Icon(Icons.palette, color: iconColorSupplier(context)),
      title: title ?? Text(I18n.of(context).theme),
      trailing: trailing ??
          Icon(
            Icons.keyboard_arrow_down,
          ),
      children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Wrap(
            spacing: 5,
            runSpacing: 5,
            children: Colors.primaries.asMap().entries.map((item) {
              return Material(
                color: item.value,
                child: InkWell(
                  onTap: _onTap(item.key),
                  child: Container(
                    height: 40,
                    width: 40,
                    alignment: Alignment.center,
                    child: current == item.key ? child : null,
                  ),
                ),
              );
            }).toList()
              ..add(Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: _onTap(Random().nextInt(Colors.primaries.length)),
                  child: Container(
                    decoration: BoxDecoration(
                        border:
                            Border.all(color: Theme.of(context).accentColor)),
                    height: 40,
                    width: 40,
                    child: Icon(Icons.help_outline),
                  ),
                ),
              )),
          ),
        )
      ],
    );
  }

  GestureTapCallback _onTap(int index) {
    return onTap == null ? null : () => onTap(index);
  }
}

class LanguageTile extends StatelessWidget {
  final Widget leading;
  final Widget title;
  final Widget trailing;
  final ValueChanged<bool> onExpansionChanged;
  final Locale locale;
  final Color backgroundColor;
  final bool initiallyExpanded;
  final ValueChanged<Locale> onChanged;

  const LanguageTile({
    Key key,
    this.backgroundColor,
    this.onExpansionChanged,
    this.locale,
    this.initiallyExpanded = false,
    this.onChanged,
    this.leading,
    this.title,
    this.trailing,
  })  : assert(initiallyExpanded != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      leading:
          leading ?? Icon(Icons.language, color: iconColorSupplier(context)),
      title: title ??
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(I18n.of(context).settingLanguage),
              Text(
                <Locale, ValueGetter<String>>{
                  null: () => I18n.of(context).autoBySystem,
                  ...I18n.delegate.locales
                }.entries.firstWhere((e) {
                  return e.key == locale;
                }).value(),
                style: Theme.of(context).textTheme.caption,
              ),
            ],
          ),
      children: [
        RadioListTile(
          groupValue: locale,
          value: null,
          onChanged: onChanged,
          title: Text(I18n.of(context).autoBySystem),
        )
      ]..addAll(I18n.delegate.supportedLocales
          .map((item) => RadioListTile(
                groupValue: locale,
                value: item,
                title: Text(I18n.delegate.localeName(item)),
                onChanged: onChanged,
              ))
          .toList()),
    );
  }
}
