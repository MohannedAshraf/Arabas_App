// ignore_for_file: deprecated_member_use

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/theme/app_colors.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  int currentIndex = 0;

  final List<String> images = [
    "https://img.freepik.com/free-vector/doctor-concept-illustration_114360-1516.jpg",
    "https://img.freepik.com/free-vector/medical-team-concept-illustration_114360-1515.jpg",
    "https://img.freepik.com/free-vector/pediatrician-concept-illustration_114360-1676.jpg",
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: const Color(0xffF7F5FA),
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// HEADER
              Row(
                children: [
                  CircleAvatar(
                    radius: 26.r,
                    backgroundImage: const NetworkImage(
                      "https://i.pravatar.cc/150?img=12",
                    ),
                    // backgroundImage: AssetImage("assets/images/profile.png"),
                  ),
                  SizedBox(width: 12.w),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          " ًWelcome",
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          "Ready to improve your skills? Here's what we offer today...",
                          style: TextStyle(
                            color: AppColors.textGray,
                            fontSize: 12.sp,
                          ),
                        ),
                      ],
                    ),
                  ),

                  /// 🔔 Notification with badge
                  Stack(
                    children: [
                      Icon(Icons.notifications_none, size: 26.sp),
                      Positioned(
                        right: 0,
                        top: 0,
                        child: Container(
                          width: 8.w,
                          height: 8.h,
                          decoration: const BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              SizedBox(height: 25.h),

              /// SEARCH
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                height: 50.h,
                decoration: BoxDecoration(
                  color: const Color(0xffEEF1F6),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Row(
                  children: [
                    Icon(Icons.search, color: AppColors.textGray, size: 20.sp),
                    SizedBox(width: 10.w),
                    Text(
                      "Search for Courses, Diplomas",
                      style: TextStyle(
                        color: AppColors.textGray,
                        fontSize: 13.sp,
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 25.h),

              /// CATEGORIES
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _categoryItem(
                    "Courses",
                    "https://cdn-icons-png.flaticon.com/512/3135/3135755.png",
                  ),
                  _categoryItem(
                    "Practical Training ",
                    "https://cdn-icons-png.flaticon.com/512/4320/4320337.png",
                  ),
                  _categoryItem(
                    "Questions Bank",
                    "https://cdn-icons-png.flaticon.com/512/1828/1828919.png",
                  ),
                  _categoryItem(
                    "Books",
                    "https://cdn-icons-png.flaticon.com/512/2232/2232688.png",
                  ),
                ],
              ),

              SizedBox(height: 30.h),

              /// CAROUSEL
              Text(
                "Featured Courses",
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 15.h),

              CarouselSlider.builder(
                itemCount: images.length,
                itemBuilder: (context, index, realIndex) {
                  return Container(
                    width: double.infinity,
                    margin: EdgeInsets.symmetric(horizontal: 6.w),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.r),
                      image: DecorationImage(
                        image: NetworkImage(images[index]),
                        fit: BoxFit.cover,
                      ),
                      // image: DecorationImage(image: AssetImage("assets/images/course.png"), fit: BoxFit.cover),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.r),
                        gradient: LinearGradient(
                          colors: [
                            Colors.black.withOpacity(0.1),
                            const Color(0xff6A1B3F).withOpacity(0.7),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      alignment: Alignment.bottomRight,
                      padding: EdgeInsets.all(16.w),
                      child: Text(
                        "Pediatrics Diploma\nAdvanced-8 Weeks",
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  );
                },
                options: CarouselOptions(
                  height: 160.h,
                  autoPlay: true,
                  viewportFraction: 0.9,
                  enlargeCenterPage: true,
                  onPageChanged: (index, reason) {
                    setState(() => currentIndex = index);
                  },
                ),
              ),

              SizedBox(height: 12.h),

              /// 🔥 DOTS INDICATOR
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  images.length,
                  (index) => AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin: EdgeInsets.symmetric(horizontal: 4.w),
                    width: currentIndex == index ? 20.w : 8.w,
                    height: 8.h,
                    decoration: BoxDecoration(
                      color:
                          currentIndex == index
                              ? AppColors.primary
                              : Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                  ),
                ),
              ),

              SizedBox(height: 30.h),

              /// CONTINUE LEARNING
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    " Continue Learning",
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "We are the best ",
                    style: TextStyle(
                      color: AppColors.textGray,
                      fontSize: 12.sp,
                    ),
                  ),
                ],
              ),

              SizedBox(height: 15.h),
              _continueCard(),

              SizedBox(height: 30.h),

              Text(
                " Main Sections",
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 15.h),

              Row(
                children: [
                  Expanded(child: _smallCard("Questions Bank")),
                  SizedBox(width: 15.w),
                  Expanded(child: _smallCard(" Courses")),
                ],
              ),

              SizedBox(height: 20.h),
              _freeSection(),
              SizedBox(height: 30.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _categoryItem(String title, String img) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(15.w),
          decoration: BoxDecoration(
            color: AppColors.primaryLight,
            borderRadius: BorderRadius.circular(16.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Image.network(img, height: 35.h),
          // Image.asset("assets/images/category.png")
        ),
        SizedBox(height: 6.h),
        Text(title, style: TextStyle(fontSize: 12.sp)),
      ],
    );
  }

  Widget _continueCard() {
    return Container(
      padding: EdgeInsets.all(15.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18.r),
        boxShadow: [
          BoxShadow(color: Colors.black12.withOpacity(.05), blurRadius: 10),
        ],
      ),
      child: Row(
        children: [
          Image.network(
            "https://cdn-icons-png.flaticon.com/512/3209/3209265.png",
            height: 45.h,
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "ICU",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14.sp,
                  ),
                ),
                Text(
                  "Intensive Care Unit ",
                  style: TextStyle(color: AppColors.textGray, fontSize: 12.sp),
                ),
                SizedBox(height: 6.h),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10.r),
                  child: const LinearProgressIndicator(
                    value: 0.6,
                    minHeight: 6,
                    color: AppColors.green,
                    backgroundColor: Color(0xffE5E5E5),
                  ),
                ),
              ],
            ),
          ),
          Column(
            children: [
              CircleAvatar(
                radius: 16.r,
                backgroundImage: NetworkImage(
                  "https://i.pravatar.cc/100?img=12",
                ),
              ),
              SizedBox(height: 5.h),
              Text(
                "8 Weeks",
                style: TextStyle(fontSize: 10.sp, color: AppColors.textGray),
              ),
            ],
          ),
          SizedBox(width: 8.w),
          Text(
            "60%",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.sp),
          ),
        ],
      ),
    );
  }

  Widget _smallCard(String title) {
    return Container(
      padding: EdgeInsets.all(15.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Image.network(
            "https://cdn-icons-png.flaticon.com/512/3135/3135715.png",
            height: 40.h,
          ),
          SizedBox(width: 10.w),
          Expanded(child: Text(title, style: TextStyle(fontSize: 13.sp))),
        ],
      ),
    );
  }

  Widget _freeSection() {
    return Container(
      height: 170.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.r),
        image: const DecorationImage(
          image: NetworkImage(
            "https://img.freepik.com/free-vector/gift-box-concept-illustration_114360-1276.jpg",
          ),
          fit: BoxFit.cover,
        ),
        // DecorationImage(image: AssetImage("assets/images/free.png"))
      ),
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.r),
          gradient: LinearGradient(
            colors: [
              Colors.black.withOpacity(0.1),
              const Color(0xff6A1B3F).withOpacity(0.7),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        alignment: Alignment.bottomRight,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              "Free Section ",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 5.h),
            Text(
              "Enjoy comorehensive free content",
              style: TextStyle(color: Colors.white70, fontSize: 12.sp),
            ),
            SizedBox(height: 10.h),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
              decoration: BoxDecoration(
                color: const Color(0xff6A1B3F),
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Text(
                "Start Now",
                style: TextStyle(color: Colors.white, fontSize: 12.sp),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
