// ignore_for_file: deprecated_member_use

import 'package:arabas_app/core/theme/app_colors.dart';
import 'package:arabas_app/features/practicals/presentation/bloc/practical_details_cubit.dart';
import 'package:arabas_app/features/practicals/presentation/bloc/practical_details_state.dart';
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
      bottomNavigationBar: Container(
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
              "التسجيل  في  الورشة ",
              style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
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
            // final cleanDescription = item.description
            //     .replaceAll('text-align: center;', '')
            //     .replaceAll('text-align:center;', '');

            return SingleChildScrollView(
              // padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// MAIN IMAGE
                  Stack(
                    children: [
                      Image.network(
                        item.imageUrl,
                        width: double.infinity,
                        height: 240.h,
                        fit: BoxFit.fill,
                        errorBuilder:
                            (context, error, stackTrace) => Container(
                              height: 240.h,
                              color: Colors.grey.shade300,
                              child: const Center(
                                child: Icon(Icons.broken_image, size: 50),
                              ),
                            ),
                      ),

                      Positioned(
                        top: 30.h,
                        width: 20.w,
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 12.w,
                            vertical: 4.h,
                          ),
                          width: 100.w,
                          height: 25.h,
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.circular(50.r),
                          ),
                          child: Center(
                            child: Text(
                              "ورشة عمل مباشرة",
                              style: TextStyle(
                                color: AppColors.white,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 20.h),

                  /// TITLE
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Text(
                      item.title,
                      style: TextStyle(
                        fontSize: 24.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                    ),
                  ),

                  SizedBox(height: 10.h),

                  /// DESCRIPTION HTML
                  ///
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),

                    child: Html(
                      data: item.description,
                      style: {
                        "body": Style(
                          margin: Margins.zero,
                          padding: HtmlPaddings.zero,
                          color: Color(0xFF514349),
                          textAlign: TextAlign.right,
                          direction: TextDirection.rtl,
                        ),

                        "p": Style(
                          textAlign: TextAlign.right,
                          direction: TextDirection.rtl,
                        ),

                        "h1": Style(
                          textAlign: TextAlign.right,
                          direction: TextDirection.rtl,
                        ),

                        "h2": Style(
                          textAlign: TextAlign.right,
                          direction: TextDirection.rtl,
                        ),

                        "h3": Style(
                          textAlign: TextAlign.right,
                          direction: TextDirection.rtl,
                        ),

                        "li": Style(
                          textAlign: TextAlign.right,
                          direction: TextDirection.rtl,
                        ),
                      },
                    ),
                  ),

                  SizedBox(height: 10.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),

                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        "تقدم هذه الورشة نجربة تعليمية فريدة تركز علي  الجوانب العلمية والتقنية. تم تصحيح المنهج ليناسب الطلاب  الطموحين  الذين يسعون للتميز في  مهاراتهم المهنية.",
                        style: TextStyle(
                          color: AppColors.textGray,
                          fontSize: 14.sp,
                        ),
                        textDirection: TextDirection.rtl,
                      ),
                    ),
                  ),
                  SizedBox(height: 10.h),

                  Container(
                    decoration: BoxDecoration(
                      color: Color(0xFFEDF4FF),
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border(
                        right: BorderSide(width: 4, color: Color(0xFF146A59)),
                      ),
                    ),

                    height: 100.h,
                    width: double.infinity,

                    margin: EdgeInsets.symmetric(horizontal: 16.w),
                    padding: EdgeInsets.symmetric(
                      horizontal: 24.w,
                      vertical: 24.w,
                    ),
                    child: Text(
                      "التعليم ليس مجرد تلقي معلومات, بل هو تجربة تفاعلية تغير طريقة تفكيرك.",
                      textDirection: TextDirection.rtl,
                      style: TextStyle(
                        color: Color(0xFF146A59),
                        fontSize: 16.sp,
                      ),
                    ),
                  ),

                  SizedBox(height: 30.h),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 24.w,
                      vertical: 24.h,
                    ),
                    margin: EdgeInsets.symmetric(horizontal: 16.w),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Column(
                              children: [
                                Text(
                                  "المدة  الزمنية",
                                  style: TextStyle(
                                    color: Color(0xFF514349),
                                    fontSize: 12.sp,
                                  ),
                                ),
                                SizedBox(height: 8.h),
                                Text(
                                  "${item.durationInHours} ساعة تدريبية",
                                  textDirection: TextDirection.rtl,
                                  style: TextStyle(
                                    color: AppColors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16.sp,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(width: 8.w),
                            Icon(Icons.schedule, color: AppColors.green),
                          ],
                        ),
                        SizedBox(height: 15.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,

                          children: [
                            Column(
                              children: [
                                Text(
                                  "المقاعد المتاحة",
                                  style: TextStyle(
                                    color: Color(0xFF514349),
                                    fontSize: 12.sp,
                                  ),
                                ),
                                SizedBox(height: 8.h),
                                Text(
                                  "${item.studentsCount} مقعد فقط",
                                  textDirection: TextDirection.rtl,
                                  style: TextStyle(
                                    color: AppColors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16.sp,
                                  ),
                                ),
                              ],
                            ),

                            SizedBox(width: 8.w),
                            Icon(Icons.people_alt, color: AppColors.green),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Container(
                    color: Color(0xFFEDF4FF),
                    padding: EdgeInsets.symmetric(horizontal: 24.h),

                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        SizedBox(height: 20.h),
                        Text(
                          "شهادة معتمدة",
                          textDirection: TextDirection.rtl,
                          style: TextStyle(
                            fontSize: 22.sp,
                            color: AppColors.primaryDark,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10.h),
                        Text(
                          "عند إتمامك للورشة بنجاح,ستحصل  علي  شهادة (Curator Professional) الموثقة, والتي تعزز  من  سيرتك  الذاتية وتثبت كفاءتك في  المخارات المكتسبة",
                          textDirection: TextDirection.rtl,
                          style: TextStyle(
                            color: Color(0xFF514349),
                            fontSize: 16.sp,
                          ),
                        ),
                        SizedBox(height: 10.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              "رقم  تسلسلي للتحقق ",
                              style: TextStyle(
                                color: AppColors.black,
                                fontSize: 14.sp,
                              ),
                            ),
                            SizedBox(width: 10.w),
                            Icon(
                              Icons.check_circle_outline_outlined,
                              color: AppColors.green,
                            ),
                          ],
                        ),
                        SizedBox(height: 10.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              "اعتماد من The Curator Academy",
                              style: TextStyle(
                                color: AppColors.black,
                                fontSize: 14.sp,
                              ),
                            ),
                            SizedBox(width: 10.w),
                            Icon(
                              Icons.check_circle_outline_outlined,
                              color: AppColors.green,
                            ),
                          ],
                        ),
                        SizedBox(height: 20.h),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16.r),
                            border: Border.all(
                              color: Colors.grey.shade200,
                              width: 1,
                            ),
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
                      ],
                    ),
                  ),

                  SizedBox(height: 20.h),

                  /// STUDENTS TITLE
                  if (item.students.isNotEmpty)
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          "طلابنا في الميدان",
                          style: TextStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold,
                            color: AppColors.black,
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
                        "لقطات من الدورات السابقة والتدريب العملي المكثف",
                        style: TextStyle(
                          fontSize: 14.sp,

                          color: Color(0xFF514349),
                        ),
                      ),
                    ),
                  ),

                  if (item.students.isNotEmpty) SizedBox(height: 15.h),

                  if (item.students.isNotEmpty)
                    Column(
                      children: List.generate(
                        item.students.length,
                        (index) => Padding(
                          padding: EdgeInsets.only(
                            left: 24.w,
                            right: 24.w,
                            bottom: 16.h,
                          ),
                          child: _studentImage(item.students[index].imageUrl),
                        ),
                      ),
                    ),

                  SizedBox(height: 15.h),

                  /// CERTIFICATE TITLE
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

Widget _studentImage(String imageUrl) {
  return Container(
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16.r),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.12),
          blurRadius: 12,
          spreadRadius: 1,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(16.r),
      child: Image.network(
        imageUrl,
        width: double.infinity,
        height: 200.h,
        fit: BoxFit.fill,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            width: double.infinity,
            height: 200.h,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: const Center(child: Icon(Icons.broken_image, size: 40)),
          );
        },
      ),
    ),
  );
}
