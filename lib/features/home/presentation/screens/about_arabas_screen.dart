// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';

class AboutArabasScreen extends StatelessWidget {
  const AboutArabasScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: AppColors.primary,
            size: 20.sp,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'عن المؤسسة',
          style: TextStyle(
            color: AppColors.primary,
            fontSize: 20.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _sectionCard(
              icon: Icons.business,
              title: 'عن المؤسسة',

              content:
                  'المؤسسة العربية للتعليم والتدريب (ARABAS) هي مؤسسة تعليمية وتدريبية عربية تأسست في جمهورية مصر العربية عام 2023 على يد د. أحمد رفعت عدلي، استشاري أطفال الأنابيب والعقم ورئيس المؤسسة، انطلاقًا من إيمان راسخ بأهمية التعليم والتدريب المستمر في بناء الكفاءات البشرية وصناعة مستقبل أكثر تطورًا وابتكارًا.\n\n'
                  'تأسست المؤسسة بهدف توفير بيئة تعليمية وتدريبية متكاملة تجمع بين المعرفة الأكاديمية والخبرة العملية، وتسهم في إعداد وتأهيل الأفراد والمؤسسات لمواكبة المتغيرات المتسارعة في مختلف المجالات المهنية والعلمية.\n\n'
                  'وتفخر المؤسسة العربية بحصولها على اعتماد من CPD - UK، إحدى الجهات الدولية الرائدة في اعتماد برامج التطوير المهني المستمر، وهو ما يعكس التزام المؤسسة بتطبيق معايير الجودة العالمية وتقديم محتوى تدريبي موثوق يلبي احتياجات الأفراد والمؤسسات.\n\n'
                  'تقدم المؤسسة برامج تدريبية وورش عمل ومؤتمرات علمية ودورات مهنية متخصصة تستهدف العاملين في القطاع الصحي، إضافة إلى الطلاب والخريجين والباحثين عن التطوير المهني واكتساب المهارات الحديثة المطلوبة في سوق العمل.\n\n'
                  'كما تؤمن المؤسسة بأهمية التحول الرقمي وتوظيف التقنيات الحديثة والذكاء الاصطناعي في العملية التعليمية، وتسعى إلى تقديم تجربة تعلم مرنة ومتطورة تتيح الوصول إلى المعرفة والتدريب بجودة عالية داخل مصر وخارجها.\n\n'
                  'ومن خلال شبكة من الخبراء والأكاديميين والمتخصصين، تواصل المؤسسة العمل على بناء شراكات استراتيجية مع الجهات العلمية والتدريبية محليًا وإقليميًا ودوليًا.',
            ),

            SizedBox(height: 16.h),

            _sectionCard(
              icon: Icons.visibility_outlined,
              title: 'رؤيتنا',
              content:
                  'أن نكون من المؤسسات العربية الرائدة في التعليم والتدريب والتطوير المهني، وأن نُسهم في بناء مجتمع معرفي قادر على المنافسة والابتكار على المستويين الإقليمي والدولي.',
            ),

            SizedBox(height: 16.h),

            _sectionCard(
              icon: Icons.flag_outlined,
              title: 'رسالتنا',
              content:
                  'تقديم برامج تعليمية وتدريبية متميزة وفق المعايير الدولية، تسهم في تطوير المهارات وبناء القدرات وتعزيز ثقافة التعلم المستمر لدى الأفراد والمؤسسات.',
            ),

            SizedBox(height: 16.h),

            _sectionCard(
              icon: Icons.track_changes_outlined,
              title: 'أهدافنا',
              content:
                  '• نشر ثقافة التعلم والتطوير المهني المستمر.\n\n'
                  '• تقديم برامج تدريبية عالية الجودة وفق المعايير الدولية.\n\n'
                  '• دعم التحول الرقمي واستخدام التقنيات الحديثة في التعليم.\n\n'
                  '• بناء شراكات استراتيجية مع المؤسسات الأكاديمية والمهنية.\n\n'
                  '• المساهمة في إعداد كوادر مؤهلة قادرة على المنافسة في سوق العمل المحلي والعالمي.',
            ),

            SizedBox(height: 16.h),

            _sectionCard(
              icon: Icons.workspace_premium_outlined,
              title: 'قيمنا',
              content:
                  'الجودة – الاحترافية – الابتكار – المصداقية – المسؤولية – التعلم المستمر – التميز',
            ),

            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }

  Widget _sectionCard({
    required IconData icon,
    required String title,
    required String content,
  }) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(18.r),
        border: Border.all(color: AppColors.primary.withOpacity(0.15)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 20.r,
                backgroundColor: AppColors.primary.withOpacity(0.1),
                child: Icon(icon, color: AppColors.primary, size: 22.sp),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Text(
                  title,
                  textDirection: TextDirection.rtl,
                  style: TextStyle(
                    color: AppColors.primary,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 14.h),
          Text(
            content,
            textDirection: TextDirection.rtl,
            style: TextStyle(
              fontSize: 14.sp,
              height: 1.8,
              color: AppColors.black.withOpacity(0.8),
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
