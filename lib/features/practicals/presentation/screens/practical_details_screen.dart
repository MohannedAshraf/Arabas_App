// ignore_for_file: deprecated_member_use

import 'package:arabas_app/core/theme/app_colors.dart';
import 'package:arabas_app/features/practicals/presentation/bloc/practical_details_cubit.dart';
import 'package:arabas_app/features/practicals/presentation/bloc/practical_details_state.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

class PracticalDetailsScreen extends StatefulWidget {
  final String id;

  const PracticalDetailsScreen({super.key, required this.id});

  @override
  State<PracticalDetailsScreen> createState() => _PracticalDetailsScreenState();
}

class _PracticalDetailsScreenState extends State<PracticalDetailsScreen> {
  Future<void> _openWhatsapp() async {
    final Uri url = Uri.parse("https://wa.me/201140060621");

    await launchUrl(url, mode: LaunchMode.externalApplication);
  }

  @override
  void initState() {
    super.initState();

    context.read<PracticalDetailsCubit>().getDetails(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: SafeArea(
        child: Container(
          padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 12.h),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(.08),
                blurRadius: 12,
                offset: const Offset(0, -2),
              ),
            ],
          ),
          child: SizedBox(
            height: 55.h,
            child: ElevatedButton(
              onPressed: _openWhatsapp,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.r),
                ),
              ),
              child: Text(
                "احجز الآن",
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      ),

      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "تفاصيل التدريب",
          style: TextStyle(
            color: AppColors.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: BackButton(color: AppColors.primary),
      ),

      body: BlocBuilder<PracticalDetailsCubit, PracticalDetailsState>(
        builder: (context, state) {
          if (state is PracticalDetailsLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is PracticalDetailsError) {
            return Center(child: Text(state.message));
          }

          if (state is PracticalDetailsSuccess) {
            final item = state.practical;
            final cleanDescription = item.description
                .replaceAll('text-align: center;', '')
                .replaceAll('text-align:center;', '');

            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// MAIN IMAGE
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20.r),
                    child: Image.network(
                      item.imageUrl,
                      width: double.infinity,
                      height: 240.h,
                      fit: BoxFit.cover,
                      errorBuilder:
                          (context, error, stackTrace) => Container(
                            height: 240.h,
                            color: Colors.grey.shade300,
                            child: const Center(
                              child: Icon(Icons.broken_image, size: 50),
                            ),
                          ),
                    ),
                  ),

                  SizedBox(height: 20.h),

                  /// TITLE
                  Text(
                    item.title,
                    style: TextStyle(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),

                  SizedBox(height: 20.h),

                  /// DESCRIPTION TITLE
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      "الوصف",
                      textDirection: TextDirection.rtl,
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                    ),
                  ),

                  SizedBox(height: 10.h),

                  /// DESCRIPTION HTML
                  ///
                  Html(data: cleanDescription),

                  SizedBox(height: 15.h),

                  /// STUDENTS TITLE
                  if (item.students.isNotEmpty)
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        "صور المتدربين",
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                        ),
                      ),
                    ),

                  if (item.students.isNotEmpty) SizedBox(height: 15.h),

                  if (item.students.isNotEmpty)
                    CarouselSlider.builder(
                      itemCount: item.students.length,
                      options: CarouselOptions(
                        height: 250.h,
                        autoPlay: true,
                        autoPlayInterval: const Duration(seconds: 3),
                        autoPlayAnimationDuration: const Duration(
                          milliseconds: 800,
                        ),
                        enlargeCenterPage: true,
                        viewportFraction: .85,
                        enableInfiniteScroll: true,
                      ),
                      itemBuilder: (context, index, realIndex) {
                        return Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16.r),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(.12),
                                blurRadius: 12,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(24.r),
                            child: Image.network(
                              item.students[index].imageUrl,
                              fit: BoxFit.contain,
                              width: double.infinity,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  color: Colors.grey.shade300,
                                  child: const Center(
                                    child: Icon(Icons.broken_image, size: 40),
                                  ),
                                );
                              },
                            ),
                          ),
                        );
                      },
                    ),

                  SizedBox(height: 15.h),

                  /// CERTIFICATE TITLE
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      "الشهادة",
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                    ),
                  ),

                  SizedBox(height: 12.h),

                  /// CERTIFICATE IMAGE
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16.r),
                      border: Border.all(color: Colors.grey.shade200, width: 1),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(.08),
                          blurRadius: 15,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16.r),
                      child: Image.network(
                        item.certificateUrl,
                        width: double.infinity,
                        height: 280.h,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),

                  SizedBox(height: 15.h),
                ],
              ),
            );
          }

          return const SizedBox();
        },
      ),
    );
  }
}
