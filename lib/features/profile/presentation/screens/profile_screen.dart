import 'package:arabas_app/config/di/di.dart';
import 'package:arabas_app/core/widgets/profile_state_card.dart';
import 'package:arabas_app/features/auth/presentation/bloc/login_cubit.dart';
import 'package:arabas_app/features/auth/presentation/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/profile_menu_item.dart';
import '../bloc/profile_cubit.dart';
import '../bloc/profile_state.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfileCubit, ProfileState>(
      listener: (context, state) {
        if (state is ProfileSessionExpired) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));

          Navigator.pushNamedAndRemoveUntil(
            context,
            "/login",
            (route) => false,
          );
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.white,
        body: SafeArea(
          child: BlocBuilder<ProfileCubit, ProfileState>(
            builder: (context, state) {
              if (state is ProfileLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              if (state is ProfileError) {
                return Center(
                  child: Text(state.message, style: TextStyle(fontSize: 16.sp)),
                );
              }

              if (state is ProfileSuccess) {
                final user = state.profile;

                return SingleChildScrollView(
                  child: Column(
                    children: [
                      /// HEADER
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(16.w),
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(24.r),
                            bottomRight: Radius.circular(24.r),
                          ),
                        ),
                        child: Column(
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Icon(
                                Icons.arrow_back,
                                color: Colors.white,
                                size: 22.sp,
                              ),
                            ),
                            SizedBox(height: 10.h),

                            CircleAvatar(
                              radius: 45.r,
                              backgroundImage: NetworkImage(user.imageUrl),
                            ),

                            SizedBox(height: 10.h),

                            Text(
                              user.fullName,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            Text(
                              user.email,
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 14.sp,
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 20.h),

                      /// STATS
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        child: Row(
                          children: [
                            ProfileStatCard(
                              number: user.totalCourses.toString(),
                              title: "Courses",
                            ),
                            SizedBox(width: 10.w),
                            ProfileStatCard(
                              number: user.totalExamSolve.toString(),
                              title: "Exams",
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 20.h),

                      /// MENU
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        child: Column(
                          children: [
                            ProfileMenuItem(
                              icon: Icons.person,
                              title: "Phone: ${user.phoneNumber}",
                            ),
                            ProfileMenuItem(
                              icon: Icons.badge,
                              title: "Role: ${user.role}",
                            ),
                            ProfileMenuItem(
                              icon: Icons.phone_android,
                              title: "Device: ${user.phoneName}",
                            ),
                            ProfileMenuItem(
                              icon: Icons.devices,
                              title: "Platform: ${user.platform}",
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 20.h),

                      /// LOGOUT BUTTON
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            minimumSize: Size(double.infinity, 50.h),
                          ),
                          onPressed: () {
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
                          },
                          child: Text(
                            "Sign Out",
                            style: TextStyle(
                              fontSize: 16.sp,
                              color: AppColors.white,
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: 20.h),
                    ],
                  ),
                );
              }

              return const SizedBox();
            },
          ),
        ),
      ),
    );
  }
}
