// ignore_for_file: deprecated_member_use

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
      },
      {
        "title": "تشريح جراي",
        "category": "تشريح",
        "price": "400",
        "image": AppImages.book2,
      },
      {
        "title": "دليل الجراحة السريرية",
        "category": "جراحة",
        "price": "300",
        "image": AppImages.book3,
      },
      {
        "title": "أساسيات الطب الباطني",
        "category": "باطنة",
        "price": "280",
        "image": AppImages.book4,
      },
      {
        "title": "أساسيات طب الأطفال",
        "category": "أطفال",
        "price": "260",
        "image": AppImages.book1,
      },
      {
        "title": "دليل أمراض القلب",
        "category": "قلب",
        "price": "320",
        "image": AppImages.book2,
      },
      {
        "title": "مراجعة علم الأدوية",
        "category": "أدوية",
        "price": "240",
        "image": AppImages.book3,
      },
      {
        "title": "تبسيط علم الأعصاب",
        "category": "مخ وأعصاب",
        "price": "310",
        "image": AppImages.book4,
      },
      {
        "title": "دليل الأمراض الجلدية",
        "category": "جلدية",
        "price": "220",
        "image": AppImages.book1,
      },
      {
        "title": "طب الطوارئ",
        "category": "طوارئ",
        "price": "330",
        "image": AppImages.book2,
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

      body: ListView.builder(
        padding: EdgeInsets.only(top: 12.h),
        itemCount: books.length,
        itemBuilder: (context, index) {
          final book = books[index];

          return _bookCard(
            title: book["title"]!,
            category: book["category"]!,
            price: book["price"]!,
            image: book["image"]!,
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
                      ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _bookCard({
    required String title,
    required String category,
    required String price,
    required String image,
    required VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 12.h, left: 8.w, right: 8.w),
        padding: EdgeInsets.all(10.w),
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
                image,
                height: 80.h,
                width: 100.w,
                fit: BoxFit.cover,
              ),
            ),

            SizedBox(width: 12.w),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: Text(
                      title,
                      textAlign: TextAlign.right,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                    ),
                  ),

                  SizedBox(height: 6.h),

                  Text(
                    price,
                    style: TextStyle(
                      fontSize: 15.sp,
                      color: Colors.green,
                      fontWeight: FontWeight.w600,
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
}
