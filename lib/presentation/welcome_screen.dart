import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:home_furniture_ui/constants/number_constant.dart';
import 'package:home_furniture_ui/constants/string_const.dart';
import 'package:home_furniture_ui/core/app_colors.dart';
import 'package:home_furniture_ui/core/app_textstyles.dart';
import 'package:home_furniture_ui/core/asset_res.dart';
import 'package:home_furniture_ui/routing/router.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: .expand,
        children: [
          Image.asset(AssetRes.welcomeImg, fit: .cover, width: double.infinity, height: double.infinity),
          const Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: .topCenter,
                  end: .bottomCenter,
                  colors: [AppColors.welcomeGradientEnd, AppColors.welcomeGradientStart],
                  stops: [0.38, 1],
                ),
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: .fromLTRB(
                NumberConstant.horizontalPadding,
                NumberConstant.welcomeHeadlineTop,
                NumberConstant.horizontalPadding,
                NumberConstant.welcomeCtaBottom,
              ),
              child: Column(
                crossAxisAlignment: .start,
                children: [
                  _buildHeadline(),
                  const Spacer(),
                  _buildCta(context),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeadline() {
    return Column(
      crossAxisAlignment: .start,
      spacing: NumberConstant.welcomeHeadlineLineSpacing,
      children: [
        Text(StringConst.welcomeHeadlineExplore, style: AppTextStyles.welcomeHeadline),
        Text(StringConst.welcomeHeadlineAndGet, style: AppTextStyles.welcomeHeadline),
        Text(StringConst.welcomeHeadlineInspired, style: AppTextStyles.welcomeHeadline),
      ],
    );
  }

  Widget _buildCta(BuildContext context) {
    return GestureDetector(
      onTap: () => context.go(NamedRoutes.home.routeName),
      child: Row(
        children: [
          Stack(
            clipBehavior: .none,
            children: [
              Positioned(
                left: NumberConstant.welcomeCtaOutlineInset,
                top: -NumberConstant.welcomeCtaOutlineInset,
                right: -NumberConstant.welcomeCtaOutlineInset,
                bottom: NumberConstant.welcomeCtaOutlineInset,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    shape: .circle,
                    border: .all(color: AppColors.whiteColor, width: 1.5),
                  ),
                ),
              ),
              DecoratedBox(
                decoration: const BoxDecoration(color: AppColors.accentColor, shape: .circle),
                child: Padding(
                  padding: .symmetric(
                    horizontal: NumberConstant.welcomeCtaHorizontalPadding,
                    vertical: NumberConstant.welcomeCtaVerticalPadding,
                  ),
                  child: Transform.rotate(
                    angle: NumberConstant.welcomeLetsGoRotation,
                    child: Text(StringConst.welcomeCta, style: AppTextStyles.welcomeCta),
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: SvgPicture.asset(
              AssetRes.icLetsGoArrow,
              width: NumberConstant.welcomeArrowWidth,
              height: NumberConstant.welcomeArrowHeight,
              fit: .contain,
            ),
          ),
        ],
      ),
    );
  }
}
