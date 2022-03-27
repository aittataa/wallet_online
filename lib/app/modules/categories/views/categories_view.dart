import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../config/app_constant.dart';
import '../../../config/app_function.dart';
import '../../../config/app_message.dart';
import '../../../data/models/categories.dart';
import '../../../shared/bounce_point.dart';
import '../../../shared/floating_button.dart';
import '../../../shared/header_button.dart';
import '../controllers/categories_controller.dart';
import '../widgets/categories_add.dart';
import '../widgets/categories_page.dart';

class CategoriesView extends StatefulWidget {
  const CategoriesView({Key? key}) : super(key: key);
  @override
  State<CategoriesView> createState() => _CategoriesViewState();
}

class _CategoriesViewState extends State<CategoriesView> {
  final CategoriesController controller = Get.put(CategoriesController());
  late bool visible = true;

  @override
  void initState() {
    super.initState();
    AppConstant.pageController = PageController(initialPage: AppConstant.pageIndex);
  }

  @override
  Widget build(BuildContext context) {
    visible = MediaQuery.of(context).viewInsets.bottom == 0;
    return Scaffold(
      appBar: AppBar(title: Text(AppMessage.labelCategories)),
      floatingActionButton: FloatingButton(
        visible: visible,
        onPressed: () => AppFunction.lunchNew(
          context,
          builder: CategoriesAdd(
            controller: controller,
            index: AppConstant.pageIndex,
            status: false,
            category: Categories(),
          ),
        ),
      ),
      body: FutureBuilder<List<Categories>>(
        future: controller.loadCategories,
        builder: (_, snapshot) {
          if (snapshot.hasData) {
            final List<Categories> myList = snapshot.data!;
            return Column(
              children: [
                Row(
                  children: [
                    HeaderButton(
                      title: AppMessage.incomes,
                      icon: CupertinoIcons.square_arrow_down_fill,
                      state: AppConstant.pageIndex == 0,
                      onPressed: () {
                        setState(() => {AppFunction.animateToPage(0)});
                      },
                    ),
                    HeaderButton(
                      title: AppMessage.expenses,
                      icon: CupertinoIcons.square_arrow_up_fill,
                      state: AppConstant.pageIndex == 1,
                      onPressed: () {
                        setState(() => {AppFunction.animateToPage(1)});
                      },
                    ),
                  ],
                ),
                Expanded(
                  child: PageView(
                    onPageChanged: (index) {
                      setState(() => {AppFunction.animateToPage(index)});
                    },
                    controller: AppConstant.pageController,
                    physics: BouncingScrollPhysics(),
                    children: [
                      CategoriesPage(
                        controller: controller,
                        myList: AppFunction.filterCategories(myList, 0),
                      ),
                      CategoriesPage(
                        controller: controller,
                        myList: AppFunction.filterCategories(myList, 1),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }
          return const BouncePoint();
        },
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    Get.delete<CategoriesController>();
  }
}
