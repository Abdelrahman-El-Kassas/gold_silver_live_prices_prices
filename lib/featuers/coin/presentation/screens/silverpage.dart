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
      create: (context) => CoinCubit(CoinRepo())..fetchCoinPrice("XAG"),
      child: Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: AppColors.slivercolor),
          title: const Text(
            "Silver Price",
            style: TextStyle(
              color: AppColors.slivercolor,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        body: BlocBuilder<CoinCubit, CoinState>(
          builder: (context, state) {
            if (state is CoinLoading || state is CoinInitial) {
              return const Center(
                child: CircularProgressIndicator(color: AppColors.slivercolor),
              );
            } else if (state is CoinError) {
              return _buildErrorState(context, state.errorMsg);
            }
            if (state is CoinSuccess) {
              final model = state.model;
              return SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                child: Column(
                  children: [
                    // Silver image with glow
                    Container(
                      width: 180,
                      height: 180,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.slivercolor.withValues(alpha: 0.15),
                            blurRadius: 40,
                            spreadRadius: 8,
                          ),
                        ],
                      ),
                      child: ClipOval(
                        child: Image.asset("assets/silver.png", fit: BoxFit.cover),
                      ),
                    ),
                    const SizedBox(height: 32),

                    // Price cards
                    _buildPriceCard(
                      purity: "999",
                      label: "Fine Silver",
                      price: model.gramPrice,
                      isHighlighted: true,
                    ),
                    const SizedBox(height: 14),
                    _buildPriceCard(
                      purity: "925",
                      label: "Sterling Silver",
                      price: model.silver925,
                    ),
                    const SizedBox(height: 14),
                    _buildPriceCard(
                      purity: "800",
                      label: "Coin Silver",
                      price: model.silver800,
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
    required String purity,
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
              ? [const Color(0xFF1A1A2E), const Color(0xFF0F0F1A)]
              : [AppColors.cardDark, AppColors.cardDarkAlt],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isHighlighted
              ? AppColors.slivercolor.withValues(alpha: 0.3)
              : Colors.white.withValues(alpha: 0.05),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          // Purity badge
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: AppColors.slivercolor.withValues(alpha: isHighlighted ? 0.15 : 0.08),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Center(
              child: Text(
                purity,
                style: TextStyle(
                  color: AppColors.slivercolor,
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
                  "Silver $purity",
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
              color: AppColors.slivercolor,
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
            Icon(Icons.cloud_off_rounded, color: AppColors.silverDark, size: 64),
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
                context.read<CoinCubit>().fetchCoinPrice("XAG");
              },
              icon: const Icon(Icons.refresh_rounded),
              label: const Text("Retry"),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.silverDark,
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
