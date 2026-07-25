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
        appBar: AppBar(
          iconTheme: const IconThemeData(color: AppColors.goldcolor),
          title: const Text(
            "Gold Price",
            style: TextStyle(
              color: AppColors.goldcolor,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        body: BlocBuilder<CoinCubit, CoinState>(
          builder: (context, state) {
            if (state is CoinLoading || state is CoinInitial) {
              return const Center(
                child: CircularProgressIndicator(color: AppColors.goldcolor),
              );
            } else if (state is CoinError) {
              return _buildErrorState(context, state.errorMsg);
            } else if (state is CoinSuccess) {
              final model = state.model;
              return SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                child: Column(
                  children: [
                    // Gold image with glow
                    Container(
                      width: 180,
                      height: 180,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.goldcolor.withValues(alpha: 0.2),
                            blurRadius: 40,
                            spreadRadius: 8,
                          ),
                        ],
                      ),
                      child: ClipOval(
                        child: Image.asset("assets/gold.png", fit: BoxFit.cover),
                      ),
                    ),
                    const SizedBox(height: 32),

                    // Price cards
                    _buildPriceCard(
                      karat: "24K",
                      label: "Pure Gold",
                      price: model.gramPrice,
                      isHighlighted: true,
                    ),
                    const SizedBox(height: 14),
                    _buildPriceCard(
                      karat: "21K",
                      label: "Standard Jewelry",
                      price: model.gold21,
                    ),
                    const SizedBox(height: 14),
                    _buildPriceCard(
                      karat: "18K",
                      label: "Alloy Jewelry",
                      price: model.gold18,
                    ),

                    const SizedBox(height: 28),

                    // Info footer
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppColors.cardDark.withValues(alpha: 0.5),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.info_outline_rounded,
                              color: AppColors.textSecondary, size: 18),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              "Prices are per gram in USD, based on live troy ounce rates",
                              style: TextStyle(
                                color: AppColors.textSecondary,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ],
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

  Widget _buildPriceCard({
    required String karat,
    required String label,
    required double price,
    bool isHighlighted = false,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: isHighlighted
              ? [const Color(0xFF2D1F00), const Color(0xFF1A1200)]
              : [AppColors.cardDark, AppColors.cardDarkAlt],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isHighlighted
              ? AppColors.goldDark.withValues(alpha: 0.5)
              : Colors.white.withValues(alpha: 0.05),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          // Karat badge
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: AppColors.goldcolor.withValues(alpha: isHighlighted ? 0.15 : 0.08),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Center(
              child: Text(
                karat,
                style: TextStyle(
                  color: AppColors.goldcolor,
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),

          // Label
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Gold $karat",
                  style: const TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  label,
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),

          // Price
          Text(
            "\$${price.toStringAsFixed(2)}",
            style: TextStyle(
              color: AppColors.goldcolor,
              fontSize: 22,
              fontWeight: FontWeight.w700,
              letterSpacing: -0.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(BuildContext context, String errorMsg) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.cloud_off_rounded, color: AppColors.goldDark, size: 64),
            const SizedBox(height: 16),
            const Text(
              "Something went wrong",
              style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              errorMsg,
              textAlign: TextAlign.center,
              style: TextStyle(color: AppColors.textSecondary, fontSize: 14),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () {
                context.read<CoinCubit>().fetchCoinPrice("XAU");
              },
              icon: const Icon(Icons.refresh_rounded),
              label: const Text("Retry"),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.goldDark,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}