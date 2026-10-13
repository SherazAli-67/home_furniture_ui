import 'package:flutter/animation.dart';

class AnimationConstant {
  static const animFast = 200;
  static const animNormal = 400;
  static const animSlow = 700;
  static const welcomeIntroMs = 700;
  static const welcomePulseMs = 1200;
  static const welcomePressMs = 120;
  static const fadeSlideOffsetY = 0.22;
  static const welcomeBgScaleBegin = 1.05;
  static const welcomeCtaScaleBegin = 0.85;
  static const welcomePulseScale = 1.04;
  static const welcomePressScale = 0.92;
  static const welcomeArrowSlideBegin = -0.12;
  static const homeHeaderDelayMs = 0;
  static const homeSearchDelayMs = 80;
  static const homeBannerDelayMs = 160;
  static const homeChipsDelayMs = 240;
  static const homeGridDelayMs = 320;
  static const homeCardStaggerMs = 60;
  static const homeCardStaggerMaxMs = 240;
  static const bannerSlideBeginDx = 0.4;
  static const detailTopBarDelayMs = 200;
  static const detailCategoryDelayMs = 80;
  static const detailTitleDelayMs = 140;
  static const detailDescriptionDelayMs = 200;
  static const detailVariantsDelayMs = 260;
  static const detailCartDelayMs = 320;
  static const detailCartPressScale = 0.96;
  static const favoriteToggleScale = 1.2;

  static const easeOutCubic = Curves.easeOutCubic;
  static const easeOut = Curves.easeOut;
  static const emphasized = Curves.easeOutCubic;

  static String productHeroTag(String productId) => 'product-image-$productId';
}
