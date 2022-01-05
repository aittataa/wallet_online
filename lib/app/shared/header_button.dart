import 'package:flutter/material.dart';

import '../config/app_constant.dart';
import '../config/app_theme.dart';

class HeaderButton extends StatelessWidget {
  final String title;
  final IconData icon;
  final bool state;
  final Function()? onPressed;
  const HeaderButton({
    Key? key,
    required this.title,
    required this.icon,
    this.state = false,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: MaterialButton(
        onPressed: onPressed,
        padding: const EdgeInsets.only(bottom: 5),
        color: AppTheme.transparentColor,
        highlightColor: AppTheme.transparentColor,
        splashColor: AppTheme.transparentColor,
        elevation: 0,
        highlightElevation: 0,
        animationDuration: AppConstant.durationPage,
        shape: Border(
          bottom: BorderSide(
            width: 3,
            color: state ? AppTheme.mainColor : AppTheme.transparentColor,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(icon, color: AppTheme.primaryIconColor.withOpacity(.75)),
            const SizedBox(width: 20),
            Text(
              "$title",
              style: TextStyle(
                color: AppTheme.primaryTextColor.withOpacity(.75),
                fontWeight: FontWeight.w900,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
