import 'package:flutter/material.dart';
import 'package:wallet_online/app/modules/categories/views/categories_view.dart';
import 'package:wallet_online/app/modules/home/views/home_view.dart';
import 'package:wallet_online/app/modules/initial/widgets/navigation_bar.dart';
import 'package:wallet_online/app/modules/settings/views/settings_view.dart';
import 'package:wallet_online/app/modules/statistic/views/statistic_view.dart';

class InitialView extends StatefulWidget {
  @override
  State<InitialView> createState() => _InitialViewState();
}

class _InitialViewState extends State<InitialView> {
  late PageController controller = PageController();
  late int pageIndex = 0;

  @override
  void initState() {
    super.initState();
    controller = PageController(initialPage: pageIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: controller,
        physics: NeverScrollableScrollPhysics(),
        children: [
          HomeView(),
          CategoriesView(),
          StatisticView(),
          SettingsView(),
        ],
      ),
      bottomNavigationBar: FooterBar(
        currentIndex: pageIndex,
        onTap: (index) {
          setState(() {
            pageIndex = index;
            controller.jumpToPage(pageIndex);
          });
        },
      ),
    );
  }
}
