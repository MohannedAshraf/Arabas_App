// ignore_for_file: deprecated_member_use, unnecessary_to_list_in_spreads

import 'package:arabas_app/core/constants/app_images.dart';
import 'package:arabas_app/core/theme/app_colors.dart';
import 'package:arabas_app/features/books/presentation/screens/book_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MedicalBooksScreen extends StatelessWidget {
  const MedicalBooksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final books = [
      {
        "title": "أطلس تشريح جسم الإنسان",
        "category": "تشريح",
        "price": "350",
        "image": AppImages.book1,
        "doctor": "د. أحمد سامي",
      },
      {
        "title": "تشريح جراي",
        "category": "تشريح",
        "price": "400",
        "image": AppImages.book2,
        "doctor": "د. محمد علي",
      },
      {
        "title": "دليل الجراحة السريرية",
        "category": "جراحة",
        "price": "300",
        "image": AppImages.book3,
        "doctor": "د. كريم حسن",
      },
      {
        "title": "أساسيات الطب الباطني",
        "category": "باطنة",
        "price": "280",
        "image": AppImages.book4,
        "doctor": "د. محمود طارق",
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "الكتب الطبية",
          style: TextStyle(fontSize: 22.sp, color: AppColors.primary),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(color: AppColors.primary),
      ),

      // ⭐️ الصفحة كلها Scroll
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              SizedBox(height: 20.h),

              // 🔎 Search Bar
              Container(
                height: 60.h,
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                decoration: BoxDecoration(
                  color: const Color(0xffE1E3E4),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(Icons.mic_none_outlined),
                    Text(
                      "ابحث عن الكتب الطبية",
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: AppColors.textGray,
                      ),
                    ),
                    Icon(Icons.search_outlined),
                  ],
                ),
              ),

              SizedBox(height: 25.h),

              Text(
                "الاصدارات الجديدة",
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),

              SizedBox(height: 6.h),

              Text(
                "المؤلفات الطبية المختارة",
                style: TextStyle(
                  fontSize: 22.sp,
                  color: AppColors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),

              SizedBox(height: 20.h),

              ...books.map((book) {
                return _bookCard1(
                  title: book["title"]!,
                  category: book["category"]!,
                  price: book["price"]!,
                  image: book["image"]!,
                  bookDoctor: book["doctor"]!,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (_) => BookDetailsScreen(
                              title: book["title"]!,
                              category: book["category"]!,
                              price: int.parse(book["price"]!),
                              image: book["image"]!,
                              doctor: book["doctor"]!,
                            ),
                      ),
                    );
                  },
                );
              }).toList(),

              SizedBox(height: 40.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _bookCard1({
    required String title,
    required String category,
    required String price,
    required String image,
    required VoidCallback? onTap,
    required String bookDoctor,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 16.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24.r),
          boxShadow: [
            BoxShadow(color: Colors.black12.withOpacity(.05), blurRadius: 10),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 5.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      title,
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColors.black,
                      ),
                    ),

                    SizedBox(height: 10.h),

                    Text(
                      bookDoctor,
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: AppColors.textGray,
                      ),
                    ),

                    SizedBox(height: 20.h),

                    Text(
                      "$price جنيه",
                      style: TextStyle(
                        fontSize: 20.sp,
                        color: AppColors.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          height: 50.h,
                          width: 100.w,
                          margin: EdgeInsets.only(left: 8.w),
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: Center(
                            child: Text(
                              "أضف للسلة",
                              style: TextStyle(
                                color: AppColors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18.sp,
                              ),
                            ),
                          ),
                        ),
                        const Spacer(),
                        Container(
                          height: 50.h,

                          decoration: BoxDecoration(
                            color: Color(0xffCBE7F5),
                            borderRadius: BorderRadius.circular(50.r),
                          ),
                          child: Row(
                            children: [
                              IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.remove,
                                  color: Color(0xff4E6874),
                                  size: 18.sp,
                                ),
                              ),
                              Text(
                                "1",
                                style: TextStyle(
                                  fontSize: 20.sp,
                                  color: Color(0xff4E6874),
                                ),
                              ),
                              IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.add,
                                  color: Color(0xff4E6874),
                                  size: 18.sp,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(width: 15.w),
            Container(
              height: 200.h,
              width: 120.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(24.r),
                  bottomRight: Radius.circular(24.r),
                ),
                image: DecorationImage(
                  image: AssetImage(image),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
