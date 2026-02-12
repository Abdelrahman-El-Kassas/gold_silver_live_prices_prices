import 'package:flutter/material.dart';
import 'package:silver_gold_price/core/presentation/home.dart';
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

      default:
        return MaterialPageRoute(
          builder: (context) {
            return Home();
          },
        );
    }
  }
}
