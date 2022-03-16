import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../config/app_constant.dart';
import '../../../config/app_message.dart';
import '../../../config/app_theme.dart';

class FooterBar extends StatelessWidget {
  final int currentIndex;
  final Function(int)? onTap;
  const FooterBar({
    Key? key,
    required this.currentIndex,
    this.onTap,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      onTap: onTap,
      currentIndex: currentIndex,
      elevation: AppConstant.elevation,
      type: BottomNavigationBarType.fixed,
      backgroundColor: AppTheme.primaryBackColor,
      selectedItemColor: AppTheme.mainColor,
      unselectedItemColor: AppTheme.primaryIconColor.withOpacity(.5),
      selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
      showUnselectedLabels: false,
      items: [
        BottomNavigationBarItem(
          label: AppMessage.labelHome,
          icon: Icon(CupertinoIcons.house_alt),
          activeIcon: Icon(CupertinoIcons.house_alt_fill),
        ),
        BottomNavigationBarItem(
          label: AppMessage.labelCategories,
          icon: Icon(CupertinoIcons.layers_alt),
          activeIcon: Icon(CupertinoIcons.layers_alt_fill),
        ),
        BottomNavigationBarItem(
          label: AppMessage.labelStatistic,
          icon: Icon(CupertinoIcons.chart_pie),
          activeIcon: Icon(CupertinoIcons.chart_pie_fill),
        ),
        BottomNavigationBarItem(
          label: AppMessage.labelSettings,
          icon: Icon(CupertinoIcons.gear),
          activeIcon: Icon(CupertinoIcons.gear_solid),
        ),
      ],
    );
  }
}
