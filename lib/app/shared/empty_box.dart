import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wallet_online/app/config/app_message.dart';
import 'package:wallet_online/app/config/app_theme.dart';

class EmptyBox extends StatelessWidget {
  const EmptyBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: Image.asset(
            AppMessage.appLogo,
            color: AppTheme.mainColor.withOpacity(.75),
            width: 100,
            height: 100,
          ),
        ),
        SizedBox(height: 10),
        Text(
          AppMessage.noDataFound,
          style: TextStyle(
            color: AppTheme.primaryTextColor.withOpacity(.5),
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
