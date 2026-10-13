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
import 'package:home_furniture_ui/providers/cart_provider.dart';
import 'package:home_furniture_ui/providers/detail_provider.dart';
import 'package:provider/provider.dart';

class DetailScreen extends StatelessWidget {
  final String productId;

  const DetailScreen({super.key, required this.productId});

  @override
  Widget build(BuildContext context) {
    final product = AppData.productById(productId);
    if (product == null) {
      return Scaffold(
        body: Center(
          child: GestureDetector(
            onTap: () => context.pop(),
            child: Text(productId, style: AppTextStyles.detailTitle),
          ),
        ),
      );
    }
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(child: _buildHero(context, product)),
          SliverToBoxAdapter(child: _buildDetails(context, product)),
        ],
      ),
    );
  }

  Widget _buildHero(BuildContext context, ProductModel product) {
    return SizedBox(
      height: NumberConstant.detailHeroHeight - NumberConstant.detailSheetOverlap,
      child: Stack(
        clipBehavior: .none,
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: NumberConstant.detailHeroHeight,
            child: Hero(
              tag: AnimationConstant.productHeroTag(product.id),
              child: Image.asset(product.imageAsset, fit: .cover, width: double.infinity, height: NumberConstant.detailHeroHeight),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: .symmetric(horizontal: NumberConstant.detailTopBarPadding, vertical: NumberConstant.contentSpacing),
              child: FadeSlideIn(
                delay: const Duration(milliseconds: AnimationConstant.detailTopBarDelayMs),
                duration: const Duration(milliseconds: AnimationConstant.animNormal),
                child: Row(
                  mainAxisAlignment: .spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () => context.pop(),
                      child: DecoratedBox(
                        decoration: const BoxDecoration(color: AppColors.favoriteOverlayColor, shape: .circle),
                        child: Padding(
                          padding: .all(NumberConstant.detailActionPadding),
                          child: SvgPicture.asset(AssetRes.icArrowBack),
                        ),
                      ),
                    ),
                    FavoriteButton(productId: product.id, padding: NumberConstant.detailActionPadding),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetails(BuildContext context, ProductModel product) {
    return ColoredBox(
      color: AppColors.whiteColor,
      child: Padding(
        padding: .fromLTRB(
          NumberConstant.horizontalPadding,
          NumberConstant.contentSpacing,
          NumberConstant.horizontalPadding,
          NumberConstant.detailBottomPadding,
        ),
        child: Column(
          crossAxisAlignment: .start,
          spacing: NumberConstant.detailSectionSpacing,
          children: [
            FadeSlideIn(
              delay: const Duration(milliseconds: AnimationConstant.detailCategoryDelayMs),
              child: _buildCategoryChip(product.category),
            ),
            FadeSlideIn(
              delay: const Duration(milliseconds: AnimationConstant.detailTitleDelayMs),
              child: _buildTitleRow(product),
            ),
            FadeSlideIn(
              delay: const Duration(milliseconds: AnimationConstant.detailDescriptionDelayMs),
              child: Text(product.description, style: AppTextStyles.detailDescription),
            ),
            FadeSlideIn(
              delay: const Duration(milliseconds: AnimationConstant.detailVariantsDelayMs),
              child: _buildVariants(context, product),
            ),
            FadeSlideIn(
              delay: const Duration(milliseconds: AnimationConstant.detailCartDelayMs),
              child: const _AddToCartButton(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryChip(String category) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.surfaceGrayColor,
        borderRadius: .circular(NumberConstant.detailCategoryRadius),
      ),
      child: Padding(
        padding: .symmetric(
          horizontal: NumberConstant.detailCategoryHorizontalPadding,
          vertical: NumberConstant.detailCategoryVerticalPadding,
        ),
        child: Text(category, style: AppTextStyles.detailCategory),
      ),
    );
  }

  Widget _buildTitleRow(ProductModel product) {
    return Row(
      crossAxisAlignment: .start,
      spacing: NumberConstant.detailTitleSpacing,
      children: [
        Expanded(child: Text(product.title, style: AppTextStyles.detailTitle)),
        Text(product.price, style: AppTextStyles.productPrice),
      ],
    );
  }

  Widget _buildVariants(BuildContext context, ProductModel product) {
    final selectedIndex = context.watch<DetailProvider>().selectedVariantIndex;
    return Column(
      crossAxisAlignment: .start,
      spacing: NumberConstant.detailVariantsSpacing,
      children: [
        Text(StringConst.detailVariants, style: AppTextStyles.detailVariants),
        Row(
          spacing: NumberConstant.variantSpacing,
          children: [
            for (var i = 0; i < product.colors.length; i++)
              GestureDetector(
                onTap: () => context.read<DetailProvider>().selectVariant(i),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: AnimationConstant.animFast),
                  curve: AnimationConstant.easeOutCubic,
                  decoration: BoxDecoration(
                    shape: .circle,
                    border: i == selectedIndex
                        ? .all(color: AppColors.accentColor, width: NumberConstant.variantSelectedBorderWidth)
                        : .all(color: Colors.transparent, width: NumberConstant.variantSelectedBorderWidth),
                  ),
                  padding: .all(NumberConstant.variantPadding),
                  child: DecoratedBox(
                    decoration: BoxDecoration(color: product.colors[i], shape: .circle),
                    child: const Padding(padding: .all(NumberConstant.variantInnerPadding)),
                  ),
                ),
              ),
          ],
        ),
      ],
    );
  }
}

class _AddToCartButton extends StatefulWidget {
  const _AddToCartButton();

  @override
  State<_AddToCartButton> createState() => _AddToCartButtonState();
}

class _AddToCartButtonState extends State<_AddToCartButton> {
  bool _pressed = false;

  Future<void> _onTap() async {
    setState(() => _pressed = true);
    await Future<void>.delayed(const Duration(milliseconds: AnimationConstant.welcomePressMs));
    if (!mounted) return;
    context.read<CartProvider>().addToCart();
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text(StringConst.addedToCart)));
    setState(() => _pressed = false);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onTap,
      child: AnimatedScale(
        scale: _pressed ? AnimationConstant.detailCartPressScale : 1,
        duration: const Duration(milliseconds: AnimationConstant.welcomePressMs),
        curve: AnimationConstant.easeOutCubic,
        child: DecoratedBox(
          decoration: const BoxDecoration(color: AppColors.blackColor),
          child: Padding(
            padding: .symmetric(vertical: NumberConstant.cartButtonVerticalPadding),
            child: Row(
              mainAxisAlignment: .center,
              spacing: NumberConstant.cartButtonIconSpacing,
              children: [
                SvgPicture.asset(AssetRes.icCart, colorFilter: .mode(AppColors.accentColor, .srcIn)),
                Text(StringConst.addToCart, style: AppTextStyles.addToCart),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
