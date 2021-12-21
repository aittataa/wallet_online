import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wallet_online/app/config/constants/app_constant.dart';
import 'package:wallet_online/app/config/messages/app_message.dart';
import 'package:wallet_online/app/data/models/categories.dart';
import 'package:wallet_online/app/modules/statistic/controllers/statistic_controller.dart';
import 'package:wallet_online/app/modules/statistic/widgets/statistic_page.dart';
import 'package:wallet_online/app/shared/bounce_point.dart';
import 'package:wallet_online/app/shared/empty_box.dart';
import 'package:wallet_online/app/shared/header_button.dart';

class StatisticView extends StatefulWidget {
  @override
  State<StatisticView> createState() => _StatisticViewState();
}

class _StatisticViewState extends State<StatisticView> {
  final StatisticController controller = Get.put(StatisticController());
  late PageController pageController = PageController();
  late int pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppMessage.labelStatistic)),
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
                      StatisticPage(
                        controller: controller,
                        myList: myList.where((category) => category.state == 0).toList()..sort((a, b) => b.total!.compareTo(a.total!)),
                      ),
                      StatisticPage(
                        controller: controller,
                        myList: myList.where((category) => category.state == 1).toList()..sort((a, b) => b.total!.compareTo(a.total!)),
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
