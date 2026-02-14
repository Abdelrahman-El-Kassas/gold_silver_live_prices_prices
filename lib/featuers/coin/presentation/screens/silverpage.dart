import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:silver_gold_price/core/constants/app_colors.dart';
import 'package:silver_gold_price/featuers/coin/data/repo/coinrepo.dart';
import 'package:silver_gold_price/featuers/coin/presentation/cubit/coincubit.dart';
import 'package:silver_gold_price/featuers/coin/presentation/cubit/coinstates.dart';


class SilverPage extends StatelessWidget {
  const SilverPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      // 1. هنا نمرر XAU لجلب الذهب
      create: (context) => CoinCubit(CoinRepo())..fetchCoinPrice("XAG"),
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: const Text(
            "Silver Price",
            style: TextStyle(
              color: AppColors.slivercolor,
              fontSize: 32,
              fontWeight: FontWeight.w700,
            ),
          ),
          centerTitle: true,
        ),
        body: BlocBuilder<CoinCubit, CoinState>(
          builder: (context, state) {
            // 2. التحميل والحالة المبدئية
            if (state is CoinLoading || state is CoinInitial) {
              return const Center(
                child: CircularProgressIndicator(color: AppColors.goldcolor),
              );
            } else if (state is CoinError) {
              return Center(
                child: Text(
                  "Something Wrong: ${state.errorMsg}",
                  style: const TextStyle(color: Colors.white),
                ),
              );
            }
            if (state is CoinSuccess) {
              var model = state.model;

              return SizedBox(
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset("assets/silver.png", height: 300, width: 300),
                    const SizedBox(height: 20),

                    // 4. نستخدم Getters الذهب من الموديل
                    Text(
                      "Silver 999: ${model.gramPrice.toStringAsFixed(2)} USD",
                      style: const TextStyle(
                        color: AppColors.slivercolor,
                        fontSize: 30,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "Silver 925: ${model.silver925.toStringAsFixed(2)} USD",
                      style: const TextStyle(
                        color: AppColors.slivercolor,
                        fontSize: 30,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "Silver 800: ${model.silver800.toStringAsFixed(2)} USD",
                      style: const TextStyle(
                        color: AppColors.slivercolor,
                        fontSize: 30,
                      ),
                    ),
                  ],
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
