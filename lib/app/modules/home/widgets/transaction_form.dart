import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wallet_online/app/config/app_translation.dart';

import '../../../config/app_function.dart';
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
  const TransactionForm({
    Key? key,
    required this.controller,
    required this.pageIndex,
    required this.myList,
  }) : super(key: key);
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
  late String selectedCategory;
  late int selectedCategoryId;
  late DateTime selectedDate;

  @override
  void initState() {
    super.initState();
    selectedCategory = "";
    selectedCategoryId = 0;
    selectedDate = DateTime.now();
    if (myList.isNotEmpty) {
      selectedCategory = myList.first.title!;
    } else {
      selectedCategory = "Category";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5, left: 5, right: 5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Expanded(
                child: FieldText(
                  controller: amountController,
                  hintText: AppKey.amount.name.tr,
                  index: pageIndex,
                  state: true,
                ),
              ),
              SizedBox(width: 5),
              Expanded(
                child: DropdownList(
                  onChanged: (value) {
                    setState(() => {selectedCategory = value});
                    selectedCategoryId = AppFunction.getCategoryID(selectedCategory, myList);
                  },
                  hint: AppKey.labelCategory.name.tr,
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
          SizedBox(height: 5),
          DateTimePicker(
            onDateTimeChanged: (value) {
              setState(() => {selectedDate = value});
            },
          ),
          SizedBox(height: 5),
          FieldText(
            controller: descriptionController,
            hintText: AppKey.typeMessage.name.tr,
            index: pageIndex,
            maxLines: 3,
          ),
          SizedBox(height: 5),
          AddButton(
            title: AppKey.labelAdd.name.tr,
            color: pageIndex == 0 ? AppTheme.incomeColor : AppTheme.expenseColor,
            onPressed: () async {
              try {
                if (myList.isNotEmpty && amountController.text.isNotEmpty) {
                  selectedCategoryId = AppFunction.getCategoryID(selectedCategory, myList);
                  final DateTime datetime = DateTime(selectedDate.year, selectedDate.month, selectedDate.day, DateTime.now().hour, DateTime.now().minute);
                  final Transactions transaction = Transactions(
                    amount: double.parse(amountController.text),
                    title: selectedCategory,
                    description: descriptionController.text.trim(),
                    date: datetime,
                    state: pageIndex,
                    categoryID: selectedCategoryId,
                  );
                  var data = await controller.addTransaction(transaction);
                  setState(() {
                    print(!(data == null));
                  });
                }
                Navigator.pop(context);
              } catch (e) {
                Navigator.pop(context);
                AppFunction.snackBar(
                  title: AppKey.errorTitle.name.tr,
                  message: AppKey.errorMessage.name.tr,
                );
                throw Exception(AppKey.errorMessage.name.tr);
              }
            },
          ),
        ],
      ),
    );
  }
}
