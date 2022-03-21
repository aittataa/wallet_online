import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app_theme.dart';

enum Currencies { mad, usd, eur }
enum Languages { English, Arabic, French }

const Map<Currencies, String> currencies = {
  // Currencies.mad: "DH",
  Currencies.usd: r"$",
  Currencies.eur: "€",
};

class AppConstant {
  AppConstant._();

  /// TODO : Screen Controller
  static String appCurrency = Currencies.mad.name;

  /// TODO : Screen Controller
  static PageController pageController = PageController();
  static int pageIndex = 0;

  /// TODO : Screen Size
  static double screenWidth = Get.width;
  static double screenHeight = Get.height;

  static const double elevation = 1;

  /// TODO : Curves
  static const Curve curve = Curves.linearToEaseOut;

  /// TODO : Transitions
  static const Transition transitionRoute = Transition.fadeIn;

  /// TODO : Durations
  static const Duration duration = Duration(milliseconds: 1500);
  static const Duration durationPage = Duration(milliseconds: 500);
  static const Duration durationSwap = Duration(milliseconds: 1000);
  static const Duration durationSplash = Duration(milliseconds: 1500);
  static const Duration durationSnack = Duration(milliseconds: 1500);

  /// TODO : BoxShadow
  static BoxShadow boxShadow = BoxShadow(
    color: AppTheme.shadowColor.withOpacity(.1),
    blurRadius: 10,
    spreadRadius: .1,
  );
}

// enum CharacterSpecies { human, alien, empty }
// enum CharacterStatus { alive, unknown, dead, empty }
// enum CharacterGender { male, female, unknown, empty }
//
// const characterSpeciesValues = {
//   CharacterSpecies.alien: "Alien",
//   CharacterSpecies.human: "Human",
//   CharacterSpecies.empty: "",
// };
//
// const characterStatusValues = {
//   CharacterStatus.alive: "Alive",
//   CharacterStatus.dead: "Dead",
//   CharacterStatus.empty: "",
// };
//
// const characterGenderValues = {
//   CharacterGender.male: "Male",
//   CharacterGender.female: "Female",
//   CharacterGender.unknown: "unknown",
//   CharacterGender.empty: "",
// };
