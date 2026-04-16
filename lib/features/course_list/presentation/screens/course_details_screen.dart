// ignore_for_file: deprecated_member_use, prefer_interpolation_to_compose_strings
import 'package:arabas_app/core/constants/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';

class CourseDetailsScreen extends StatelessWidget {
  final String courseName;
  final String categoryName;
  final String image;
  final String description;
  final String price;

  const CourseDetailsScreen({
    super.key,
    required this.courseName,
    required this.categoryName,
    required this.image,
    required this.description,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: Text(
          "الكورسات",
          style: TextStyle(
            color: AppColors.primary,
            fontWeight: FontWeight.bold,
            fontSize: 22.sp,
          ),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(color: AppColors.primary),
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              SizedBox(height: 20.h),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w),
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.r),
                  color: Color.fromARGB(255, 230, 238, 250),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    SizedBox(height: 15.h),
                    Container(
                      height: 28.h,
                      width: 105.w,
                      decoration: BoxDecoration(
                        color: Color(0xffA4F2DB),
                        borderRadius: BorderRadius.circular(50.r),
                      ),
                      child: Center(
                        child: Text(
                          "كورس معتمد",
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: Color(0xFF1E715F),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 25.h),
                    Text(
                      "التحليل المتقدم لصور",
                      style: TextStyle(
                        fontSize: 36.sp,
                        color: AppColors.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      " الأشعة المقطعية في",
                      style: TextStyle(
                        fontSize: 36.sp,
                        color: AppColors.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    Text(
                      " حالات الطوارئ",
                      style: TextStyle(
                        fontSize: 36.sp,
                        color: AppColors.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 20.h),

                    Text(
                      "دليل شامل للأطباء والممارسين في التعامل مع",
                      style: TextStyle(
                        fontSize: 18.sp,
                        color: AppColors.primaryDark,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "الحالات الحرجة من خلال تحليل دقيق وممنهج",
                      style: TextStyle(
                        fontSize: 18.sp,
                        color: AppColors.primaryDark,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "لصور الأشعة المقطعية",
                      style: TextStyle(
                        fontSize: 18.sp,
                        color: Color(0xff514349),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 20.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text("طالب", style: TextStyle(fontSize: 18)),
                        Text(" 1240", style: TextStyle(fontSize: 18.sp)),
                        SizedBox(width: 4.w),
                        Icon(
                          Icons.person,
                          size: 32.sp,
                          color: AppColors.greenDark,
                        ),
                        SizedBox(width: 15.w),
                        Text(
                          "ساعة من المحتوي",
                          style: TextStyle(
                            fontSize: 18.sp,
                            color: AppColors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(" 48", style: TextStyle(fontSize: 18.sp)),

                        SizedBox(width: 4.w),
                        Icon(
                          Icons.access_time,
                          color: AppColors.greenDark,
                          size: 32.sp,
                        ),
                      ],
                    ),
                    SizedBox(height: 20.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "  4.9 ",
                          style: TextStyle(
                            fontSize: 22.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Icon(
                          Icons.star_border_outlined,
                          size: 36.sp,
                          color: AppColors.greenDark,
                        ),
                      ],
                    ),
                    SizedBox(height: 20.h),
                    Container(
                      height: 150.h,
                      padding: EdgeInsets.all(8.h),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.r),
                        color: AppColors.white,
                        image: DecorationImage(
                          image: AssetImage(AppImages.xrays),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(height: 20.h),
                  ],
                ),
              ),
              SizedBox(height: 40.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "   ماذا ستتعلم في هذا الكورس؟",
                    textAlign: TextAlign.end,
                    style: TextStyle(
                      fontSize: 22.sp,
                      color: AppColors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.h),
              Text(
                "تحليل سريع ودقيق لصور الأشعة في حالات نزيف الدماغ",
                style: TextStyle(fontSize: 16.sp),
              ),
              Text(
                "التعرف علي الجلطات الرئوية وتصنيف حدتها",
                style: TextStyle(fontSize: 16.sp),
              ),
              Text(
                "اساسيات التعامل مع الاصابات المتعدده في البطن والحوض",
                style: TextStyle(fontSize: 16.sp),
              ),
              Text(
                "قراءة الكسور  المعقدة في العمود الفقري والمفاصل",
                style: TextStyle(fontSize: 16.sp),
              ),
              SizedBox(height: 50.h),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    padding: EdgeInsets.symmetric(vertical: 14.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14.r),
                    ),
                  ),
                  onPressed: () {},
                  child: Text(
                    "احجز   $price",
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
      //
      // Column(
      //   children: [
      //     /// صورة الكورس (ثلث الشاشة)
      //     Stack(
      //       children: [
      //         SizedBox(
      //           height: 0.33.sh,
      //           width: double.infinity,
      //           child: Image.asset(image, fit: BoxFit.cover),
      //         ),

      //         Positioned(
      //           top: 40.h,
      //           child: IconButton(
      //             onPressed: () => Navigator.pop(context),
      //             icon: Icon(
      //               Icons.arrow_back,
      //               color: AppColors.white,
      //               size: 28.sp,
      //             ),
      //           ),
      //         ),
      //       ],
      //     ),

      //     Expanded(
      //       child: Padding(
      //         padding: EdgeInsets.symmetric(horizontal: 8.w),
      //         child: Column(
      //           crossAxisAlignment: CrossAxisAlignment.end,
      //           children: [
      //             SizedBox(height: 8.h),

      //             /// اسم الكورس + اسم القسم
      //             Row(
      //               children: [
      //                 Text(
      //                   courseName,
      //                   textAlign: TextAlign.right,
      //                   style: TextStyle(
      //                     fontSize: 22.sp,
      //                     fontWeight: FontWeight.bold,
      //                     color: AppColors.primary,
      //                   ),
      //                 ),
      //                 const Spacer(),
      //                 Text(
      //                   categoryName,
      //                   style: TextStyle(
      //                     fontSize: 16.sp,
      //                     color: AppColors.textGray,
      //                     fontWeight: FontWeight.w600,
      //                   ),
      //                 ),
      //               ],
      //             ),

      //             SizedBox(height: 20.h),

      //             /// عنوان الوصف
      //             Text(
      //               "وصف الكورس",
      //               style: TextStyle(
      //                 fontSize: 18.sp,
      //                 fontWeight: FontWeight.bold,
      //                 color: AppColors.primaryDark,
      //               ),
      //             ),

      //             SizedBox(height: 8.h),

      //             /// الوصف
      //             Text(
      //               description +
      //                   " - هذا الكورس يشرح المفاهيم الطبية بشكل مبسط وشامل ويحتوي على أمثلة عملية وحالات حقيقية تساعدك على الفهم الكامل.",
      //               textAlign: TextAlign.right,
      //               style: TextStyle(
      //                 fontSize: 15.sp,
      //                 height: 1.6,
      //                 color: AppColors.textGray,
      //               ),
      //             ),

      //             const Spacer(),

      //             /// السعر + زر الحجز

      //             SizedBox(height: 15.h),
      //           ],
      //         ),
      //       ),
      //     ),
      //   ],
      // ),
    );
  }
}
