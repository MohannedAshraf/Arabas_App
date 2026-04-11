import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class ProfileStatCard extends StatelessWidget {
  final String number;
  final String title;

  const ProfileStatCard({super.key, required this.number, required this.title});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(color: Colors.grey.withOpacity(0.1), blurRadius: 10),
          ],
        ),
        child: Column(
          children: [
            Text(
              number,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(
              title,
              style: const TextStyle(color: AppColors.textGray, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}
