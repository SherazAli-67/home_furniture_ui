import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:home_furniture_ui/constants/number_constant.dart';
import 'package:home_furniture_ui/core/app_colors.dart';
import 'package:home_furniture_ui/core/asset_res.dart';
import 'package:home_furniture_ui/providers/favorites_provider.dart';
import 'package:provider/provider.dart';

class FavoriteButton extends StatelessWidget {
  final String productId;
  final Color backgroundColor;
  final double padding;

  const FavoriteButton({
    super.key,
    required this.productId,
    this.backgroundColor = AppColors.favoriteOverlayColor,
    this.padding = NumberConstant.favoriteButtonPadding,
  });

  @override
  Widget build(BuildContext context) {
    final isFavorite = context.watch<FavoritesProvider>().isFavorite(productId);
    return GestureDetector(
      onTap: () => context.read<FavoritesProvider>().toggleFavorite(productId),
      child: DecoratedBox(
        decoration: BoxDecoration(color: backgroundColor, shape: .circle),
        child: Padding(
          padding: .all(padding),
          child: SvgPicture.asset(AssetRes.icFavorite, colorFilter: .mode(isFavorite ? AppColors.accentColor : AppColors.whiteColor, .srcIn),),
        ),
      ),
    );
  }
}
