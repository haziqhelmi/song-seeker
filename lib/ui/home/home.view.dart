import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:song_seeker/core/constant/asset.constant.dart';
import 'package:song_seeker/core/extension/widget.extension.dart';
import 'package:song_seeker/core/navigation/navigation.constant.dart';
import 'package:song_seeker/core/navigation/navigation.service.dart';
import 'package:song_seeker/ui/shared/style/theme_color.dart';
import 'package:song_seeker/ui/shared/style/theme_style.dart';

class HomeView extends ConsumerWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: _buildBody(ref, context),
    );
  }

  Widget _buildBody(WidgetRef ref, BuildContext context) {
    return Stack(
      children: [
        _buildLogo(),
        _buildButtons(ref, context),
      ],
    ).paddingSymmetric(horizontal: 32);
  }

  Widget _buildLogo() {
    return Align(
      alignment: Alignment.topCenter,
      child: Image.asset(
        AssetConstant.logoTransparent,
        height: 200,
        width: 200,
      ).paddingOnly(top: 24),
    ).safeArea();
  }

  Widget _buildButtons(WidgetRef ref, BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildNavButton(
            context: context,
            label: 'Top 500',
            icon: Icons.format_list_numbered_rounded,
            onPressed: () => ref
                .read(navigationService)
                .navigateTo(NavConstant.rankingRoute),
          ).paddingOnly(bottom: 16),
          _buildNavButton(
            context: context,
            isPrimary: false,
            label: 'Search Song',
            icon: Icons.manage_search_rounded,
            onPressed: () =>
                ref.read(navigationService).navigateTo(NavConstant.searchRoute),
          ),
        ],
      ),
    );
  }

  MaterialButton _buildNavButton({
    required BuildContext context,
    required String label,
    required IconData icon,
    required VoidCallback onPressed,
    bool isPrimary = true,
  }) {
    return MaterialButton(
      color: isPrimary ? ThemeColor.primaryYellow : ThemeColor.primaryBlue,
      splashColor:
          isPrimary ? ThemeColor.primaryBlue : ThemeColor.primaryYellow,
      highlightColor: Colors.transparent,
      minWidth: MediaQuery.of(context).size.width,
      height: 72,
      elevation: 0,
      padding: EdgeInsets.symmetric(horizontal: 24),
      onPressed: onPressed,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundColor: ThemeColor.black,
                maxRadius: 20,
                child: Icon(
                  icon,
                  color: isPrimary
                      ? ThemeColor.primaryYellow
                      : ThemeColor.primaryBlue,
                ),
              ).paddingOnly(right: 16),
              Text(
                label,
                style: ThemeStyle.subHeading500.copyWith(
                  color: ThemeColor.black,
                ),
              ),
            ],
          ),
          Icon(Icons.east_rounded, color: ThemeColor.black)
        ],
      ),
    );
  }
}
