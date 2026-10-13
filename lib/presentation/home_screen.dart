import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:home_furniture_ui/constants/animation_constant.dart';
import 'package:home_furniture_ui/constants/number_constant.dart';
import 'package:home_furniture_ui/constants/string_const.dart';
import 'package:home_furniture_ui/core/app_colors.dart';
import 'package:home_furniture_ui/core/app_data.dart';
import 'package:home_furniture_ui/core/app_textstyles.dart';
import 'package:home_furniture_ui/core/asset_res.dart';
import 'package:home_furniture_ui/core/models/product_model.dart';
import 'package:home_furniture_ui/presentation/widgets/fade_slide_in.dart';
import 'package:home_furniture_ui/presentation/widgets/favorite_button.dart';
import 'package:home_furniture_ui/providers/home_provider.dart';
import 'package:home_furniture_ui/routing/router.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          clipBehavior: .none,
          slivers: [
            SliverPadding(
              padding: .fromLTRB(
                NumberConstant.horizontalPadding,
                NumberConstant.contentSpacing,
                NumberConstant.horizontalPadding,
                NumberConstant.homeBottomPadding,
              ),
              sliver: SliverToBoxAdapter(child: _buildContent(context)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Column(
      children: [
        FadeSlideIn(
          delay: const Duration(milliseconds: AnimationConstant.homeHeaderDelayMs),
          child: _buildHeader(context),
        ),
        const SizedBox(height: 30),
        FadeSlideIn(
          delay: const Duration(milliseconds: AnimationConstant.homeSearchDelayMs),
          child: _buildSearchField(context),
        ),
        FadeSlideIn(
          delay: const Duration(milliseconds: AnimationConstant.homeBannerDelayMs),
          child: _buildBanner(),
        ),
        const SizedBox(height: 30),
        FadeSlideIn(
          delay: const Duration(milliseconds: AnimationConstant.homeChipsDelayMs),
          child: _buildCategories(context),
        ),
        const SizedBox(height: 30),
        FadeSlideIn(
          delay: const Duration(milliseconds: AnimationConstant.homeGridDelayMs),
          child: _buildProductGrid(context),
        ),
      ],
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      crossAxisAlignment: .start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: .start,
            spacing: NumberConstant.homeHeaderSpacing,
            children: [
              Text(StringConst.homeHeadlineLineOne, style: AppTextStyles.homeHeadline),
              Text(StringConst.homeHeadlineLineTwo, style: AppTextStyles.homeHeadline),
            ],
          ),
        ),
        ClipOval(child: Image.asset(AssetRes.profilePicture, height: 52, width: 52)),
      ],
    );
  }

  Widget _buildSearchField(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.searchFillColor,
        borderRadius: .circular(NumberConstant.searchFieldRadius),
      ),
      child: Padding(
        padding: .symmetric(horizontal: NumberConstant.searchIconPadding, vertical: NumberConstant.smallSpacing),
        child: Row(
          spacing: NumberConstant.smallSpacing,
          children: [
            SvgPicture.asset(AssetRes.icSearch, colorFilter: .mode(AppColors.blackColor, .srcIn)),
            Expanded(
              child: TextField(
                onChanged: context.read<HomeProvider>().updateSearch,
                style: AppTextStyles.searchHint.copyWith(color: AppColors.blackColor),
                cursorColor: AppColors.blackColor,
                decoration: const InputDecoration(
                  isDense: true,
                  border: .none,
                  hintText: StringConst.searchHint,
                  hintStyle: AppTextStyles.searchHint,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBanner() {
    return SizedBox(
      height: NumberConstant.bannerHeight + NumberConstant.bannerImageOverflowTop,
      child: Stack(
        clipBehavior: .none,
        children: [
          Positioned(
            left: 0,
            right: 0,
            top: NumberConstant.bannerImageOverflowTop,
            height: NumberConstant.bannerHeight,
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: AppColors.blackColor,
                borderRadius: .circular(NumberConstant.bannerRadius),
              ),
              child: Padding(
                padding: .all(NumberConstant.bannerContentPadding),
                child: Column(
                  crossAxisAlignment: .start,
                  spacing: NumberConstant.bannerTitleSpacing,
                  children: [
                    Column(
                      crossAxisAlignment: .start,
                      spacing: NumberConstant.homeHeaderSpacing,
                      children: [
                        Text(StringConst.bannerTitleLineOne, style: AppTextStyles.bannerTitle),
                        Text(StringConst.bannerTitleLineTwo, style: AppTextStyles.bannerTitle),
                      ],
                    ),
                    Row(
                      spacing: NumberConstant.smallSpacing,
                      children: [
                        DecoratedBox(
                          decoration: BoxDecoration(
                            color: AppColors.accentColor,
                            borderRadius: .circular(NumberConstant.offerBadgeRadius),
                          ),
                          child: Padding(
                            padding: .symmetric(
                              horizontal: NumberConstant.offerBadgeHorizontalPadding,
                              vertical: NumberConstant.offerBadgeVerticalPadding,
                            ),
                            child: Text(StringConst.bannerOfferPercent, style: AppTextStyles.bannerOfferBadge),
                          ),
                        ),
                        Text(StringConst.bannerOfferLabel, style: AppTextStyles.bannerOfferLabel),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            right: -NumberConstant.bannerImageOverflowRight,
            top: -20,
            height: NumberConstant.bannerHeight + NumberConstant.bannerImageOverflowTop + NumberConstant.bannerImageOverflowBottom,
            child: FadeSlideIn(
              delay: const Duration(milliseconds: AnimationConstant.homeBannerDelayMs),
              duration: const Duration(milliseconds: AnimationConstant.animSlow),
              begin: const Offset(AnimationConstant.bannerSlideBeginDx, 0),
              child: Image.asset(AssetRes.classicBlackBanner),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategories(BuildContext context) {
    final selectedCategory = context.watch<HomeProvider>().selectedCategory;
    return Row(
      spacing: NumberConstant.smallSpacing,
      children: AppData.categories.map((category) {
        final isSelected = category == selectedCategory;
        return Expanded(
          child: GestureDetector(
            onTap: () => context.read<HomeProvider>().selectCategory(category),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: AnimationConstant.animFast),
              curve: AnimationConstant.easeOutCubic,
              decoration: BoxDecoration(
                color: isSelected ? AppColors.blackColor : AppColors.surfaceGrayColor,
                borderRadius: .circular(NumberConstant.chipRadius),
              ),
              padding: .symmetric(
                horizontal: NumberConstant.chipHorizontalPadding,
                vertical: NumberConstant.chipVerticalPadding,
              ),
              child: Center(
                child: AnimatedDefaultTextStyle(
                  duration: const Duration(milliseconds: AnimationConstant.animFast),
                  curve: AnimationConstant.easeOutCubic,
                  style: isSelected ? AppTextStyles.categorySelected : AppTextStyles.categoryUnselected,
                  child: Text(category),
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildProductGrid(BuildContext context) {
    final homeProvider = context.watch<HomeProvider>();
    final products = homeProvider.filteredProducts;
    final leftProducts = <ProductModel>[];
    final rightProducts = <ProductModel>[];
    for (var i = 0; i < products.length; i++) {
      if (i.isEven) {
        leftProducts.add(products[i]);
      } else {
        rightProducts.add(products[i]);
      }
    }
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: AnimationConstant.animNormal),
      switchInCurve: AnimationConstant.easeOutCubic,
      switchOutCurve: AnimationConstant.easeOut,
      child: KeyedSubtree(
        key: ValueKey('${homeProvider.selectedCategory}_${homeProvider.searchQuery}'),
        child: Row(
          crossAxisAlignment: .start,
          spacing: NumberConstant.productGridGap,
          children: [
            Expanded(
              child: Column(
                spacing: NumberConstant.productGridGap,
                children: [
                  for (var i = 0; i < leftProducts.length; i++)
                    _buildProductCard(context, leftProducts[i], i * 2),
                ],
              ),
            ),
            Expanded(
              child: Column(
                spacing: NumberConstant.productGridGap,
                children: [
                  for (var i = 0; i < rightProducts.length; i++)
                    _buildProductCard(context, rightProducts[i], i * 2 + 1),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProductCard(BuildContext context, ProductModel product, int index) {
    final staggerMs = (index * AnimationConstant.homeCardStaggerMs).clamp(0, AnimationConstant.homeCardStaggerMaxMs);
    return FadeSlideIn(
      delay: Duration(milliseconds: staggerMs),
      child: GestureDetector(
        onTap: () => context.push('${NamedRoutes.detail.routeName}/${product.id}'),
        child: Column(
          crossAxisAlignment: .start,
          spacing: NumberConstant.productInfoSpacing,
          children: [
            Stack(
              children: [
                Hero(
                  tag: AnimationConstant.productHeroTag(product.id),
                  child: ClipRRect(
                    borderRadius: .circular(NumberConstant.productCardRadius),
                    child: Image.asset(
                      product.imageAsset,
                      width: double.infinity,
                      height: product.isTall ? NumberConstant.productCardTallHeight : NumberConstant.productCardShortHeight,
                      fit: .cover,
                    ),
                  ),
                ),
                Positioned(
                  top: NumberConstant.productFavoriteInset,
                  right: NumberConstant.productFavoriteInset,
                  child: FavoriteButton(productId: product.id),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: .start,
              spacing: NumberConstant.homeHeaderSpacing / 2,
              children: [
                Text(product.price, style: AppTextStyles.productPrice),
                Text(product.name, style: AppTextStyles.productName),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
