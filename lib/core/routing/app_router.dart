import 'package:flutter/material.dart';
import 'package:silver_gold_price/core/presentation/home.dart';
import 'package:silver_gold_price/featuers/coin/presentation/screens/goldpage.dart';
import 'package:silver_gold_price/featuers/coin/presentation/screens/silverpage.dart';

import 'routes.dart';

class AppRouter {
  Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.homeScreen:
        return MaterialPageRoute(
          builder: (context) {
            return Home();
          },
        );
      case AppRoutes.goldScreen:
        return MaterialPageRoute(
          builder: (context) {
            return GoldPage();
          },
        );

      case AppRoutes.silverScreen:
        return MaterialPageRoute(
          builder: (context) {
            return SilverPage();
          },
        );

      default:
        return MaterialPageRoute(
          builder: (context) {
            return Home();
          },
        );
    }
  }
}
