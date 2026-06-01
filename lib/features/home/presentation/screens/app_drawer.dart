// ignore_for_file: deprecated_member_use

import 'package:arabas_app/config/di/di.dart';
import 'package:arabas_app/core/theme/app_colors.dart';
import 'package:arabas_app/features/auth/presentation/bloc/login_cubit.dart';
import 'package:arabas_app/features/auth/presentation/screens/login_screen.dart';
import 'package:arabas_app/features/book_courses/presentation/bloc/course-book_cubit.dart';
import 'package:arabas_app/features/book_courses/presentation/screens/course_books_screen.dart';
import 'package:arabas_app/features/book_courses/presentation/screens/verify_book_screen.dart';
import 'package:arabas_app/features/certificates/presentation/bloc/my_certificates_cubit.dart';
import 'package:arabas_app/features/certificates/presentation/screens/my_certificates_screen.dart';
import 'package:arabas_app/features/profile/presentation/screens/profile_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.white,

      child: SafeArea(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 35.h),
              color: AppColors.primary,

              child: Column(
                children: [
                  CircleAvatar(
                    radius: 38.r,
                    backgroundColor: AppColors.white,

                    child: Icon(
                      Icons.person,
                      size: 38.sp,
                      color: AppColors.primary,
                    ),
                  ),

                  SizedBox(height: 14.h),

                  Text(
                    "مرحبا بك",
                    style: TextStyle(
                      color: AppColors.white,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 25.h),

            _drawerItem(
              context,
              icon: Icons.person_outline,
              title: "الملف الشخصي",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const ProfileWrapper()),
                );
              },
            ),

            SizedBox(height: 10.h),

            _drawerItem(
              context,
              icon: Icons.menu_book_rounded,
              title: "كورسات الكتاب",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (_) => BlocProvider(
                          create:
                              (_) => sl<CourseBooksCubit>()..getCourseBooks(),
                          child: const CourseBooksScreen(),
                        ),
                  ),
                );
              },
            ),

            SizedBox(height: 10.h),

            _drawerItem(
              context,
              icon: Icons.settings_outlined,
              title: "الإعدادات",
              onTap: () {},
            ),

            SizedBox(height: 10.h),
            _drawerItem(
              context,
              icon: Icons.workspace_premium_outlined,
              title: "شهاداتي",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (_) => BlocProvider(
                          create:
                              (_) => sl<CertificateCubit>()..getCertificates(),
                          child: const MyCertificatesScreen(),
                        ),
                  ),
                );
              },
            ),
            SizedBox(height: 10.h),
            _drawerItem(
              context,
              icon: Icons.verified_outlined,
              title: "Verify Book",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const VerifyBookScreen()),
                );
              },
            ),
            SizedBox(height: 10.h),

            _drawerItem(
              context,
              icon: Icons.logout,
              title: "تسجيل الخروج",

              isLogout: true,

              onTap: () {
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
            ),
          ],
        ),
      ),
    );
  }

  Widget _drawerItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    bool isLogout = false,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.w),

      child: InkWell(
        borderRadius: BorderRadius.circular(14.r),
        onTap: onTap,

        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 16.h),

          decoration: BoxDecoration(
            color: isLogout ? Colors.red.withOpacity(.06) : AppColors.white,

            borderRadius: BorderRadius.circular(14.r),
          ),

          child: Row(
            children: [
              Icon(
                icon,
                color: isLogout ? Colors.red : AppColors.primary,
                size: 24.sp,
              ),

              SizedBox(width: 12.w),

              Expanded(
                child: Align(
                  alignment: Alignment.centerRight,

                  child: Text(
                    title,
                    textAlign: TextAlign.right,

                    style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w600,

                      color: isLogout ? Colors.red : AppColors.primary,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
