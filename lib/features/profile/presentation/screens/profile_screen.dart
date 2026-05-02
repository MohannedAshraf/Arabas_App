import 'package:arabas_app/config/di/di.dart';
import 'package:arabas_app/core/theme/app_colors.dart';
import 'package:arabas_app/features/auth/presentation/bloc/login_cubit.dart';
import 'package:arabas_app/features/auth/presentation/screens/login_screen.dart';
import 'package:arabas_app/features/profile/presentation/screens/widgets/active_sessions_section.dart';
import 'package:arabas_app/features/profile/presentation/screens/widgets/profile_header.dart';
import 'package:arabas_app/features/profile/presentation/screens/widgets/profile_stats_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../bloc/profile_cubit.dart';
import '../bloc/profile_state.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    context.read<ProfileCubit>().getProfile();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF6F7FB),
      appBar: AppBar(
        title: Text(
          "الملف الشخصي",
          style: TextStyle(
            color: AppColors.primary,
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),

      body: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) {
          if (state is ProfileLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is ProfileError) {
            return Center(child: Text(state.message));
          }

          if (state is ProfileSuccess) {
            final user = state.profile;

            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    /// HEADER
                    ProfileHeader(
                      image: user.imageUrl,
                      name: user.fullName,
                      email: user.email,
                      role: user.role,
                    ),

                    SizedBox(height: 20.h),

                    Column(
                      children: [
                        /// STATS
                        ProfileStatsSection(
                          courses: user.totalCourses,
                          exams: user.totalExamSolve,
                        ),

                        SizedBox(height: 25.h),

                        /// ACTIVE SESSIONS
                        ActiveSessionsSection(
                          devices: user.phoneName,
                          platforms: user.platform,
                        ),

                        SizedBox(height: 25.h),

                        /// LOGOUT
                        InkWell(
                          borderRadius: BorderRadius.circular(16.r),
                          onTap: () {
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (_) => BlocProvider(
                                      create: (_) => sl<LoginCubit>(),
                                      child: const LoginScreen(),
                                    ),
                              ),
                              (route) => false,
                            );
                          },
                          child: Container(
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(vertical: 8.h),
                            decoration: BoxDecoration(
                              color: AppColors.primary, // light red background
                              borderRadius: BorderRadius.circular(16.r),
                            ),
                            child: Center(
                              child: Text(
                                "تسجيل الخروج",
                                style: TextStyle(
                                  color: AppColors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.sp,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 25.h),
                      ],
                    ),
                  ],
                ),
              ),
            );
          }

          return const SizedBox();
        },
      ),
    );
  }
}
