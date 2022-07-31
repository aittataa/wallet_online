import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:wallet_online/app/config/app_translation.dart';

import '../../../config/app_constant.dart';
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
          label: AppKey.labelHome.name.tr,
          icon: Icon(IconlyBroken.home),
          activeIcon: Icon(IconlyBold.home),
        ),
        BottomNavigationBarItem(
          label: AppKey.labelCategories.name.tr,
          icon: Icon(IconlyBroken.category),
          activeIcon: Icon(IconlyBold.category),
        ),
        BottomNavigationBarItem(
          label: AppKey.labelStatistic.name.tr,
          icon: Icon(IconlyBroken.graph),
          activeIcon: Icon(IconlyBold.graph),
        ),
        BottomNavigationBarItem(
          label: AppKey.labelSettings.name.tr,
          icon: Icon(IconlyBroken.setting),
          activeIcon: Icon(IconlyBold.setting),
        ),
      ],
    );
  }
}
