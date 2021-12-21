import 'package:flutter/cupertino.dart';
import 'package:wallet_online/app/config/themes/app_theme.dart';

class DateTimePicker extends StatelessWidget {
  final Function(DateTime)? onDateTimeChanged;
  const DateTimePicker({Key? key, this.onDateTimeChanged}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 75,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppTheme.mainColor),
      ),
      child: CupertinoDatePicker(
        onDateTimeChanged: (value) {},
        initialDateTime: DateTime.now(),
        mode: CupertinoDatePickerMode.date,
        minimumYear: DateTime.now().year - 5,
        maximumYear: DateTime.now().year + 5,
      ),
    );
  }
}
