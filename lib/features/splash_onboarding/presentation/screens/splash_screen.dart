import 'dart:async';
import 'package:arabas_app/config/di/di.dart';
import 'package:arabas_app/core/services/local_storage_services.dart';
import 'package:arabas_app/features/auth/presentation/bloc/login_cubit.dart';
import 'package:arabas_app/features/auth/presentation/screens/login_screen.dart';
import 'package:arabas_app/features/home/presentation/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/constants/app_images.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    navigate();
  }

  Future<void> navigate() async {
    // ⏳ Splash delay
    await Future.delayed(const Duration(seconds: 3));

    final localStorage = sl<LocalStorageService>();

    final token = localStorage.getAccessToken();

    if (!mounted) return;

    if (token.isNotEmpty) {
      // ✅ user logged in
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const HomeScreen()),
      );
    } else {
      // ❌ not logged in
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder:
              (_) => BlocProvider(
                create: (_) => sl<LoginCubit>(),
                child: const LoginScreen(),
              ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(child: Image.asset(AppImages.logo, width: 180.w)),
    );
  }
}
