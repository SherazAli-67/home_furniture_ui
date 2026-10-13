import 'package:flutter/material.dart';
import 'package:home_furniture_ui/constants/string_const.dart';
import 'package:home_furniture_ui/core/app_colors.dart';
import 'package:home_furniture_ui/core/asset_res.dart';
import 'package:home_furniture_ui/core/models/product_model.dart';

class AppData {
  static const categories = [
    StringConst.categoryAll,
    StringConst.categoryChair,
    StringConst.categoryTable,
    StringConst.categoryLamp,
  ];

  static const products = [
    ProductModel(
      id: '1',
      name: StringConst.productRelaxingChair,
      title: StringConst.productRelaxingChairTitle,
      price: StringConst.priceRelaxingChair,
      category: StringConst.categoryChair,
      imageAsset: AssetRes.detailScreenImg,
      description: StringConst.productRelaxingChairDescription,
      colors: [
        AppColors.accentColor,
        Color(0xFF2F2A26),
        Color(0xFF8B5A2B),
        Color(0xFFD6C6A8),
      ],
      isTall: true,
    ),

    ProductModel(
      id: '4',
      name: StringConst.productSoftLamp,
      title: StringConst.productSoftLampTitle,
      price: StringConst.priceSoftLamp,
      category: StringConst.categoryLamp,
      imageAsset: AssetRes.welcomeImg,
      description: StringConst.productSoftLampDescription,
      colors: [
        AppColors.accentColor,
        Color(0xFF3D3D3D),
        Color(0xFFBFA98A),
        Color(0xFFF5F0E8),
      ],
    ),

    ProductModel(
      id: '3',
      name: StringConst.productOakTable,
      title: StringConst.productOakTableTitle,
      price: StringConst.priceOakTable,
      category: StringConst.categoryTable,
      imageAsset: AssetRes.classicBlackBanner,
      description: StringConst.productOakTableDescription,
      colors: [
        AppColors.accentColor,
        Color(0xFF6B4F2A),
        Color(0xFFA67C52),
        Color(0xFFE8DCC8),
      ],
      isTall: true,
    ),
    ProductModel(
      id: '2',
      name: StringConst.productNoirChair,
      title: StringConst.productNoirChairTitle,
      price: StringConst.priceNoirChair,
      category: StringConst.categoryChair,
      imageAsset: AssetRes.detailScreenImg,
      description: StringConst.productNoirChairDescription,
      colors: [
        AppColors.accentColor,
        Color(0xFF1A1A1A),
        Color(0xFF4A3F35),
        Color(0xFFC4B7A6),
      ],
    ),

  ];

  static ProductModel? productById(String id) {
    for (final product in products) {
      if (product.id == id) return product;
    }
    return null;
  }

  static List<ProductModel> productsByCategory(String category) {
    if (category == StringConst.categoryAll) return products;
    return products.where((product) => product.category == category).toList();
  }
}
