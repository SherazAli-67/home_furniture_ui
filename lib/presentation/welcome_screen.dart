import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:home_furniture_ui/constants/animation_constant.dart';
import 'package:home_furniture_ui/constants/number_constant.dart';
import 'package:home_furniture_ui/constants/string_const.dart';
import 'package:home_furniture_ui/core/app_colors.dart';
import 'package:home_furniture_ui/core/app_textstyles.dart';
import 'package:home_furniture_ui/core/asset_res.dart';
import 'package:home_furniture_ui/routing/router.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> with TickerProviderStateMixin {
  late final AnimationController _introController;
  late final AnimationController _pulseController;
  late final AnimationController _pressController;

  late final Animation<double> _bgScale;
  late final Animation<double> _line1Opacity;
  late final Animation<Offset> _line1Slide;
  late final Animation<double> _line2Opacity;
  late final Animation<Offset> _line2Slide;
  late final Animation<double> _line3Opacity;
  late final Animation<Offset> _line3Slide;
  late final Animation<double> _ctaOpacity;
  late final Animation<double> _ctaScale;
  late final Animation<double> _arrowOpacity;
  late final Animation<Offset> _arrowSlide;
  late final Animation<double> _pulseScale;
  late final Animation<double> _pressScale;

  @override
  void initState() {
    super.initState();
    _introController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: AnimationConstant.welcomeIntroMs),
    );
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: AnimationConstant.welcomePulseMs),
    );
    _pressController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: AnimationConstant.welcomePressMs),
    );

    _bgScale = Tween(begin: AnimationConstant.welcomeBgScaleBegin, end: 1.0).animate(
      CurvedAnimation(parent: _introController, curve: AnimationConstant.easeOutCubic),
    );

    _line1Opacity = _opacity(0.14, 0.55);
    _line1Slide = _slide(0.14, 0.55);
    _line2Opacity = _opacity(0.31, 0.72);
    _line2Slide = _slide(0.31, 0.72);
    _line3Opacity = _opacity(0.49, 0.90);
    _line3Slide = _slide(0.49, 0.90);

    _ctaOpacity = _opacity(0.64, 1.0);
    _ctaScale = Tween(begin: AnimationConstant.welcomeCtaScaleBegin, end: 1.0).animate(
      CurvedAnimation(parent: _introController, curve: const Interval(0.64, 1.0, curve: AnimationConstant.easeOutCubic)),
    );

    _arrowOpacity = _opacity(0.74, 1.0);
    _arrowSlide = Tween(begin: const Offset(AnimationConstant.welcomeArrowSlideBegin, 0), end: Offset.zero).animate(
      CurvedAnimation(parent: _introController, curve: const Interval(0.74, 1.0, curve: AnimationConstant.easeOutCubic)),
    );

    _pulseScale = Tween(begin: 1.0, end: AnimationConstant.welcomePulseScale).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
    _pressScale = Tween(begin: 1.0, end: AnimationConstant.welcomePressScale).animate(
      CurvedAnimation(parent: _pressController, curve: AnimationConstant.easeOut),
    );

    _introController.forward().then((_) {
      if (mounted) _pulseController.repeat(reverse: true);
    });
  }

  Animation<double> _opacity(double begin, double end) => CurvedAnimation(
        parent: _introController,
        curve: Interval(begin, end, curve: AnimationConstant.easeOut),
      );

  Animation<Offset> _slide(double begin, double end) => Tween(
        begin: const Offset(0, AnimationConstant.fadeSlideOffsetY),
        end: Offset.zero,
      ).animate(CurvedAnimation(parent: _introController, curve: Interval(begin, end, curve: AnimationConstant.easeOutCubic)));

  Future<void> _onCtaTap() async {
    _pulseController.stop();
    await _pressController.forward();
    if (!mounted) return;
    context.go(NamedRoutes.home.routeName);
  }

  @override
  void dispose() {
    _introController.dispose();
    _pulseController.dispose();
    _pressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBuilder(
        animation: Listenable.merge([_introController, _pulseController, _pressController]),
        builder: (context, _) => Stack(
          fit: .expand,
          children: [
            Transform.scale(
              scale: _bgScale.value,
              child: Image.asset(AssetRes.welcomeImg, fit: .cover, width: double.infinity, height: double.infinity),
            ),
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
                    _buildCta(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeadline() {
    return Column(
      crossAxisAlignment: .start,
      spacing: NumberConstant.welcomeHeadlineLineSpacing,
      children: [
        _buildHeadlineLine(StringConst.welcomeHeadlineExplore, _line1Opacity, _line1Slide),
        _buildHeadlineLine(StringConst.welcomeHeadlineAndGet, _line2Opacity, _line2Slide),
        _buildHeadlineLine(StringConst.welcomeHeadlineInspired, _line3Opacity, _line3Slide),
      ],
    );
  }

  Widget _buildHeadlineLine(String text, Animation<double> opacity, Animation<Offset> slide) {
    return FadeTransition(
      opacity: opacity,
      child: SlideTransition(
        position: slide,
        child: Text(text, style: AppTextStyles.welcomeHeadline),
      ),
    );
  }

  Widget _buildCta() {
    return GestureDetector(
      onTap: _onCtaTap,
      child: Row(
        children: [
          FadeTransition(
            opacity: _ctaOpacity,
            child: ScaleTransition(
              scale: _ctaScale,
              child: ScaleTransition(
                scale: _pulseScale,
                child: ScaleTransition(
                  scale: _pressScale,
                  child: Stack(
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
                ),
              ),
            ),
          ),
          Expanded(
            child: FadeTransition(
              opacity: _arrowOpacity,
              child: SlideTransition(
                position: _arrowSlide,
                child: SvgPicture.asset(
                  AssetRes.icLetsGoArrow,
                  width: NumberConstant.welcomeArrowWidth,
                  height: NumberConstant.welcomeArrowHeight,
                  fit: .contain,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
