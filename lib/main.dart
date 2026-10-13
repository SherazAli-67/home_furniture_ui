import 'package:flutter/material.dart';
import 'package:home_furniture_ui/constants/string_const.dart';
import 'package:home_furniture_ui/routing/router.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: StringConst.appTitle,
      theme: ThemeData(
        brightness: .light,
        fontFamily: StringConst.appFontFamily
      ),
      routerConfig: router,
      builder: (ctx, child) => child!,
    );
  }
}
