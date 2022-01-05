import 'package:flutter/material.dart';

import '../../../config/app_function.dart';
import '../../../config/app_message.dart';
import '../../../config/app_theme.dart';
import '../../../data/models/categories.dart';
import '../../../data/models/transactions.dart';
import '../../../shared/add_button.dart';
import '../../../shared/dropdown_list.dart';
import '../../../shared/field_text.dart';
import '../controllers/home_controller.dart';
import '../widgets/datetime_picker.dart';

class TransactionForm extends StatefulWidget {
  final HomeController controller;
  final int pageIndex;
  final List<Categories> myList;
  const TransactionForm({Key? key, required this.controller, required this.pageIndex, required this.myList}) : super(key: key);
  @override
  State<TransactionForm> createState() => _TransactionFormState(controller, pageIndex, myList);
}

class _TransactionFormState extends State<TransactionForm> {
  final HomeController controller;
  final int pageIndex;
  final List<Categories> myList;
  _TransactionFormState(this.controller, this.pageIndex, this.myList);

  final TextEditingController amountController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  late String selectedCategory = "";
  late int selectedCategoryId = 0;
  late DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    if (myList.isNotEmpty) {
      selectedCategory = myList.first.title!;
    } else {
      selectedCategory = "Category";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5, bottom: 10, left: 10, right: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Expanded(
                child: FieldText(
                  controller: amountController,
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
                    selectedCategoryId = AppFunction.getCategoryID(selectedCategory, myList);
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
            },
          ),
          FieldText(
            controller: descriptionController,
            hintText: AppMessage.typeMessage,
            index: pageIndex,
            state: false,
            maxLines: 3,
          ),
          AddButton(
            title: AppMessage.labelAdd,
            color: pageIndex == 0 ? AppTheme.incomeColor : AppTheme.expenseColor,
            onPressed: () async {
              try {
                if (myList.isNotEmpty && amountController.text.isNotEmpty) {
                  selectedCategoryId = AppFunction.getCategoryID(selectedCategory, myList);
                  final Transactions transaction = Transactions(
                    amount: double.parse(amountController.text),
                    title: selectedCategory,
                    description: descriptionController.text.trim(),
                    date: selectedDate,
                    state: pageIndex,
                    categoryID: selectedCategoryId,
                  );
                  var data = await controller.addTransaction(transaction);
                  print(data);
                  Navigator.pop(context);
                } else {
                  Navigator.pop(context);
                  AppFunction.snackBar(
                    title: AppMessage.errorTitle,
                    message: AppMessage.errorMessage_1,
                  );
                }
              } catch (e) {
                Navigator.pop(context);
                AppFunction.snackBar(
                  title: AppMessage.errorTitle,
                  message: AppMessage.errorMessage_3,
                );
                throw Exception(AppMessage.errorMessage_3);
              }
            },
          ),
        ],
      ),
    );
  }
}
