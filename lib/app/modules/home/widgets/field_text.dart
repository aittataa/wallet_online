import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wallet_online/app/config/themes/app_theme.dart';

class FieldText extends StatelessWidget {
  final int? index;
  final bool state;
  final String? hintText;
  final int? maxLines;
  final TextEditingController? controller;
  const FieldText({
    Key? key,
    this.index,
    this.state = false,
    this.hintText,
    this.maxLines = 1,
    this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: state ? TextInputType.number : TextInputType.text,
      textInputAction: TextInputAction.done,
      cursorColor: AppTheme.primaryIconColor,
      style: TextStyle(
        color: AppTheme.primaryTextColor.withOpacity(.75),
        fontWeight: FontWeight.w900,
      ),
      maxLines: maxLines,
      decoration: InputDecoration(
        icon: state
            ? Icon(
                index == 0 ? CupertinoIcons.plus : CupertinoIcons.minus,
                color: index == 0 ? AppTheme.incomeColor : AppTheme.expenseColor,
              )
            : null,
        suffixText: state ? "MAD" : null,
        contentPadding: const EdgeInsets.all(10),
        hintText: hintText,
        hintStyle: TextStyle(
          color: AppTheme.primaryTextColor.withOpacity(.5),
          fontWeight: FontWeight.bold,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            width: 1,
            color: state
                ? index == 0
                    ? AppTheme.incomeColor
                    : AppTheme.expenseColor
                : AppTheme.mainColor,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            width: 2.5,
            color: state
                ? index == 0
                    ? AppTheme.incomeColor
                    : AppTheme.expenseColor
                : AppTheme.mainColor,
          ),
        ),
      ),
    );
  }
}
