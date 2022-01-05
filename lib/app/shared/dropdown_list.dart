import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../config/app_theme.dart';

class DropdownList extends StatelessWidget {
  final List<DropdownMenuItem> myList;
  final dynamic value;
  final String hint;
  final Function(dynamic)? onChanged;
  const DropdownList({
    Key? key,
    required this.myList,
    required this.value,
    required this.hint,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppTheme.mainColor),
      ),
      child: DropdownButton(
        onChanged: onChanged,
        onTap: () => FocusScope.of(context).unfocus(),
        icon: const Icon(CupertinoIcons.chevron_down),
        iconEnabledColor: AppTheme.mainColor,
        isExpanded: true,
        dropdownColor: AppTheme.backgroundColor,
        items: myList,
        value: value,
        underline: const SizedBox(),
        hint: Text(
          "$hint",
          style: const TextStyle(
            color: AppTheme.primaryIconColor,
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
    );
  }
}
