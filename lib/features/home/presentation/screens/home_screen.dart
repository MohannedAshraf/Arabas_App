import 'package:arabas_app/features/home/presentation/screens/favourite_tab.dart';
import 'package:arabas_app/features/home/presentation/screens/home_tab_screen.dart';
import 'package:arabas_app/features/home/presentation/screens/my_courses_tab.dart';
import 'package:arabas_app/features/profile/presentation/screens/profile_wrapper.dart';
import 'package:flutter/material.dart';
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

  final List<Widget> tabs = const [
    HomeTab(),
    MyCoursesTab(),
    FavouritesTab(),
    ProfileWrapper(),
  ];

  @override
  void initState() {
    super.initState();
    currentIndex = widget.initialIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,

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
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: "المفضلة"),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "الملف الشخصي",
          ),
        ],
      ),
    );
  }
}
