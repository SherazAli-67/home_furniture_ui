import 'package:flutter/material.dart';
import 'package:home_furniture_ui/constants/string_const.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text(StringConst.homeHeadlineLineOne),),
    );
  }
}
