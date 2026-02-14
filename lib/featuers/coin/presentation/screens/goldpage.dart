import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:silver_gold_price/core/constants/app_colors.dart';
import 'package:silver_gold_price/featuers/coin/data/repo/coinrepo.dart';
import 'package:silver_gold_price/featuers/coin/presentation/cubit/coincubit.dart';
import 'package:silver_gold_price/featuers/coin/presentation/cubit/coinstates.dart';



class GoldPage extends StatelessWidget {
  const GoldPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      
      create: (context) => CoinCubit(CoinRepo())..fetchCoinPrice("XAU"),
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: const Text(
            "Gold Price",
            style: TextStyle(
              color: AppColors.goldcolor,
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
            } else if (state is CoinSuccess) {
              // 3. نستلم الموديل العام
              final model = state.model;
              
              return SizedBox(
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset("assets/gold.png", height: 300,width: 300,),
                    const SizedBox(height: 20),
                    
                   
                    Text(
                      "Gold 24: ${model.gramPrice.toStringAsFixed(2)} USD",
                      style: const TextStyle(color: Colors.amberAccent, fontSize: 30),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "Gold 21: ${model.gold21.toStringAsFixed(2)} USD",
                      style: const TextStyle(color: Colors.amberAccent, fontSize: 30),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "Gold 18: ${model.gold18.toStringAsFixed(2)} USD",
                      style: const TextStyle(color: Colors.amberAccent, fontSize: 30),
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