// ignore_for_file: deprecated_member_use

import 'package:arabas_app/config/di/di.dart';
import 'package:arabas_app/core/widgets/app_primary_button.dart';
import 'package:arabas_app/features/practicals/presentation/bloc/practical_cubit.dart';
import 'package:arabas_app/features/practicals/presentation/bloc/practical_details_cubit.dart';
import 'package:arabas_app/features/practicals/presentation/bloc/practical_state.dart';
import 'package:arabas_app/features/practicals/presentation/screens/practical_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';

class PracticalScreen extends StatefulWidget {
  const PracticalScreen({super.key});

  @override
  State<PracticalScreen> createState() => _PracticalScreenState();
}

class _PracticalScreenState extends State<PracticalScreen> {
  @override
  void initState() {
    context.read<PracticalCubit>().getPracticals();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "التدريبات العملية",
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
            color: AppColors.primary,
          ),
        ),
        centerTitle: true,
        leading: BackButton(color: AppColors.primary),
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 10.h),
            Padding(
              padding: EdgeInsets.only(right: 16.w),
              child: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  "اكتشف مهاراتك",
                  textDirection: TextDirection.rtl,
                  textAlign: TextAlign.end,
                  style: TextStyle(
                    color: AppColors.black,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(height: 10.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  "انضم إلي أفضل الورش  التدريبية المصممة لتطوير المهارات الطبية العملية والسريرية",
                  textDirection: TextDirection.rtl,

                  style: TextStyle(color: AppColors.black, fontSize: 13.sp),
                ),
              ),
            ),

            SizedBox(height: 10.h),
            BlocBuilder<PracticalCubit, PracticalState>(
              builder: (context, state) {
                if (state is PracticalLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (state is PracticalError) {
                  return Center(child: Text(state.message));
                }

                if (state is PracticalSuccess) {
                  return Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          width: 130.w,
                          height: 30.h,
                          margin: EdgeInsets.only(left: 16.w),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50.r),
                            color: const Color(0x1A743F5B).withOpacity(0.1),
                          ),
                          child: Center(
                            child: Text(
                              "${state.practicals.length} تدريبات متاحة",
                              textDirection: TextDirection.rtl,
                              style: TextStyle(
                                color: Color(0XFF743F5B),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: 10.h),

                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.all(16.w),
                        itemCount: state.practicals.length,
                        itemBuilder: (context, index) {
                          final item = state.practicals[index];

                          return Container(
                            margin: EdgeInsets.only(bottom: 16.h),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20.r),
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 10,
                                  color: Colors.black12,
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                Stack(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(20.r),
                                      ),
                                      child: Image.network(
                                        item.imageUrl,
                                        height: 200.h,
                                        width: double.infinity,
                                        fit: BoxFit.cover,

                                        errorBuilder: (
                                          context,
                                          error,
                                          stackTrace,
                                        ) {
                                          debugPrint(error.toString());

                                          return Container(
                                            height: 200.h,
                                            width: double.infinity,
                                            color: Colors.grey.shade200,
                                            child: const Icon(
                                              Icons.image_not_supported,
                                              size: 50,
                                            ),
                                          );
                                        },

                                        loadingBuilder: (
                                          context,
                                          child,
                                          loadingProgress,
                                        ) {
                                          if (loadingProgress == null) {
                                            return child;
                                          }

                                          return SizedBox(
                                            height: 200.h,
                                            child: const Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            ),
                                          );
                                        },
                                      ),
                                    ),

                                    Positioned(
                                      right: 16.w,
                                      top: 16.h,
                                      width: 120.5.w,
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                          vertical: 8.h,
                                          horizontal: 12.w,
                                        ),

                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            12.r,
                                          ),
                                          color: AppColors.white,
                                        ),
                                        child: Center(
                                          child: Row(
                                            children: [
                                              Text(
                                                "ورشة عملية",
                                                style: TextStyle(
                                                  color: Color(0xFF146A59),
                                                  fontSize: 12.sp,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              SizedBox(width: 8.w),
                                              Icon(
                                                Icons.medical_services,
                                                color: Color(0xFF146A59),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 12.h),
                                Padding(
                                  padding: EdgeInsets.only(
                                    left: 16.w,
                                    bottom: 10.h,
                                  ),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      item.title,
                                      textDirection: TextDirection.ltr,
                                      style: TextStyle(
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.primary,
                                      ),
                                    ),
                                  ),
                                ),
                                // SizedBox(height: 10.h),
                                // Padding(
                                //   padding: EdgeInsets.symmetric(horizontal: 8.w),
                                //   child: Align(
                                //     alignment: Alignment.centerRight,
                                //     child: Html(
                                //       data: item.description,
                                //       style: {
                                //         "body": Style(
                                //           margin: Margins.zero,
                                //           padding: HtmlPaddings.zero,
                                //           fontSize: FontSize(15.sp),
                                //           color: Color(0xFF514349),
                                //           textAlign: TextAlign.right,
                                //           direction: TextDirection.rtl,
                                //         ),
                                //         "h1": Style(
                                //           textAlign: TextAlign.right,
                                //           direction: TextDirection.rtl,
                                //         ),
                                //         "h2": Style(
                                //           textAlign: TextAlign.right,
                                //           direction: TextDirection.rtl,
                                //         ),
                                //         "h3": Style(
                                //           textAlign: TextAlign.right,
                                //           direction: TextDirection.rtl,
                                //         ),
                                //         "p": Style(
                                //           textAlign: TextAlign.right,
                                //           direction: TextDirection.rtl,
                                //         ),
                                //         "div": Style(
                                //           textAlign: TextAlign.right,
                                //           direction: TextDirection.rtl,
                                //         ),
                                //       },
                                //     ),
                                //   ),
                                // ),
                                SizedBox(height: 15.h),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 8.w,
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        "متاح  ل ${item.studentsCount} طالب",
                                        style: TextStyle(
                                          color: AppColors.primaryLight,
                                          fontSize: 12.sp,
                                        ),
                                        textDirection: TextDirection.rtl,
                                      ),
                                      SizedBox(width: 5.w),
                                      Icon(
                                        Icons.people_alt,
                                        color: AppColors.primary,
                                      ),

                                      SizedBox(width: 20.w),

                                      Text(
                                        "${item.durationInHours} ساعات",
                                        textDirection: TextDirection.rtl,
                                        style: TextStyle(
                                          color: AppColors.primaryLight,
                                          fontSize: 12.sp,
                                        ),
                                      ),
                                      SizedBox(width: 5.w),
                                      Icon(
                                        Icons.schedule,
                                        color: AppColors.primary,
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 15.h),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 32.w,
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Icon(
                                        Icons.bookmark_border_rounded,
                                        color: AppColors.primary,
                                        size: 24.sp,
                                      ),
                                      Spacer(),

                                      AppPrimaryButton(
                                        width: 170.w,
                                        height: 45.h,
                                        text: "عرض التفاصيل",

                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder:
                                                  (_) => BlocProvider(
                                                    create:
                                                        (_) =>
                                                            sl<
                                                              PracticalDetailsCubit
                                                            >(),
                                                    child:
                                                        PracticalDetailsScreen(
                                                          id: item.id,
                                                        ),
                                                  ),
                                            ),
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                ),

                                SizedBox(height: 20.h),
                              ],
                            ),
                          );
                        },
                      ),
                    ],
                  );
                }

                return const SizedBox();
              },
            ),
          ],
        ),
      ),
    );
  }
}
