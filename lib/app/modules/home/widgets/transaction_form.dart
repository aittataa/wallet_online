import 'package:flutter/material.dart';
import 'package:wallet_online/app/config/messages/app_message.dart';
import 'package:wallet_online/app/config/themes/app_theme.dart';
import 'package:wallet_online/app/data/models/categories.dart';
import 'package:wallet_online/app/modules/home/controllers/home_controller.dart';
import 'package:wallet_online/app/modules/home/widgets/datetime_picker.dart';
import 'package:wallet_online/app/modules/home/widgets/dropdown_list.dart';
import 'package:wallet_online/app/shared/add_button.dart';
import 'package:wallet_online/app/shared/field_text.dart';

class TransactionForm extends StatefulWidget {
  final HomeController controller;
  final int pageIndex;
  final List<Categories> myList;
  const TransactionForm({
    Key? key,
    required this.controller,
    required this.pageIndex,
    required this.myList,
  }) : super(key: key);
  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final TextEditingController amount = TextEditingController();
  final TextEditingController description = TextEditingController();
  late HomeController controller;
  late int pageIndex;
  late List<Categories> myList;
  late String selectedCategory = "";
  late DateTime selectedDate = DateTime.now();
  @override
  void initState() {
    super.initState();
    controller = widget.controller;
    pageIndex = widget.pageIndex;
    myList = widget.myList;
    myList.isNotEmpty ? selectedCategory = myList.first.title! : selectedCategory = "Category";
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 5, bottom: 10, left: 10, right: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Expanded(
                child: FieldText(
                  controller: amount,
                  hintText: AppMessage.amount,
                  index: pageIndex,
                  state: true,
                  maxLines: 1,
                ),
              ),
              SizedBox(width: 5),
              Expanded(
                child: DropdownList(
                  onChanged: (value) {
                    setState(() => {selectedCategory = value});
                    print(selectedCategory);
                  },
                  hint: AppMessage.labelCategory,
                  value: selectedCategory,
                  myList: List.generate(widget.myList.length, (index) {
                    final Categories category = widget.myList[index];
                    return DropdownMenuItem(
                      value: "${category.title}",
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
          DateTimePicker(
            onDateTimeChanged: (value) {
              setState(() => {selectedDate = value});
              print(value);
            },
          ),
          FieldText(
            controller: description,
            hintText: AppMessage.typeMessage,
            index: pageIndex,
            state: false,
            maxLines: 3,
          ),
          AddButton(
            title: AppMessage.labelAdd,
            color: pageIndex == 0 ? AppTheme.incomeColor : AppTheme.expenseColor,
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
