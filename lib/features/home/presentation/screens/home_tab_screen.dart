import 'package:flutter/material.dart';
import '../../../../../core/theme/app_colors.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        "Home Tab",
        style: TextStyle(fontSize: 22, color: AppColors.primary),
      ),
    );
  }
}
