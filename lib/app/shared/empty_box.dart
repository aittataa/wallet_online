import 'package:flutter/cupertino.dart';

import '../config/app_theme.dart';

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
