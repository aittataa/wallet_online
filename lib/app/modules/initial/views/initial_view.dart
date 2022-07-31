import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wallet_online/app/modules/initial/controllers/initial_controller.dart';

import '../../../modules/categories/views/categories_view.dart';
import '../../../modules/home/views/home_view.dart';
import '../../../modules/settings/views/settings_view.dart';
import '../../../modules/statistic/views/statistic_view.dart';
import '../widgets/footer_bar.dart';

class InitialView extends StatefulWidget {
  const InitialView({Key? key}) : super(key: key);

  @override
  State<InitialView> createState() => _InitialViewState();
}

class _InitialViewState extends State<InitialView> {
  final InitialController controller = Get.put(InitialController());
  late PageController _pageController = PageController();
  late int _pageIndex;
  late bool visible = true;

  @override
  void initState() {
    super.initState();
    _pageIndex = 0;
    _pageController = PageController(initialPage: _pageIndex);
  }

  @override
  Widget build(BuildContext context) {
    visible = MediaQuery.of(context).viewInsets.bottom == 0;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: PageView(
        controller: _pageController,
        physics: NeverScrollableScrollPhysics(),
        children: [
          HomeView(),
          CategoriesView(),
          StatisticView(),
          SettingsView(),
        ],
      ),
      bottomNavigationBar: Visibility(
        visible: visible,
        child: FooterBar(
          currentIndex: _pageIndex,
          onTap: (index) async {
            setState(() {
              _pageIndex = index;
              _pageController.jumpToPage(_pageIndex);
            });
          },
        ),
      ),
    );
  }
}
