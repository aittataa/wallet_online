import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wallet_online/app/config/constants/app_constant.dart';
import 'package:wallet_online/app/config/functions/app_function.dart';
import 'package:wallet_online/app/config/messages/app_message.dart';
import 'package:wallet_online/app/data/models/categories.dart';
import 'package:wallet_online/app/modules/statistic/controllers/statistic_controller.dart';
import 'package:wallet_online/app/modules/statistic/widgets/statistic_page.dart';
import 'package:wallet_online/app/shared/bounce_point.dart';
import 'package:wallet_online/app/shared/header_button.dart';

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
                  onPageChanged: (index) {
                    setState(() {
                      AppFunction.animateToPage(index);
                    });
                  },
                  controller: AppConstant.pageController,
                  physics: BouncingScrollPhysics(),
                  children: [
                    StatisticPage(
                      controller: controller,
                      myList: myList.where((category) => category.state == 0 && category.total! > 0).toList()..sort((a, b) => b.total!.compareTo(a.total!)),
                    ),
                    StatisticPage(
                      controller: controller,
                      myList: myList.where((category) => category.state == 1 && category.total! > 0).toList()..sort((a, b) => b.total!.compareTo(a.total!)),
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
