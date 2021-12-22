import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wallet_online/app/config/constants/app_constant.dart';
import 'package:wallet_online/app/config/functions/app_function.dart';
import 'package:wallet_online/app/config/messages/app_message.dart';
import 'package:wallet_online/app/config/themes/app_theme.dart';
import 'package:wallet_online/app/data/models/categories.dart';
import 'package:wallet_online/app/modules/categories/controllers/categories_controller.dart';
import 'package:wallet_online/app/modules/categories/widgets/categories_add.dart';
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
  @override
  void initState() {
    super.initState();
    AppConstant.pageController = PageController(initialPage: AppConstant.pageIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppMessage.labelCategories)),
      floatingActionButton: ActionButton(
        onPressed: () {
          showCupertinoModalPopup(
            barrierColor: AppTheme.secondaryBackColor.withOpacity(.5),
            context: context,
            builder: (context) {
              return CategoriesAdd(
                controller: controller,
                index: AppConstant.pageIndex,
              );
            },
          );
        },
      ),
      body: Obx(() {
        final bool state = controller.state.value;
        if (state) {
          return BouncePoint();
        } else {
          final List<Categories> myList = controller.categories;
          final bool isNotEmpty = myList.isNotEmpty;
          return Column(
            children: [
              Row(
                children: [
                  HeaderButton(
                    title: AppMessage.incomes,
                    icon: CupertinoIcons.square_arrow_down_fill,
                    state: AppConstant.pageIndex == 0,
                    onPressed: () {
                      setState(() {
                        AppFunction.animateToPage(0);
                      });
                    },
                  ),
                  HeaderButton(
                    title: AppMessage.expenses,
                    icon: CupertinoIcons.square_arrow_up_fill,
                    state: AppConstant.pageIndex == 1,
                    onPressed: () {
                      setState(() {
                        AppFunction.animateToPage(1);
                      });
                    },
                  ),
                ],
              ),
              if (isNotEmpty)
                Expanded(
                  child: PageView(
                    onPageChanged: (index) {
                      setState(() {
                        AppFunction.animateToPage(index);
                      });
                    },
                    controller: AppConstant.pageController,
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
                )
              else
                Expanded(child: EmptyBox()),
            ],
          );
        }
      }),
    );
  }
}
