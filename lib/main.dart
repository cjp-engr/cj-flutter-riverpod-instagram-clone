import 'package:cj_flutter_riverpod_instagram_clone/common/routes/custom_navigation_helper.dart';
import 'package:cj_flutter_riverpod_instagram_clone/common/utils/app_theme.dart';
import 'package:flutter/material.dart';

void main() {
  CustomNavigationHelper.instance;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Insta Clone App',
      debugShowCheckedModeBanner: false,
      theme: themeData,
      routerConfig: CustomNavigationHelper.router,
    );
  }
}
