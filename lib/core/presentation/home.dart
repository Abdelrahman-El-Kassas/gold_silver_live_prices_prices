import 'package:flutter/material.dart';
import 'package:silver_gold_price/core/constants/app_colors.dart';
import 'package:silver_gold_price/core/constants/app_strings.dart';
import 'package:silver_gold_price/core/routing/routes.dart';
import 'package:silver_gold_price/core/widgets/custombutton.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Gold & Silver Price",
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 26),
        ),
        centerTitle: true,
        backgroundColor: Color.fromARGB(141, 17, 115, 206),
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomButton(
            text: '${AppStrings.gold} Price',
            onPressed: () {
              Navigator.pushNamed(context, AppRoutes.goldScreen);
            },
            color: AppColors.goldcolor,
          ),

          CustomButton(
            text: '${AppStrings.silver} Price',
            onPressed: () {
              Navigator.pushNamed(
                context,AppRoutes.silverScreen
             
              );
            },
            color: AppColors.slivercolor,
          ),
        ],
      ),
    );
  }
}
