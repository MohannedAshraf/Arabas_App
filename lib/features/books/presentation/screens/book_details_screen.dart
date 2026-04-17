// ignore_for_file: deprecated_member_use

import 'package:arabas_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BookDetailsScreen extends StatefulWidget {
  final String title;
  final String category;
  final int price;
  final String image;
  final String doctor;

  const BookDetailsScreen({
    super.key,
    required this.title,
    required this.category,
    required this.price,
    required this.image,
    required this.doctor,
  });

  @override
  State<BookDetailsScreen> createState() => _BookDetailsScreenState();
}

class _BookDetailsScreenState extends State<BookDetailsScreen> {
  int quantity = 1;

  void increase() {
    setState(() {
      quantity++;
    });
  }

  void decrease() {
    if (quantity > 1) {
      setState(() {
        quantity--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final total = widget.price * quantity;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "تفاصيل الكتاب",
          style: TextStyle(
            color: AppColors.primary,
            fontSize: 22.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(color: AppColors.primary),
      ),

      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.w),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 50.w),
                height: 300.h,
                width: double.infinity,
                child: Center(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.r),
                      image: DecorationImage(
                        image: AssetImage(widget.image),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    widget.price.toString(),
                    style: TextStyle(
                      fontSize: 24.sp,
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    widget.title,
                    style: TextStyle(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    widget.category,
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    "تأليف: ${widget.doctor}",
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textGray,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.h),
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 15.w),
                    height: 70.h,
                    width: 110.w,
                    decoration: BoxDecoration(
                      color: Color(0xffF3F4F5),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.print,
                            color: AppColors.primary,
                            size: 24.sp,
                          ),
                          SizedBox(height: 8.h),
                          Text(
                            "طباعة 2024",
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: AppColors.textGray,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Container(
                    height: 70.h,
                    width: 110.w,
                    padding: EdgeInsets.symmetric(horizontal: 15.w),
                    decoration: BoxDecoration(
                      color: Color(0xffF3F4F5),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.language, color: AppColors.primary),
                          SizedBox(height: 8.h),
                          Text(
                            " العربية",
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: AppColors.textGray,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Container(
                    height: 70.h,
                    width: 110.w,
                    padding: EdgeInsets.symmetric(horizontal: 15.w),

                    decoration: BoxDecoration(
                      color: Color(0xffF3F4F5),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.book_outlined, color: AppColors.primary),
                          SizedBox(height: 8.h),
                          Text(
                            "420",
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: AppColors.textGray,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 25.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "الوصف",
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8.h),
              Text(
                "يعد هذا الكتاب المرجع الاساسي للأطباء والباحثسن في مهارات الفحص السريري، حيث يقدم شرحا مفصلا لكل جزء من أجزاء الفحص السريري، مع صور توضيحية عالية الجودة. يغطي الكتاب جميع جوانب الفحص السريري، بدءا من الفحص العام وحتى الفحوصات المتخصصة لكل جهاز في الجسم. كما يتضمن نصائح عملية وأمثلة سريرية تساعد الأطباء على تحسين مهاراتهم في التشخيص والعلاج.",
                style: TextStyle(
                  fontSize: 14.sp,
                  color: AppColors.black.withOpacity(0.8),
                ),
              ),
              SizedBox(height: 30.h),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.r),
                  color: Color(0xffE7E8E9),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    SizedBox(height: 20.h),
                    Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(50.r),
                          ),
                          child: Row(
                            children: [
                              IconButton(
                                onPressed: decrease,
                                icon: Icon(
                                  Icons.remove_circle,
                                  color: AppColors.primary,
                                  size: 28.sp,
                                ),
                              ),
                              Text(
                                quantity.toString(),
                                style: TextStyle(
                                  fontSize: 20.sp,
                                  color: AppColors.primary,
                                ),
                              ),
                              IconButton(
                                onPressed: increase,
                                icon: Icon(
                                  Icons.add_circle,
                                  color: AppColors.primary,
                                  size: 28.sp,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Spacer(),
                        Text(
                          "الكميةالمطلوبة",
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 30.h),
                    Text(
                      "كوبون الخصم",
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: AppColors.textGray,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 15.w),
                      height: 60.h,
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(15.r),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "تطبيق",
                            style: TextStyle(
                              fontSize: 16.sp,
                              color: AppColors.primary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "ادخل كود الخصم",
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: AppColors.textGray,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20.h),
                  ],
                ),
              ),
              SizedBox(height: 40.h),
              Container(
                padding: EdgeInsets.all(12.w),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      padding: EdgeInsets.symmetric(vertical: 14.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                    onPressed: () {},
                    child: Text(
                      "ادفع   $total ",
                      style: TextStyle(fontSize: 18.sp, color: Colors.white),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
      // Column(
      //   children: [
      //     Expanded(
      //       child: SingleChildScrollView(
      //         child: Column(
      //           children: [
      //             /// 📷 IMAGE
      //             SizedBox(
      //               height: 300.h,
      //               width: double.infinity,
      //               child: Image.asset(widget.image, fit: BoxFit.cover),
      //             ),

      //             SizedBox(height: 16.h),

      //             Padding(
      //               padding: EdgeInsets.symmetric(horizontal: 8.w),
      //               child: Column(
      //                 crossAxisAlignment: CrossAxisAlignment.end,
      //                 children: [
      //                   Text(
      //                     widget.title,
      //                     textAlign: TextAlign.right,
      //                     style: TextStyle(
      //                       fontSize: 24.sp,
      //                       fontWeight: FontWeight.bold,
      //                       color: AppColors.primary,
      //                     ),
      //                   ),

      //                   SizedBox(height: 8.h),

      //                   Text(
      //                     widget.category,
      //                     style: TextStyle(
      //                       fontSize: 18.sp,
      //                       color: AppColors.primaryDark,
      //                     ),
      //                   ),

      //                   SizedBox(height: 20.h),

      //                   Row(
      //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //                     children: [
      //                       Text(
      //                         "${widget.price}",
      //                         style: TextStyle(
      //                           fontSize: 22.sp,
      //                           color: Colors.green,
      //                           fontWeight: FontWeight.bold,
      //                         ),
      //                       ),

      //                       Row(
      //                         children: [
      //                           IconButton(
      //                             onPressed: decrease,
      //                             icon: Icon(
      //                               Icons.remove_circle,
      //                               color: Colors.red,
      //                               size: 28.sp,
      //                             ),
      //                           ),
      //                           Text(
      //                             quantity.toString(),
      //                             style: TextStyle(fontSize: 20.sp),
      //                           ),
      //                           IconButton(
      //                             onPressed: increase,
      //                             icon: Icon(
      //                               Icons.add_circle,
      //                               color: Colors.green,
      //                               size: 28.sp,
      //                             ),
      //                           ),
      //                         ],
      //                       ),
      //                     ],
      //                   ),
      //                 ],
      //               ),
      //             ),
      //           ],
      //         ),
      //       ),
      //     ),

      //     /// 💳 BUTTON
      //     Container(
      //       padding: EdgeInsets.all(12.w),
      //       child: SizedBox(
      //         width: double.infinity,
      //         child: ElevatedButton(
      //           style: ElevatedButton.styleFrom(
      //             backgroundColor: AppColors.primary,
      //             padding: EdgeInsets.symmetric(vertical: 14.h),
      //             shape: RoundedRectangleBorder(
      //               borderRadius: BorderRadius.circular(12.r),
      //             ),
      //           ),
      //           onPressed: () {},
      //           child: Text(
      //             "ادفع   $total ",
      //             style: TextStyle(fontSize: 18.sp, color: Colors.white),
      //           ),
      //         ),
      //       ),
      //     ),
      //     SizedBox(height: 40.h),
      //   ],
      // ),
    );
  }
}
