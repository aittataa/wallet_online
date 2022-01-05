import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../../../config/app_ads.dart';
import '../../../config/app_constant.dart';
import '../../../config/app_network.dart';
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

  late var hasConnection = false;
  get checkConnection async {
    hasConnection = await Network.hasConnection;
  }

  final BannerAd bannerAd = BannerAd(
    adUnitId: AdUnits.bannerAd,
    size: AdSize.banner,
    request: AdRequest(),
    listener: BannerAdListener(),
  );

  @override
  void initState() {
    super.initState();
    checkConnection;
    bannerAd.load();
    _pageIndex = 0;
    _pageController = PageController(initialPage: _pageIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          Expanded(
            child: PageView(
              controller: _pageController,
              physics: NeverScrollableScrollPhysics(),
              children: [
                HomeView(),
                CategoriesView(),
                StatisticView(),
                SettingsView(),
              ],
            ),
          ),
          if (hasConnection)
            AnimatedContainer(
              duration: AppConstant.durationAnimated,
              curve: AppConstant.curve,
              width: 300,
              height: 50,
              child: AdWidget(ad: bannerAd),
            ),
        ],
      ),
      bottomNavigationBar: FooterBar(
        currentIndex: _pageIndex,
        onTap: (index) async {
          checkConnection;
          setState(() {
            _pageIndex = index;
            _pageController.jumpToPage(_pageIndex);
          });
        },
      ),
    );
  }
}
