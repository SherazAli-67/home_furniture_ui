import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:home_furniture_ui/constants/number_constant.dart';
import 'package:home_furniture_ui/constants/string_const.dart';
import 'package:home_furniture_ui/core/app_colors.dart';
import 'package:home_furniture_ui/core/app_data.dart';
import 'package:home_furniture_ui/core/app_textstyles.dart';
import 'package:home_furniture_ui/core/asset_res.dart';
import 'package:home_furniture_ui/core/models/product_model.dart';
import 'package:home_furniture_ui/presentation/widgets/favorite_button.dart';
import 'package:home_furniture_ui/providers/cart_provider.dart';
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
              sliver: SliverToBoxAdapter(
                child: Column(
                  children: [
                    _buildHeader(context),
                    const SizedBox(height: 30,),
                    _buildSearchField(context),
                    _buildBanner(),
                    const SizedBox(height: 30,),
                    _buildCategories(context),
                    const SizedBox(height: 30,),
                    _buildProductGrid(context),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
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
              //homeHeadlineOne, homeHeadline,

              //homeHeadlineTwo, homeHeadline
            ],
          ),
        ),
        ClipOval(
          //profilePicture, 52
          child: const SizedBox()
        )
      ],
    );
  }

  Widget _buildSearchField(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        // color: AppColors.searchFillColor,
        // borderRadius: .circular(NumberConstant.searchFieldRadius),
      ),
      child: Padding(
        padding: .symmetric(horizontal: NumberConstant.searchIconPadding, vertical: NumberConstant.smallSpacing),
        child: Row(
          spacing: NumberConstant.smallSpacing,
          children: [
            //icSearch,
            Expanded(
              child: TextField(
                onChanged: context.read<HomeProvider>().updateSearch,
                style: AppTextStyles.searchHint.copyWith(color: AppColors.blackColor),
                cursorColor: AppColors.blackColor,
                decoration: const InputDecoration(
                  isDense: true,
                  border: .none,
                  hintText: '',
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
                // color: AppColors.blackColor,
                // borderRadius: .circular(NumberConstant.bannerRadius),
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
                        //bannerTitleLineOne, bannerTitle,
                        //bannerTitleLineTwo, bannerTitle,
                      ],
                    ),
                    Row(
                      spacing: NumberConstant.smallSpacing,
                      children: [
                        DecoratedBox(
                          decoration: BoxDecoration(
                            // color: AppColors.accentColor,
                            // borderRadius: .circular(NumberConstant.offerBadgeRadius),
                          ),
                          child: Padding(
                            padding: .symmetric(
                              horizontal: NumberConstant.offerBadgeHorizontalPadding,
                              vertical: NumberConstant.offerBadgeVerticalPadding,
                            ),
                            //bannerOfferPercent, bannerOfferBadge
                            child: const SizedBox()
                          ),
                        ),
                        //bannerOfferLabel, bannerOfferLabel

                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            // right: -NumberConstant.bannerImageOverflowRight,
            // top: -20,
            height: NumberConstant.bannerHeight + NumberConstant.bannerImageOverflowTop + NumberConstant.bannerImageOverflowBottom,
            child: const SizedBox()
            //classBlackBannerImage
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
            child: DecoratedBox(
              decoration: BoxDecoration(
                // color: isSelected ? AppColors.blackColor : AppColors.surfaceGrayColor,
                // borderRadius: .circular(NumberConstant.chipRadius),
              ),
              child: Padding(
                padding: .symmetric(
                  horizontal: NumberConstant.chipHorizontalPadding,
                  vertical: NumberConstant.chipVerticalPadding,
                ),
                child: Center(
                  //category, isSelected ? categorySelected : categoryUnselected
                  child: const SizedBox()
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildProductGrid(BuildContext context) {
    final products = context.watch<HomeProvider>().filteredProducts;
    final leftProducts = <ProductModel>[];
    final rightProducts = <ProductModel>[];
    for (var i = 0; i < products.length; i++) {
      if (i.isEven) {
        leftProducts.add(products[i]);
      } else {
        rightProducts.add(products[i]);
      }
    }
    return Row(
      crossAxisAlignment: .start,
      spacing: NumberConstant.productGridGap,
      children: [
        Expanded(
          child: Column(
            spacing: NumberConstant.productGridGap,
            children: leftProducts.map((product) => _buildProductCard(context, product)).toList(),
          ),
        ),
        Expanded(
          child: Column(
            spacing: NumberConstant.productGridGap,
            children: rightProducts.map((product) => _buildProductCard(context, product)).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildProductCard(BuildContext context, ProductModel product) {
    return GestureDetector(
      onTap: () => context.push('${NamedRoutes.detail.routeName}/${product.id}'),
      child: Column(
        crossAxisAlignment: .start,
        spacing: NumberConstant.productInfoSpacing,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: .circular(NumberConstant.productCardRadius),
                child: const SizedBox()
                //product.imageAsset, width.infinity, height: product.isTall ? productTallHeight: productShortHeight, fit.cover

              ),
              Positioned(
                top: NumberConstant.productFavoriteInset,
                right: NumberConstant.productFavoriteInset,
                child: const SizedBox(),
                // child: FavoriteButton(productId: product.id),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: .start,
            spacing: NumberConstant.homeHeaderSpacing / 2,
            children: [
              //product.price, productPrice
              //product.name, productName
            ],
          ),
        ],
      ),
    );
  }
}
