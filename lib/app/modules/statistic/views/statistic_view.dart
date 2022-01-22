import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../config/app_constant.dart';
import '../../../config/app_function.dart';
import '../../../config/app_message.dart';
import '../../../data/models/categories.dart';
import '../../../shared/bounce_point.dart';
import '../../../shared/header_button.dart';
import '../controllers/statistic_controller.dart';
import '../widgets/statistic_page.dart';

class StatisticView extends StatefulWidget {
  const StatisticView({Key? key}) : super(key: key);
  @override
  State<StatisticView> createState() => _StatisticViewState();
}

class _StatisticViewState extends State<StatisticView> {
  final StatisticController controller = Get.put(StatisticController());
  @override
  void initState() {
    super.initState();
    AppConstant.pageController = PageController(initialPage: AppConstant.pageIndex);
  }

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
              Expanded(
                child: PageView(
                  // onPageChanged: (index) {
                  //   setState(() => {AppFunction.animateToPage(index)});
                  // },
                  controller: AppConstant.pageController,
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                    StatisticPage(
                      controller: controller,
                      myList: AppFunction.filterList(myList, 0),
                    ),
                    StatisticPage(
                      controller: controller,
                      myList: AppFunction.filterList(myList, 1),
                    ),
                  ],
                ),
              ),
            ],
          );
        }
      }),
    );
  }

  @override
  void dispose() {
    super.dispose();
    Get.delete<StatisticController>();
  }
}
