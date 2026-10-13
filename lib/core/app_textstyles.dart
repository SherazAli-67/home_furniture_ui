import 'package:flutter/material.dart';
import 'package:home_furniture_ui/constants/string_const.dart';
import 'package:home_furniture_ui/core/app_colors.dart';

class AppTextStyles {
  static const welcomeHeadline = TextStyle(
    fontFamily: StringConst.appFontFamily,
    fontSize: 78,
    height: 1,
    letterSpacing: 1.56,
    color: AppColors.whiteColor,
    shadows: [
      Shadow(color: Color(0x59000000), offset: Offset(10, 5), blurRadius: 25),
    ],
  );

  static const welcomeCta = TextStyle(
    fontFamily: StringConst.appFontFamily,
    fontSize: 24,
    height: 1.7,
    letterSpacing: 0.47,
    color: AppColors.whiteColor,
  );

  static const homeHeadline = TextStyle(
    fontFamily: StringConst.appFontFamily,
    fontSize: 52,
    height: 1,
    letterSpacing: 1.04,
    color: AppColors.blackColor,
  );

  static const searchHint = TextStyle(
    fontFamily: StringConst.appFontFamily,
    fontSize: 15,
    height: 2,
    letterSpacing: 0.3,
    color: AppColors.hintTextColor,
  );

  static const bannerTitle = TextStyle(
    fontFamily: StringConst.appFontFamily,
    fontSize: 34,
    height: 1,
    letterSpacing: 0.78,
    color: AppColors.whiteColor,
  );

  static const bannerOfferBadge = TextStyle(
    fontFamily: StringConst.appFontFamily,
    fontSize: 13,
    height: 1,
    letterSpacing: 0.26,
    color: AppColors.blackColor,
  );

  static const bannerOfferLabel = TextStyle(
    fontFamily: StringConst.appFontFamily,
    fontSize: 13,
    height: 1,
    letterSpacing: 0.26,
    color: AppColors.whiteColor,
  );

  static const categorySelected = TextStyle(
    fontFamily: StringConst.appFontFamily,
    fontSize: 15,
    height: 1,
    letterSpacing: 0.3,
    color: AppColors.accentColor,
  );

  static const categoryUnselected = TextStyle(
    fontFamily: StringConst.appFontFamily,
    fontSize: 15,
    height: 1,
    letterSpacing: 0.3,
    color: AppColors.hintTextColor,
  );

  static const productPrice = TextStyle(
    fontFamily: StringConst.appFontFamily,
    fontSize: 35,
    height: 1.2,
    letterSpacing: 0.7,
    color: AppColors.blackColor,
  );

  static const productName = TextStyle(
    fontFamily: StringConst.appFontFamily,
    fontSize: 15,
    height: 1.4,
    letterSpacing: 0.3,
    color: AppColors.mutedTextColor,
  );

  static const detailCategory = TextStyle(
    fontFamily: StringConst.appFontFamily,
    fontSize: 15,
    height: 1,
    letterSpacing: 0.3,
    color: AppColors.blackColor,
  );

  static const detailTitle = TextStyle(
    fontFamily: StringConst.appFontFamily,
    fontSize: 39,
    height: 1,
    letterSpacing: 0.78,
    color: AppColors.blackColor,
  );

  static const detailDescription = TextStyle(
    fontFamily: StringConst.appFontFamily,
    fontSize: 15,
    height: 1.4,
    letterSpacing: 0.3,
    color: AppColors.mutedTextColor,
  );

  static const detailVariants = TextStyle(
    fontFamily: StringConst.appFontFamily,
    fontSize: 31,
    height: 1,
    letterSpacing: 0.3,
    color: AppColors.blackColor,
  );

  static const addToCart = TextStyle(
    fontFamily: StringConst.appFontFamily,
    fontSize: 31,
    height: 1,
    letterSpacing: 0.3,
    color: AppColors.whiteColor,
  );
}
