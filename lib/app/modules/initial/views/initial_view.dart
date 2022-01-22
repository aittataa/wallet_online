import 'package:flutter/material.dart';

import '../../../modules/categories/views/categories_view.dart';
import '../../../modules/home/views/home_view.dart';
import '../../../modules/settings/views/settings_view.dart';
import '../../../modules/statistic/views/statistic_view.dart';
import '../widgets/navigation_bar.dart';

class InitialView extends StatefulWidget {
  const InitialView({Key? key}) : super(key: key);
  @override
  State<InitialView> createState() => _InitialViewState();
}

class _InitialViewState extends State<InitialView> {
  late PageController _pageController = PageController();
  late int _pageIndex;

  @override
  void initState() {
    super.initState();
    _pageIndex = 1;
    _pageController = PageController(initialPage: _pageIndex);
  }

  @override
  Widget build(BuildContext context) {
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
      bottomNavigationBar: FooterBar(
        currentIndex: _pageIndex,
        onTap: (index) async {
          setState(() {
            _pageIndex = index;
            _pageController.jumpToPage(_pageIndex);
          });
        },
      ),
    );
  }
}
