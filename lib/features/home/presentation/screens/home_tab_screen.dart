// ignore_for_file: deprecated_member_use, must_be_immutable

import 'package:arabas_app/config/di/di.dart';
import 'package:arabas_app/core/constants/app_images.dart';
import 'package:arabas_app/features/announcement/presentation/bloc/announcement_cubit.dart';
import 'package:arabas_app/features/announcement/presentation/bloc/announcement_state.dart';
import 'package:arabas_app/features/books/presentation/screens/medical_books_screen.dart';
import 'package:arabas_app/features/courses/presentation/bloc/courses_sections_cubit.dart';
import 'package:arabas_app/features/courses/presentation/screens/Courses_tab_screen.dart';
import 'package:arabas_app/features/diplomas/presentation/bloc/diplomas_cubit.dart';
import 'package:arabas_app/features/diplomas/presentation/screens/diplomas_screen.dart';
import 'package:arabas_app/features/free_lectures/presentation/bloc/free_content_cubit.dart';
import 'package:arabas_app/features/free_lectures/presentation/screens/free_content_screen.dart';
import 'package:arabas_app/features/home/presentation/screens/about_arabas_screen.dart';
import 'package:arabas_app/features/notifications/presentation/bloc/delete_notification_cubit.dart';
import 'package:arabas_app/features/notifications/presentation/bloc/notification_cubit.dart';
import 'package:arabas_app/features/notifications/presentation/bloc/notification_number_cubit.dart';
import 'package:arabas_app/features/notifications/presentation/bloc/notification_number_state.dart';
import 'package:arabas_app/features/notifications/presentation/bloc/read_notification_cubit.dart';
import 'package:arabas_app/features/notifications/presentation/screens/notification_screen.dart';
import 'package:arabas_app/features/practicals/presentation/bloc/practical_cubit.dart';
import 'package:arabas_app/features/practicals/presentation/screens/practical_screen.dart';
import 'package:arabas_app/features/question_bank/presentation/bloc/bank_questions_cubit.dart';
import 'package:arabas_app/features/question_bank/presentation/screens/bank_questions_screen.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../../core/theme/app_colors.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: const Color(0xffF7F5FA),
        child: SingleChildScrollView(
          child: Column(
            children: [
              _header(context),

              SizedBox(height: 10.h),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                child: BlocProvider(
                  create: (_) => sl<AnnouncementCubit>()..getAnnouncements(),
                  child: const AnnouncementCarousel(),
                ),
              ),
              SizedBox(height: 10.h),
              _mainCard(
                title: "تعرف علي  المؤسسة",
                desc: " نبذة عن المؤسسة واهدافها",
                image: AppImages.aboutOrg,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const AboutArabasScreen(),
                    ),
                  );
                },
              ),

              _mainCard(
                title: "الدبلومة المتقدمة في أطفال الأنابيب والعقم",
                desc: "نبذة عن الدبلومة ومحتواها ",
                image: AppImages.bestProg,

                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (_) => BlocProvider(
                            create: (_) => sl<DiplomaCubit>(),
                            child: const DiplomaScreen(),
                          ),
                    ),
                  );
                },
              ),

              _mainCard(
                title: "كورسات مسجلة",
                desc: "كورسات مسجله جاهزة للمشاهدة في اي وقت واي  مكان",
                image: AppImages.recordedCourses,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (_) => BlocProvider(
                            create: (context) => sl<CoursesCubit>(),
                            child: const CoursesTabScreen(),
                          ),
                    ),
                  );
                },
              ),

              //
              Row(
                children: [
                  Expanded(
                    child: _smallCard(
                      title: "بنك الأسئلة",
                      desc: "تدرب علي ألاف الأسئلة الطبية",
                      image: AppImages.questionBank,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (_) => BlocProvider(
                                  create: (_) => sl<BankQuestionsCubit>(),
                                  child: const BankQuestionsScreen(),
                                ),
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: _smallCard1(
                      title: "التدريب العملي",
                      desc: "فرص تدريب عملي ",
                      image: AppImages.training,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (_) => BlocProvider(
                                  create: (_) => sl<PracticalCubit>(),
                                  child: const PracticalScreen(),
                                ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),

              Row(
                children: [
                  Expanded(
                    child: _smallCard(
                      title: "برنامج إدارة العيادة",
                      desc: "نظام متكامل لإدارة العيادات ",
                      image: AppImages.clinic,
                      onTap: () {},
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: _smallCard1(
                      title: "كتب طبية",
                      desc: "مجموعة مختارة من أفضل الكتب",
                      image: AppImages.medicalBooks,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => MedicalBooksScreen(),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),

              _freeSection(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (_) => BlocProvider(
                            create: (_) => sl<FreeContentCubit>(),
                            child: const FreeContentScreen(),
                          ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// HEADER
  Widget _header(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF4A2038), Color(0xFF75345C), Color(0xFF8C4A71)],
        ),
      ),
      child: Column(
        children: [
          SizedBox(height: 10.h),
          Builder(
            builder: (context) {
              return Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Scaffold.of(context).openDrawer();
                    },
                    icon: Icon(Icons.menu, color: Colors.white, size: 26.sp),
                  ),
                  SizedBox(width: 70.w),
                  _logoCircle(AppImages.logo),
                  SizedBox(width: 12.w),
                  _logoCircle(AppImages.logo2),
                  Spacer(),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (_) => MultiBlocProvider(
                                providers: [
                                  BlocProvider(
                                    create: (_) => sl<NotificationCubit>(),
                                  ),
                                  BlocProvider(
                                    create: (_) => sl<ReadNotificationCubit>(),
                                  ),
                                  BlocProvider(
                                    create:
                                        (_) => sl<DeleteNotificationCubit>(),
                                  ),
                                ],
                                child: const NotificationScreen(),
                              ),
                        ),
                      );
                      context.read<NotificationNumberCubit>().getUnreadCount();
                    },
                    child: Padding(
                      padding: EdgeInsets.only(right: 12.w),
                      child: BlocBuilder<
                        NotificationNumberCubit,
                        NotificationNumberState
                      >(
                        builder: (context, state) {
                          int notificationCount = 0;

                          if (state is NotificationNumberSuccess) {
                            notificationCount = state.count;
                          }

                          return Stack(
                            clipBehavior: Clip.none,
                            children: [
                              Icon(
                                Icons.notifications_outlined,
                                color: Colors.white,
                                size: 26.sp,
                              ),
                              if (notificationCount > 0)
                                Positioned(
                                  right: -2,
                                  top: -2,
                                  child: Container(
                                    constraints: BoxConstraints(
                                      minWidth: 18.w,
                                      minHeight: 18.h,
                                    ),
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 4.w,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.circular(20.r),
                                    ),
                                    child: Center(
                                      child: Text(
                                        notificationCount > 99
                                            ? "99+"
                                            : notificationCount.toString(),
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 9.sp,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
          SizedBox(height: 10.h),
          Text(
            "المؤسسة العربية للتعليم والتدريب",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              color: AppColors.white,
            ),
          ),
          SizedBox(height: 5.h),
          Text(
            "(ARABAS) - CPD 20960",
            style: TextStyle(fontSize: 12.sp, color: AppColors.white),
          ),

          SizedBox(height: 10.h),
        ],
      ),
    );
  }

  /// ANNOUNCEMENT
  // Widget _announcement() {
  //   return Builder(
  //     builder: (context) {
  //       return Container(
  //         padding: EdgeInsets.all(12.w),
  //         decoration: BoxDecoration(
  //           color: AppColors.white,
  //           borderRadius: BorderRadius.circular(16.r),
  //           boxShadow: [
  //             BoxShadow(color: Colors.black12.withOpacity(.05), blurRadius: 10),
  //           ],
  //         ),
  //         child: Row(
  //           children: [
  //             Icon(Icons.campaign, color: AppColors.primary, size: 24.sp),
  //             SizedBox(width: 10.w),
  //             Expanded(
  //               child: Text(
  //                 "إعلان هام: اكتشف برامجنا الجديدة\nللعام الجاري! اضغط لمشاهدة التفاصيل",
  //                 style: TextStyle(fontSize: 11.sp),
  //               ),
  //             ),
  //             InkWell(
  //               onTap: () {
  //                 Navigator.push(
  //                   context,
  //                   MaterialPageRoute(
  //                     builder: (_) => const AnnouncementScreen(),
  //                   ),
  //                 );
  //               },
  //               child: Container(
  //                 padding: EdgeInsets.symmetric(
  //                   horizontal: 14.w,
  //                   vertical: 6.h,
  //                 ),
  //                 decoration: BoxDecoration(
  //                   color: AppColors.primary,
  //                   borderRadius: BorderRadius.circular(12.r),
  //                 ),
  //                 child: Text(
  //                   "إعلانات",
  //                   style: TextStyle(color: Colors.white, fontSize: 12.sp),
  //                 ),
  //               ),
  //             ),
  //           ],
  //         ),
  //       );
  //     },
  //   );
  // }

  /// MAIN CARD
  Widget _mainCard({
    required String title,
    required String desc,
    required String image,
    required VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 12.h, left: 8.w, right: 8.w),
        padding: EdgeInsets.all(8.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(color: Colors.black12.withOpacity(.05), blurRadius: 10),
          ],
        ),
        child: Row(
          children: [
            Image.asset(image, height: 70.h, width: 100.w),
            SizedBox(width: 10.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    title,
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),
                  SizedBox(height: 1.h),
                  Text(
                    desc,
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      fontSize: 11.sp,
                      color: AppColors.textGray,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// SMALL CARD
  Widget _smallCard({
    required String title,
    required String image,
    required String desc,
    required VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 12.h, left: 8.w),
        padding: EdgeInsets.only(
          left: 8.w,
          right: 8.w,
          top: 15.h,
          bottom: 15.h,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(color: Colors.black12.withOpacity(.05), blurRadius: 10),
          ],
        ),
        child: Row(
          children: [
            Image.asset(image, height: 70.h, width: 50.w),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    title,
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primary,
                    ),
                  ),

                  Text(
                    desc,
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      fontSize: 11.sp,
                      color: AppColors.textGray,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _smallCard1({
    required String title,
    required String image,
    required String desc,
    required VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 12.h, right: 8.w),
        padding: EdgeInsets.only(
          left: 8.w,
          right: 8.w,
          top: 15.h,
          bottom: 15.h,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(color: Colors.black12.withOpacity(.05), blurRadius: 10),
          ],
        ),
        child: Row(
          children: [
            Image.asset(image, height: 70.h, width: 55.w),
            SizedBox(width: 10.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    title,
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primary,
                    ),
                  ),

                  Text(
                    desc,
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      fontSize: 11.sp,
                      color: AppColors.textGray,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// FREE SECTION
  Widget _freeSection({required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
        padding: EdgeInsets.all(8.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(color: Colors.black12.withOpacity(.05), blurRadius: 10),
          ],
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12.r),
              child: Image.asset(
                AppImages.free,
                height: 80.h,
                width: 100.w,
                fit: BoxFit.cover,
              ),
            ),

            SizedBox(width: 10.w),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "القسم المجاني",
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),

                  SizedBox(height: 5.h),

                  Text(
                    "محتوى مجاني شامل ومفيد",
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: AppColors.textGray,
                    ),
                  ),

                  SizedBox(height: 10.h),

                  Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 6.h,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      child: Text(
                        "اعرف المزيد",
                        style: TextStyle(color: Colors.white, fontSize: 14.sp),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _logoCircle(String image) {
    return Container(
      padding: EdgeInsets.all(3.w),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: CircleAvatar(
        radius: 35.r,
        backgroundImage: AssetImage(image),
        backgroundColor: Colors.white,
      ),
    );
  }
}

class AnnouncementCarousel extends StatefulWidget {
  const AnnouncementCarousel({super.key});

  @override
  State<AnnouncementCarousel> createState() => _AnnouncementCarouselState();
}

class _AnnouncementCarouselState extends State<AnnouncementCarousel> {
  int currentIndex = 0;

  Future<void> _openWhatsApp() async {
    final Uri url = Uri.parse("https://wa.me/201140060621");

    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<AnnouncementCubit>()..getAnnouncements(),
      child: BlocBuilder<AnnouncementCubit, AnnouncementState>(
        builder: (context, state) {
          if (state is AnnouncementLoading) {
            return const SizedBox.shrink();
          }

          if (state is AnnouncementError) {
            return const SizedBox.shrink();
          }

          if (state is! AnnouncementSuccess || state.announcements.isEmpty) {
            return const SizedBox.shrink();
          }

          return Column(
            children: [
              CarouselSlider.builder(
                itemCount: state.announcements.length,
                itemBuilder: (context, index, realIndex) {
                  final announcement = state.announcements[index];

                  return Container(
                    width: double.infinity,

                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 8.h,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFDCEAFA),
                      borderRadius: BorderRadius.circular(16.r),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(.05),
                          blurRadius: 10,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        SizedBox(
                          height: 38.h,
                          child: ElevatedButton(
                            onPressed: _openWhatsApp,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                              padding: EdgeInsets.symmetric(horizontal: 16.w),
                            ),
                            child: Text(
                              "تواصل معنا",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 11.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),

                        SizedBox(width: 12.w),

                        Expanded(
                          child: Text(
                            announcement.title,
                            textAlign: TextAlign.right,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 13.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
                options: CarouselOptions(
                  height: 60.h,
                  viewportFraction: 1,
                  autoPlay: true,
                  autoPlayInterval: const Duration(seconds: 4),
                  enlargeCenterPage: false,
                  onPageChanged: (index, reason) {
                    setState(() {
                      currentIndex = index;
                    });
                  },
                ),
              ),

              SizedBox(height: 8.h),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  state.announcements.length,
                  (index) => AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin: EdgeInsets.symmetric(horizontal: 3.w),
                    width: currentIndex == index ? 18.w : 8.w,
                    height: 8.h,
                    decoration: BoxDecoration(
                      color:
                          currentIndex == index
                              ? AppColors.primary
                              : Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
