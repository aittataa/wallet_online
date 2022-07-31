import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:iconly/iconly.dart';

import '../config/app_constant.dart';
import '../config/app_theme.dart';

class FloatingButton extends StatelessWidget {
  final bool visible;
  final Function() onPressed;

  const FloatingButton({
    Key? key,
    this.visible = true,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SpeedDial(
      onPress: onPressed,
      visible: visible,
      backgroundColor: AppTheme.mainColor,
      elevation: 1,
      curve: AppConstant.curve,
      child: Icon(
        IconlyLight.plus,
        color: AppTheme.secondaryIconColor,
      ),
    );
  }
}
