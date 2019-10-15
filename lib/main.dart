import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:fun_wanandroid/generated/i18n.dart';
import 'package:fun_wanandroid/init/initializer.dart';
import 'package:fun_wanandroid/route/routes.dart';
import 'package:fun_wanandroid/store/category_store.dart';
import 'package:fun_wanandroid/store/preferences_service.dart';
import 'package:fun_wanandroid/store/settings_store.dart';
import 'package:fun_wanandroid/store/user_store.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

void main() async => Application.init().then((_) => runApp(MyApp()));

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<PreferencesService>(
          builder: (_) =>
              PreferencesService(sharedPreferences: Application.prefs),
        ),
        ProxyProvider<PreferencesService, SettingsStore>(
            builder: (_, preferencesService, __) =>
                SettingsStore(preferencesService)),
        Provider(
          builder: (_) => CategorytStore(),
        ),
        ProxyProvider<PreferencesService, UserStore>(
          builder: (_, preferencesService, __) => UserStore(preferencesService),
        )
      ],
      child: Consumer<SettingsStore>(
        builder: (_, settingsStore, __) => Observer(
          builder: (context) {
            return RefreshConfiguration(
              hideFooterWhenNotFull: true,
              child: MaterialApp(
                debugShowCheckedModeBanner: false,
                localizationsDelegates: [
                  I18n.delegate,
                  // 本地化的代理类
                  // Refresh
                  RefreshLocalizations.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate, // <-- needed for iOS
                ],
                supportedLocales: I18n.delegate.supportedLocales,
                title: 'Flutter',
                locale: settingsStore.locale,
                // localeResolutionCallback: I18n.delegate.resolution(),
                theme: ThemeData(
                    primarySwatch: Colors.primaries[settingsStore.icolor],
                    brightness: settingsStore.useDarkMode
                        ? Brightness.dark
                        : Brightness.light,
                    accentColor: settingsStore.useDarkMode
                        ? Colors.primaries[settingsStore.icolor][300]
                        : null),
                onGenerateRoute: Routes.router.generator,
              ),
            );
          },
        ),
      ),
    );
  }
}
