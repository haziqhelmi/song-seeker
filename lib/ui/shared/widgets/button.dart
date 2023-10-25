import 'package:flutter/material.dart';
import 'package:song_seeker/core/extension/widget.extension.dart';
import 'package:song_seeker/ui/shared/style/theme_color.dart';
import 'package:song_seeker/ui/shared/style/theme_style.dart';

class Button extends StatelessWidget {
  final String buttonText;
  final IconData? icon;
  final Function()? onPressed;

  const Button({
    required this.buttonText,
    this.icon,
    this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      highlightElevation: 0,
      focusElevation: 0,
      disabledElevation: 0,
      hoverElevation: 0,
      color: ThemeColor.primaryYellow,
      disabledColor: ThemeColor.primaryGray,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      height: 48,
      elevation: 0,
      minWidth: MediaQuery.of(context).size.width,
      onPressed: onPressed,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null)
            Icon(
              icon,
              size: 24,
              color: onPressed != null
                  ? ThemeColor.black
                  : ThemeColor.primaryYellow,
            ).paddingOnly(right: 8),
          Text(
            buttonText,
            textAlign: TextAlign.center,
            style: ThemeStyle.button.copyWith(
              color: onPressed != null
                  ? ThemeColor.black
                  : ThemeColor.primaryYellow,
            ),
          ),
        ],
      ),
    );
  }
}
