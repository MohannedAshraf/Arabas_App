import 'package:arabas_app/core/constants/app_images.dart';
import 'package:arabas_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AboutArabasScreen extends StatelessWidget {
  const AboutArabasScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF7F8FC),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          "المؤسسة العربية للتعليم والتدريب",
          style: TextStyle(
            color: AppColors.primary,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          children: [
            SizedBox(height: 20.h),

            /// CPD Badge
            Align(
              alignment: Alignment.bottomRight,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
                decoration: BoxDecoration(
                  color: const Color(0xffEFE7EE),
                  borderRadius: BorderRadius.circular(30.r),
                ),
                child: Text(
                  "ACCREDITED BY CPD - UK",
                  textDirection: TextDirection.ltr,
                  style: TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w600,
                    fontSize: 13.sp,
                  ),
                ),
              ),
            ),

            SizedBox(height: 25.h),

            /// ABOUT
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                "عن المؤسسة",
                style: TextStyle(
                  fontSize: 34.sp,
                  fontWeight: FontWeight.w900,
                  color: AppColors.black,
                ),
              ),
            ),

            Align(
              alignment: Alignment.centerRight,
              child: Text(
                "ARABAS",
                style: TextStyle(
                  color: AppColors.primary,
                  fontSize: 30.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            SizedBox(height: 20.h),

            Text(
              "تأسست المؤسسة العربية للتعليم والتدريب (ARABAS) في عام 2023 برؤية طموحة من الدكتور أحمد رفعت علي لتكون مناره تعليمية رائدة في  الوطن  العربي تجمع بين المعايير الأكاديمية العالمية والإحترافيه المهنية",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 15.sp, color: Colors.black87),
            ),

            SizedBox(height: 25.h),

            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: AppColors.white,
                  padding: EdgeInsets.symmetric(
                    horizontal: 24.w,
                    vertical: 14.h,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14.r),
                  ),
                ),
                child: Text(
                  "استكشف برامجنا",
                  style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),

            SizedBox(height: 12.h),

            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  foregroundColor: AppColors.primary,
                  padding: EdgeInsets.symmetric(
                    horizontal: 24.w,
                    vertical: 14.h,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14.r),
                    side: BorderSide(
                      color: const Color(0xFFD7E4F4),
                      width: 2.w,
                    ),
                  ),
                ),
                child: Text(
                  "تواصل معنا",
                  style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            SizedBox(height: 30.h),

            /// Founder Card
            // _FounderCard(),

            // SizedBox(height: 30.h),

            /// Vision
            _InfoCard(
              icon: Icons.remove_red_eye_outlined,
              title: "الرؤية",
              content:
                  "أن تكون المؤسسة الرائدة إقليمياً في تمكين الكوادر العربية من خلال تعليم وتدريب متميز يواكب التحولات العالمية في  المجالات الطبية والأكاديمية",
            ),

            SizedBox(height: 20.h),

            /// Mission
            _InfoCard(
              icon: Icons.flag_outlined,
              title: "الرسالة",
              content:
                  "تقديم برامج تعليمية وتدريبية عالية الجودة,ومعتمدة دولياً,تهدف إلي تطوير المهارات والقدرات التنافسية للأفراد والمؤسسات في العالم العربي ",
            ),

            SizedBox(height: 20.h),

            /// Goals
            _GoalsCard(),

            SizedBox(height: 30.h),

            /// Values
            _ValuesSection(),

            SizedBox(height: 30.h),

            /// Accreditation
            _AccreditationSection(),

            SizedBox(height: 30.h),
          ],
        ),
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String content;

  const _InfoCard({
    required this.icon,
    required this.title,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        color: const Color(0xffD7E4F4),
        borderRadius: BorderRadius.circular(24.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            height: 50.h,
            width: 50.w,
            decoration: BoxDecoration(
              color:
                  title == "الرسالة"
                      ? const Color(0xffA4F2DB)
                      : AppColors.primary,
              borderRadius: BorderRadius.circular(14.r),
            ),
            child: Icon(icon, color: Colors.white),
          ),

          SizedBox(height: 20.h),

          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 28.sp,
              color: AppColors.primary,
            ),
          ),

          SizedBox(height: 12.h),

          Text(
            content,
            textAlign: TextAlign.right,
            style: TextStyle(height: 1.8, fontSize: 14.sp),
          ),

          SizedBox(height: 18.h),

          Container(width: 90.w, height: 2.h, color: Colors.pink.shade100),
        ],
      ),
    );
  }
}

class _GoalsCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(28.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            width: 48.w,
            height: 48.h,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.track_changes, color: AppColors.primary),
          ),

          SizedBox(height: 25.h),

          Text(
            "الأهداف",
            style: TextStyle(
              color: AppColors.white,
              fontSize: 30.sp,
              fontWeight: FontWeight.bold,
            ),
          ),

          SizedBox(height: 20.h),

          _goal("تطوير مناهج تدريبية مبتكرة"),
          _goal("توسيع نطاق الاعتمادات الدولية"),
          _goal("بناء شراكات استراتيجية مع المؤسسات الطبية"),
        ],
      ),
    );
  }

  Widget _goal(String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 14.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            text,
            textAlign: TextAlign.right,
            style: const TextStyle(color: Colors.white),
          ),
          SizedBox(width: 8.w),
          const Icon(Icons.check_circle_outline, color: Colors.white, size: 18),
        ],
      ),
    );
  }
}

class _ValuesSection extends StatelessWidget {
  final values = [
    "الجودة",
    "الاحترافية",
    "الابتكار",
    "المصداقية",
    "المسؤولية",
    "التعلم المستمر",
    "التميز",
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "قيمنا الجوهرية",
          style: TextStyle(
            fontSize: 30.sp,
            fontWeight: FontWeight.bold,
            color: AppColors.black,
          ),
        ),
        SizedBox(height: 12.h),
        Text(
          textAlign: TextAlign.center,
          "نؤمن بأن المبادئ هي أساس النجاح المستدام, لذا نضع هذه القيم في قلب كل ما نقوم به",
          style: TextStyle(fontSize: 14.sp, color: AppColors.primary),
        ),

        SizedBox(height: 25.h),

        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: values.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 14.h,
            crossAxisSpacing: 14.w,
            childAspectRatio: 1.2,
          ),
          itemBuilder: (_, i) {
            return Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18.r),
              ),
              child: Center(
                child: Text(
                  values[i],
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14.sp,
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}

class _AccreditationSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(22.w),
      decoration: BoxDecoration(
        color: const Color(0xffDCEAFA),
        borderRadius: BorderRadius.circular(24.r),
      ),
      child: Column(
        children: [
          Text(
            "اعتمادات دولية نعتز بها",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 28.sp, fontWeight: FontWeight.bold),
          ),

          SizedBox(height: 16.h),

          Text(
            "نحن ملتزمون بتقديم أعلى مستويات التعليم والتدريب,لذا فإن برامجنا معتمدة من قبل CPD-UK(Continuing Professional Development) مما يضمن اعترافاً دولياً بشهاداتنا ومساراتنا التدريبية",
            textAlign: TextAlign.center,
          ),

          SizedBox(height: 25.h),

          Container(
            padding: EdgeInsets.all(14.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18.r),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    "CPD Certified",
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Image.asset(AppImages.aboutOrg, height: 55.h),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// class _FounderCard extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 420.h,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(28.r),
//         image: DecorationImage(
//           image: AssetImage(AppImages.aboutOrg),
//           fit: BoxFit.cover,
//         ),
//       ),
//       child: Align(
//         alignment: Alignment.bottomCenter,
//         child: Container(
//           margin: EdgeInsets.all(18.w),
//           padding: EdgeInsets.all(18.w),
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(18.r),
//           ),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Text(
//                 "د. أحمد رفعت عدلي",
//                 style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp),
//               ),
//               SizedBox(height: 6.h),
//               Text(
//                 "مؤسس ARABAS - 2023",
//                 style: TextStyle(color: Colors.grey, fontSize: 13.sp),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
