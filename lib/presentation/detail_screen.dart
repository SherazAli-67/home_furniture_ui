import 'package:flutter/material.dart';
import 'package:home_furniture_ui/core/app_data.dart';

class DetailScreen extends StatelessWidget {
  final String productId;

  const DetailScreen({super.key, required this.productId});

  @override
  Widget build(BuildContext context) {
    final product = AppData.productById(productId);
    return Scaffold(
      body: Center(child: Text(product?.title ?? productId),),
    );
  }
}
