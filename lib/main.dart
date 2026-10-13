import 'package:flutter/material.dart';
import 'package:home_furniture_ui/constants/string_const.dart';
import 'package:home_furniture_ui/core/app_colors.dart';
import 'package:home_furniture_ui/providers/cart_provider.dart';
import 'package:home_furniture_ui/providers/favorites_provider.dart';
import 'package:home_furniture_ui/routing/router.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => FavoritesProvider()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
      ],
      child: MaterialApp.router(
        title: StringConst.appTitle,
        theme: ThemeData(
          brightness: .light,
          fontFamily: StringConst.appFontFamily,
          scaffoldBackgroundColor: AppColors.whiteColor,
          colorScheme: .light(
            primary: AppColors.accentColor,
            onPrimary: AppColors.blackColor,
            surface: AppColors.whiteColor,
            onSurface: AppColors.blackColor,
          ),
        ),
        routerConfig: router,
        builder: (ctx, child) => child!,
      ),
    );
  }
}
