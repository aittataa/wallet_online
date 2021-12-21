import 'package:flutter/material.dart';
import 'package:wallet_online/app/config/messages/app_message.dart';
import 'package:wallet_online/app/config/themes/app_theme.dart';
import 'package:wallet_online/app/data/models/categories.dart';
import 'package:wallet_online/app/modules/home/widgets/dropdown_list.dart';
import 'package:wallet_online/app/modules/home/widgets/field_text.dart';

class TransactionForm extends StatefulWidget {
  final List<Categories> myList;
  const TransactionForm({Key? key, required this.myList}) : super(key: key);
  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  late List<Categories> myList;
  late String selectedCategory = "";
  @override
  void initState() {
    super.initState();
    myList = widget.myList;
    selectedCategory = myList.first.title!;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: const EdgeInsets.only(top: 5, bottom: 10, left: 10, right: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Expanded(
                child: FieldText(
                  index: 0,
                  controller: TextEditingController(),
                  state: true,
                  hintText: AppMessage.amount,
                ),
              ),
              const SizedBox(width: 5),
              Expanded(
                child: DropdownList(
                  onChanged: (value) {
                    setState(() => {selectedCategory = value});
                  },
                  hint: AppMessage.labelCategory,
                  value: selectedCategory,
                  myList: List.generate(widget.myList.length, (index) {
                    final Categories category = widget.myList[index];
                    return DropdownMenuItem(
                      value: category.title,
                      child: Text(
                        "${category.title}",
                        style: const TextStyle(
                          color: AppTheme.primaryTextColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ],
          ),
          //DateTimePicker(),
          // FieldText(
          //   controller: descriptionController,
          //   hintText: AppMessage.typeMessage,
          //   maxLines: 3,
          // ),
          // AddButton(
          //   index: index,
          //   title: AppMessage.labelAdd,
          //   color: index == 0 ? AppTheme.incomeColor : AppTheme.expenseColor,
          //   //onPressed: onPressed,
          // ),
        ],
      ),
    );
  }
}
