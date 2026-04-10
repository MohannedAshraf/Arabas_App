import 'package:arabas_app/features/home/presentation/screens/favourite_tab.dart';
import 'package:arabas_app/features/home/presentation/screens/home_tab_screen.dart';
import 'package:arabas_app/features/home/presentation/screens/my_courses_tab.dart';
import 'package:arabas_app/features/home/presentation/screens/profile_tab.dart';
import 'package:flutter/material.dart';

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
    ProfileTab(),
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
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },

        type: BottomNavigationBarType.fixed,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: Colors.grey,

        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.book), label: "My Courses"),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: "Favourites",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }
}
