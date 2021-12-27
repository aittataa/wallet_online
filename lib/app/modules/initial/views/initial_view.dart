import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:wallet_online/app/config/messages/app_message.dart';
import 'package:wallet_online/app/modules/categories/views/categories_view.dart';
import 'package:wallet_online/app/modules/home/views/home_view.dart';
import 'package:wallet_online/app/modules/initial/widgets/navigation_bar.dart';
import 'package:wallet_online/app/modules/settings/views/settings_view.dart';
import 'package:wallet_online/app/modules/statistic/views/statistic_view.dart';

class InitialView extends StatefulWidget {
  const InitialView({Key? key}) : super(key: key);
  @override
  State<InitialView> createState() => _InitialViewState();
}

class _InitialViewState extends State<InitialView> {
  late PageController pageController = PageController();
  late int pageIndex;

  final BannerAd bannerAd = BannerAd(
    adUnitId: AppMessage.bannerAds,
    size: AdSize.banner,
    request: AdRequest(),
    listener: BannerAdListener(),
  );

  @override
  void initState() {
    super.initState();
    pageIndex = 0;
    pageController = PageController(initialPage: pageIndex);
    bannerAd.load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView(
              controller: pageController,
              physics: NeverScrollableScrollPhysics(),
              children: [
                HomeView(),
                CategoriesView(),
                StatisticView(),
                SettingsView(),
              ],
            ),
          ),
          SizedBox(
            child: AdWidget(ad: bannerAd),
          )
        ],
      ),
      bottomNavigationBar: FooterBar(
        currentIndex: pageIndex,
        onTap: (index) async {
          setState(() {
            pageIndex = index;
            pageController.jumpToPage(pageIndex);
          });
        },
      ),
    );
  }
}
