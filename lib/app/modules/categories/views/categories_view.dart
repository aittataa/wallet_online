import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wallet_online/app/config/constants/app_constant.dart';
import 'package:wallet_online/app/config/messages/app_message.dart';
import 'package:wallet_online/app/data/models/categories.dart';
import 'package:wallet_online/app/modules/categories/controllers/categories_controller.dart';
import 'package:wallet_online/app/modules/categories/widgets/categories_page.dart';
import 'package:wallet_online/app/shared/action_button.dart';
import 'package:wallet_online/app/shared/bounce_point.dart';
import 'package:wallet_online/app/shared/empty_box.dart';
import 'package:wallet_online/app/shared/header_button.dart';

class CategoriesView extends StatefulWidget {
  @override
  State<CategoriesView> createState() => _CategoriesViewState();
}

class _CategoriesViewState extends State<CategoriesView> {
  final CategoriesController controller = Get.put(CategoriesController());
  late PageController pageController = PageController();
  late int pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppMessage.labelCategories)),
      floatingActionButton: ActionButton(),
      body: Obx(() {
        final bool state = controller.state.value;
        if (state) {
          return BouncePoint();
        } else {
          final List<Categories> myList = controller.categories;
          final bool isEmpty = myList.isEmpty;
          if (isEmpty) {
            return EmptyBox();
          } else {
            return Column(
              children: [
                Row(
                  children: [
                    HeaderButton(
                      title: AppMessage.incomes,
                      icon: CupertinoIcons.square_arrow_down_fill,
                      state: pageIndex == 0,
                      onPressed: () {
                        setState(() {
                          pageIndex = 0;
                          pageController.animateToPage(
                            pageIndex,
                            duration: AppConstant.durationPage,
                            curve: AppConstant.curve,
                          );
                        });
                      },
                    ),
                    HeaderButton(
                      title: AppMessage.expenses,
                      icon: CupertinoIcons.square_arrow_up_fill,
                      state: pageIndex == 1,
                      onPressed: () {
                        setState(() {
                          pageIndex = 1;
                          pageController.animateToPage(
                            pageIndex,
                            duration: AppConstant.durationPage,
                            curve: AppConstant.curve,
                          );
                        });
                      },
                    ),
                  ],
                ),
                Expanded(
                  child: PageView(
                    onPageChanged: (index) {
                      setState(() {
                        pageIndex = index;
                        pageController.animateToPage(
                          pageIndex,
                          duration: AppConstant.durationPage,
                          curve: AppConstant.curve,
                        );
                      });
                    },
                    controller: pageController,
                    physics: BouncingScrollPhysics(),
                    children: [
                      CategoriesPage(
                        controller: controller,
                        myList: myList.where((category) => category.state == 0).toList()..sort((a, b) => b.id!.compareTo(a.id!)),
                      ),
                      CategoriesPage(
                        controller: controller,
                        myList: myList.where((category) => category.state == 1).toList()..sort((a, b) => b.id!.compareTo(a.id!)),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }
        }
      }),
    );
  }
}
