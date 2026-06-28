// ignore_for_file: deprecated_member_use, unused_element

import 'package:arabas_app/config/di/di.dart';
import 'package:arabas_app/core/theme/app_colors.dart';
import 'package:arabas_app/core/widgets/app_primary_button.dart';
import 'package:arabas_app/features/diplomas/presentation/bloc/diploma_details_cubit.dart';
import 'package:arabas_app/features/diplomas/presentation/bloc/diplomas_cubit.dart';
import 'package:arabas_app/features/diplomas/presentation/bloc/diplomas_state.dart';
import 'package:arabas_app/features/diplomas/presentation/screens/diploma_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DiplomaScreen extends StatefulWidget {
  const DiplomaScreen({super.key});

  @override
  State<DiplomaScreen> createState() => _DiplomaScreenState();
}

class _DiplomaScreenState extends State<DiplomaScreen> {
  @override
  void initState() {
    context.read<DiplomaCubit>().getDiplomas();
    super.initState();
  }

  void _goToDetails(dynamic diploma) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (_) => BlocProvider(
              create:
                  (_) =>
                      sl<DiplomaDetailsCubit>()..getDiplomaDetails(diploma.id),
              child: DiplomaDetailsScreen(diplomaId: diploma.id),
            ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back, color: AppColors.primary),
        ),
        title: const Text(
          "الدبلومات",
          style: TextStyle(
            color: AppColors.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: [
          SizedBox(height: 20.h),

          Expanded(
            child: BlocBuilder<DiplomaCubit, DiplomaState>(
              builder: (context, state) {
                if (state is DiplomaLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (state is DiplomaError) {
                  return Center(child: Text(state.message));
                }

                if (state is DiplomaLoaded) {
                  return ListView.builder(
                    padding: EdgeInsets.all(16.w),
                    itemCount: state.diplomas.length,
                    itemBuilder: (context, index) {
                      final diploma = state.diplomas[index];

                      final double oldPrice =
                          diploma.offer > 0
                              ? diploma.priceInEGP / (1 - (diploma.offer / 100))
                              : diploma.priceInEGP;

                      return Container(
                        margin: EdgeInsets.only(bottom: 20.h),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(22.r),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(.08),
                              blurRadius: 12,
                              offset: const Offset(0, 5),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            ///================ IMAGE =================
                            Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(22.r),
                                  ),
                                  child: Image.network(
                                    diploma.imageUrl,
                                    height: 200.h,
                                    width: double.infinity,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                Positioned(
                                  bottom: 20.h,
                                  left: 10.w,
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 10.w,
                                      vertical: 4.h,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Color(0xFFF7F9FF),
                                      borderRadius: BorderRadius.circular(5.r),
                                    ),
                                    child: Center(
                                      child: Text(
                                        diploma.level,
                                        textDirection: TextDirection.rtl,
                                        style: TextStyle(
                                          color: AppColors.primary,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),

                                /// Discount Badge
                                Positioned(
                                  top: 14.h,
                                  right: 14.w,
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 12.w,
                                      vertical: 7.h,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.circular(10.r),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(
                                          Icons.local_offer_outlined,
                                          color: Colors.white,
                                          size: 15.sp,
                                        ),

                                        SizedBox(width: 4.w),

                                        Text(
                                          "%${diploma.offer} خصم",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12.sp,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),

                                /// Level Badge
                              ],
                            ),

                            Padding(
                              padding: EdgeInsets.all(10.w),
                              child: Column(
                                children: [
                                  Text(
                                    diploma.title,
                                    textAlign: TextAlign.left,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 18.sp,
                                      color: AppColors.black,
                                      fontWeight: FontWeight.bold,
                                      height: 1.5,
                                    ),
                                  ),

                                  SizedBox(height: 15.h),

                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Icon(
                                          Icons.people,
                                          color: AppColors.primary,
                                          size: 20.sp,
                                        ),

                                        SizedBox(width: 6.w),

                                        Text(
                                          "${diploma.enrolledStudentsCount}",

                                          style: TextStyle(
                                            fontSize: 13.sp,
                                            color: Colors.grey[700],
                                          ),
                                        ),
                                        SizedBox(width: 30.w),

                                        Icon(
                                          Icons.workspace_premium_outlined,
                                          color: AppColors.primary,
                                          size: 20.sp,
                                        ),

                                        SizedBox(width: 6.w),

                                        Text(
                                          "شهادة معتمدة",

                                          style: TextStyle(
                                            fontSize: 13.sp,
                                            color: Colors.grey[700],
                                          ),
                                        ),
                                        SizedBox(width: 30.w),

                                        Icon(
                                          Icons.schedule,
                                          color: AppColors.primary,
                                          size: 20.sp,
                                        ),

                                        SizedBox(width: 6.w),

                                        Text(
                                          "${diploma.durationHours} ساعة",
                                          textDirection: TextDirection.rtl,
                                          style: TextStyle(
                                            fontSize: 13.sp,
                                            color: Colors.grey[700],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  SizedBox(height: 15.h),

                                  /// السعر
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      if (diploma.offer > 0)
                                        Text(
                                          "${oldPrice.toStringAsFixed(0)} ج.م",
                                          textDirection: TextDirection.rtl,
                                          style: TextStyle(
                                            fontSize: 18.sp,
                                            color: Colors.grey,
                                            decoration:
                                                TextDecoration.lineThrough,
                                          ),
                                        ),

                                      SizedBox(width: 12.w),

                                      Text(
                                        "${diploma.priceInEGP.toStringAsFixed(0)} ج.م",
                                        textDirection: TextDirection.rtl,
                                        style: TextStyle(
                                          fontSize: 24.sp,
                                          color: AppColors.primary,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),

                                  SizedBox(height: 15.h),

                                  /// زر التسجيل
                                  AppPrimaryButton(
                                    text: "سجل الآن",
                                    icon: Icons.arrow_back,
                                    onPressed: () => _goToDetails(diploma),
                                    boxShadow: [
                                      BoxShadow(
                                        color: AppColors.primary.withOpacity(
                                          .3,
                                        ),
                                        blurRadius: 15,
                                        offset: const Offset(0, 6),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                }

                return const SizedBox();
              },
            ),
          ),
        ],
      ),
    );
  }
}
