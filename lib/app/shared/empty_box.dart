import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wallet_online/app/config/app_theme.dart';
import 'package:wallet_online/app/config/app_translation.dart';

class EmptyBox extends StatelessWidget {
  const EmptyBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        AppKey.noDataFound.name.tr,
        style: TextStyle(
          color: AppTheme.primaryTextColor.withOpacity(.5),
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
