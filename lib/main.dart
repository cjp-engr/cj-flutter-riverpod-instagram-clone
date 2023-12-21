import 'package:cj_flutter_riverpod_instagram_clone/common/routes/routes.dart';
import 'package:cj_flutter_riverpod_instagram_clone/common/utils/app_theme.dart';
import 'package:cj_flutter_riverpod_instagram_clone/common/utils/scroll_behavior.dart';
import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// ignore: depend_on_referenced_packages
import 'package:flutter_web_plugins/url_strategy.dart';

void main() {
  usePathUrlStrategy();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: goRouter,
      title: 'Insta Clone App',
      debugShowCheckedModeBanner: false,
      theme: themeData,
      scrollBehavior: InstaScrollBehavior(),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
    );
  }
}
