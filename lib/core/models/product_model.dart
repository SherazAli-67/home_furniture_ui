import 'package:flutter/material.dart';

class ProductModel {
  final String id;
  final String name;
  final String title;
  final String price;
  final String category;
  final String imageAsset;
  final String description;
  final List<Color> colors;
  final bool isTall;

  const ProductModel({
    required this.id,
    required this.name,
    required this.title,
    required this.price,
    required this.category,
    required this.imageAsset,
    required this.description,
    required this.colors,
    this.isTall = false,
  });
}
