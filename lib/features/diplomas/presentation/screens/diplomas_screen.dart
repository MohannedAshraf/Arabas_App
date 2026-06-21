// ignore_for_file: deprecated_member_use

import 'package:arabas_app/config/di/di.dart';
import 'package:arabas_app/core/theme/app_colors.dart';
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
      backgroundColor: const Color(0xffF5F5F5),
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
      body: BlocBuilder<DiplomaCubit, DiplomaState>(
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

                return Container(
                  margin: EdgeInsets.only(bottom: 22.h),
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
                              height: 250.h,
                              width: double.infinity,
                              fit: BoxFit.cover,
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
                        padding: EdgeInsets.all(18.w),
                        child: Column(
                          children: [
                            Text(
                              diploma.title,
                              textAlign: TextAlign.left,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 20.sp,
                                color: AppColors.primary,
                                fontWeight: FontWeight.bold,
                                height: 1.5,
                              ),
                            ),

                            SizedBox(height: 18.h),

                            Align(
                              alignment: Alignment.centerRight,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
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

                            SizedBox(height: 18.h),

                            /// السعر
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                if (diploma.priceOutEGP > 0)
                                  Text(
                                    "${diploma.priceOutEGP.toStringAsFixed(0)} ج.م",
                                    textDirection: TextDirection.rtl,
                                    style: TextStyle(
                                      fontSize: 18.sp,
                                      color: Colors.grey,
                                      decoration: TextDecoration.lineThrough,
                                    ),
                                  ),

                                SizedBox(width: 12.w),

                                Text(
                                  "${diploma.priceInEGP.toStringAsFixed(0)} ج.م",
                                  textDirection: TextDirection.rtl,
                                  style: TextStyle(
                                    fontSize: 32.sp,
                                    color: AppColors.primary,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),

                            SizedBox(height: 24.h),

                            /// زر التسجيل
                            SizedBox(
                              width: double.infinity,
                              height: 58.h,
                              child: ElevatedButton(
                                onPressed: () => _goToDetails(diploma),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.primary,
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16.r),
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.arrow_back,
                                      color: Colors.white,
                                      size: 20.sp,
                                    ),

                                    SizedBox(width: 8.w),

                                    Text(
                                      "سجل الآن",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18.sp,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
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
    );
  }
}
