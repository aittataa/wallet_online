import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wallet_online/app/config/app_translation.dart';

import '../../../config/app_constant.dart';
import '../../../config/app_function.dart';
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
      appBar: AppBar(title: Text(AppKey.labelStatistic.name.tr)),
      body: FutureBuilder<List<Categories>>(
        future: controller.loadStatistics,
        builder: (_, snapshot) {
          if (snapshot.hasData) {
            // final Settings appSettings = controller.settings.value;
            // AppConstant.currency = appSettings.currency!;
            // AppConstant.appCurrency = AppEnum.currencies[appSettings.currency]!;
            final List<Categories> myList = snapshot.data!;
            return Column(
              children: [
                Row(
                  children: [
                    HeaderButton(
                      title: AppKey.incomes.name.tr,
                      icon: CupertinoIcons.square_arrow_down_fill,
                      state: AppConstant.pageIndex == 0,
                      onPressed: () {
                        setState(() {
                          AppFunction.animateToPage(0);
                        });
                      },
                    ),
                    HeaderButton(
                      title: AppKey.expenses.name.tr,
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
                      setState(() => {AppFunction.animateToPage(index)});
                    },
                    controller: AppConstant.pageController,
                    physics: BouncingScrollPhysics(),
                    children: [
                      StatisticPage(
                        controller: controller,
                        myList: AppFunction.filterStatistics(myList, 0),
                      ),
                      StatisticPage(
                        controller: controller,
                        myList: AppFunction.filterStatistics(myList, 1),
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
    Get.delete<StatisticController>();
  }
}
