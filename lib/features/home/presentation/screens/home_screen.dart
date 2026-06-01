import 'package:arabas_app/config/di/di.dart';
import 'package:arabas_app/features/courses/presentation/bloc/courses_sections_cubit.dart';
import 'package:arabas_app/features/courses/presentation/screens/Courses_tab_screen.dart';
import 'package:arabas_app/features/home/presentation/screens/app_drawer.dart';
import 'package:arabas_app/features/home/presentation/screens/home_tab_screen.dart';
import 'package:arabas_app/features/my_courses/presentation/bloc/my_courses_cubit.dart';
import 'package:arabas_app/features/my_courses/presentation/screens/my_courses_tab_screen.dart';
import 'package:arabas_app/features/profile/presentation/screens/profile_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';

class HomeScreen extends StatefulWidget {
  final int initialIndex;

  const HomeScreen({super.key, this.initialIndex = 0});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late int currentIndex;

  DateTime? lastBackPressed;

  final List<Widget> tabs = [
    HomeTab(),

    BlocProvider(
      create: (context) => sl<CoursesCubit>(),
      child: const CoursesTabScreen(),
    ),

    BlocProvider(
      create: (_) => sl<MyCoursesCubit>(),
      child: const MyCoursesTabScreen(),
    ),

    const ProfileWrapper(),
  ];

  @override
  void initState() {
    super.initState();
    currentIndex = widget.initialIndex;
  }

  void _handleBackPress() {
    final now = DateTime.now();

    if (lastBackPressed == null ||
        now.difference(lastBackPressed!) > const Duration(seconds: 2)) {
      lastBackPressed = now;

      ScaffoldMessenger.of(context).hideCurrentSnackBar();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          content: Text(
            "اضغط مرة أخرى للخروج من التطبيق",
            style: TextStyle(fontSize: 14.sp),
          ),
          duration: const Duration(seconds: 2),
        ),
      );

      return;
    }

    SystemNavigator.pop();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;

        _handleBackPress();
      },

      child: Scaffold(
        backgroundColor: AppColors.white,
        drawer: const AppDrawer(),

        body: tabs[currentIndex],

        bottomNavigationBar: BottomNavigationBar(
          iconSize: 22.sp,
          currentIndex: currentIndex,

          onTap: (index) {
            setState(() {
              currentIndex = index;
            });
          },

          type: BottomNavigationBarType.fixed,
          backgroundColor: AppColors.primary,
          selectedItemColor: AppColors.white,
          unselectedItemColor: Colors.grey,

          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "الرئيسيه"),

            BottomNavigationBarItem(icon: Icon(Icons.book), label: "الكورسات"),

            BottomNavigationBarItem(
              icon: Icon(Icons.play_lesson),
              label: "دوراتي",
            ),

            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: "الملف الشخصي",
            ),
          ],
        ),
      ),
    );
  }
}
