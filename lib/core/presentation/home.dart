import 'package:flutter/material.dart';
import 'package:silver_gold_price/core/constants/app_colors.dart';
import 'package:silver_gold_price/core/routing/routes.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),

              // Header
              const Text(
                "Gold & Silver",
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.w800,
                  color: AppColors.textPrimary,
                  letterSpacing: -0.5,
                ),
              ),
              const Text(
                "Live Prices",
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.w800,
                  color: AppColors.goldcolor,
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "Track real-time precious metal prices per gram",
                style: TextStyle(
                  fontSize: 15,
                  color: AppColors.textSecondary,
                  fontWeight: FontWeight.w400,
                ),
              ),

              const SizedBox(height: 40),

              // Gold Card
              _buildMetalCard(
                context: context,
                title: "Gold",
                subtitle: "24K · 21K · 18K",
                icon: "assets/gold.png",
                gradientColors: [
                  const Color(0xFF2D1F00),
                  const Color(0xFF1A1200),
                ],
                accentColor: AppColors.goldcolor,
                borderColor: AppColors.goldDark.withValues(alpha: 0.4),
                route: AppRoutes.goldScreen,
              ),

              const SizedBox(height: 20),

              // Silver Card
              _buildMetalCard(
                context: context,
                title: "Silver",
                subtitle: "999 · 925 · 800",
                icon: "assets/silver.png",
                gradientColors: [
                  const Color(0xFF1A1A2E),
                  const Color(0xFF13131F),
                ],
                accentColor: AppColors.slivercolor,
                borderColor: AppColors.silverDark.withValues(alpha: 0.4),
                route: AppRoutes.silverScreen,
              ),

              const Spacer(),

              // Footer
              Center(
                child: Text(
                  "Powered by Gold-API",
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.textSecondary.withValues(alpha: 0.5),
                  ),
                ),
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMetalCard({
    required BuildContext context,
    required String title,
    required String subtitle,
    required String icon,
    required List<Color> gradientColors,
    required Color accentColor,
    required Color borderColor,
    required String route,
  }) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, route),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: gradientColors,
          ),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: borderColor, width: 1),
          boxShadow: [
            BoxShadow(
              color: accentColor.withValues(alpha: 0.08),
              blurRadius: 24,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Row(
          children: [
            // Icon
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: accentColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(icon, fit: BoxFit.cover),
              ),
            ),
            const SizedBox(width: 20),

            // Text
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w700,
                      color: accentColor,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.textSecondary,
                      fontWeight: FontWeight.w400,
                      letterSpacing: 1.5,
                    ),
                  ),
                ],
              ),
            ),

            // Arrow
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: accentColor.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(
                Icons.arrow_forward_rounded,
                color: accentColor,
                size: 22,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
