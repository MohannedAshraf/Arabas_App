import 'package:arabas_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BookDetailsScreen extends StatefulWidget {
  final String title;
  final String category;
  final int price;
  final String image;

  const BookDetailsScreen({
    super.key,
    required this.title,
    required this.category,
    required this.price,
    required this.image,
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

      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  /// 📷 IMAGE
                  SizedBox(
                    height: 300.h,
                    width: double.infinity,
                    child: Image.asset(widget.image, fit: BoxFit.cover),
                  ),

                  SizedBox(height: 16.h),

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          widget.title,
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            fontSize: 24.sp,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary,
                          ),
                        ),

                        SizedBox(height: 8.h),

                        Text(
                          widget.category,
                          style: TextStyle(
                            fontSize: 18.sp,
                            color: AppColors.primaryDark,
                          ),
                        ),

                        SizedBox(height: 20.h),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "${widget.price}",
                              style: TextStyle(
                                fontSize: 22.sp,
                                color: Colors.green,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            Row(
                              children: [
                                IconButton(
                                  onPressed: decrease,
                                  icon: Icon(
                                    Icons.remove_circle,
                                    color: Colors.red,
                                    size: 28.sp,
                                  ),
                                ),
                                Text(
                                  quantity.toString(),
                                  style: TextStyle(fontSize: 20.sp),
                                ),
                                IconButton(
                                  onPressed: increase,
                                  icon: Icon(
                                    Icons.add_circle,
                                    color: Colors.green,
                                    size: 28.sp,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          /// 💳 BUTTON
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
          SizedBox(height: 40.h),
        ],
      ),
    );
  }
}
