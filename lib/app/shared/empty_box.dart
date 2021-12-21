import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wallet_online/app/config/themes/app_theme.dart';

class EmptyBox extends StatelessWidget {
  const EmptyBox({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Icon(
        CupertinoIcons.creditcard_fill,
        color: AppTheme.mainColor,
        size: 64,
      ),
    );
  }
}
