import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:wallet_online/app/config/constants/app_constant.dart';
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
  late PageController _pageController = PageController();
  late int _pageIndex;
  late bool isConnected = false;

  get checkConnection async {
    final bool result = await DataConnectionChecker().hasConnection;
    isConnected = result;
    AppConstant.bannerAd.load();
  }

  @override
  void initState() {
    super.initState();
    _pageIndex = 0;
    _pageController = PageController(initialPage: _pageIndex);
    checkConnection;
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
          if (isConnected)
            SizedBox(
              height: 50,
              width: 300,
              child: AdWidget(ad: AppConstant.bannerAd),
            ),
        ],
      ),
      bottomNavigationBar: FooterBar(
        currentIndex: _pageIndex,
        onTap: (index) async {
          setState(() {
            _pageIndex = index;
            _pageController.jumpToPage(_pageIndex);
            checkConnection;
          });
        },
      ),
    );
  }
}
