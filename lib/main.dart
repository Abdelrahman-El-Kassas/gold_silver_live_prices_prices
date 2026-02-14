import 'package:flutter/material.dart';
import 'package:silver_gold_price/core/networking/dio.helper.dart';

import 'package:silver_gold_price/core/routing/app_router.dart';

import 'package:silver_gold_price/core/routing/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DioHelper.init();

  runApp(const MyApp());
}

// Future<void> main() async {
//   await dotenv.load(fileName: ".env");
//   runApp(const MyApp());
// }

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.homeScreen,
      onGenerateRoute: AppRouter().generateRoute,
    );
  }
}
