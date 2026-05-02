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
    await Future.delayed(const Duration(seconds: 10));

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
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: [0, 0.25, 0.5, 0.75, 1], // عدلنا الـ stops بعد الحذف
            colors: [
              Color(0xFF2D1522),
              Color(0xFF5A2D46),
              Color(0xFF75345C),
              Color(0xFF8C4A71),
              Color(0xFFA05D84),
            ],
          ),
        ),
        child: Center(
          child: ClipOval(
            child: Container(
              width: 200.w,
              height: 200.w,
              color: Colors.transparent,
              child: Image.asset(AppImages.logo, fit: BoxFit.cover),
            ),
          ),
        ),
      ),
    );
  }
}
