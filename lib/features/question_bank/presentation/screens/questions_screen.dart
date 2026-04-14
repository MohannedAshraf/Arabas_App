// ignore_for_file: must_be_immutable, deprecated_member_use

import 'package:arabas_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class QuestionsScreen extends StatelessWidget {
  final String type;
  final String section;

  QuestionsScreen({super.key, required this.type, required this.section});

  /// 🔥 DATA FULL
  final Map<String, Map<String, List<Map<String, dynamic>>>> data = {
    /// ================= ENT =================
    "أنف وأذن وحنجرة": {
      "صح وغلط": [
        {"q": "اللوزتين جزء من الجهاز المناعي", "a": "صح"},
        {"q": "التهاب الأذن لا يسبب ألم", "a": "خطأ"},
        {"q": "الجيوب الأنفية في الجمجمة", "a": "صح"},
        {"q": "فقدان السمع دائم", "a": "خطأ"},
      ],
      "اختياري": [
        {
          "q": "عضو السمع هو؟",
          "options": ["العين", "الأذن", "القلب", "الأنف"],
          "a": "الأذن",
        },
        {
          "q": "سبب التهاب الحلق؟",
          "options": ["فيروس", "كسر", "حرق", "نزيف"],
          "a": "فيروس",
        },
        {
          "q": "احتقان الأنف يحدث بسبب؟",
          "options": ["حساسية", "كسر", "جلطة", "نزيف"],
          "a": "حساسية",
        },
        {
          "q": "طبلة الأذن مسؤولة عن؟",
          "options": ["الرؤية", "السمع", "الشم", "التذوق"],
          "a": "السمع",
        },
      ],
      "مقالي": [
        {"q": "اشرح وظيفة اللوزتين", "a": "جزء من الجهاز المناعي"},
        {"q": "ما أسباب التهاب الأذن؟", "a": "عدوى بكتيرية أو فيروسية"},
        {"q": "ما وظيفة الجيوب الأنفية؟", "a": "تخفيف وزن الجمجمة"},
        {"q": "كيف يتم علاج احتقان الأنف؟", "a": "باستخدام بخاخات وأدوية"},
      ],
    },

    /// ================= HEART =================
    "قلب": {
      "صح وغلط": [
        {"q": "القلب يضخ الدم", "a": "صح"},
        {"q": "الشرايين تحمل دم غير مؤكسج", "a": "خطأ"},
        {"q": "الجلطة تحدث بسبب انسداد", "a": "صح"},
        {"q": "القلب غير مهم", "a": "خطأ"},
      ],
      "اختياري": [
        {
          "q": "عدد حجرات القلب؟",
          "options": ["2", "3", "4", "5"],
          "a": "4",
        },
        {
          "q": "أكبر شريان في الجسم؟",
          "options": ["الأورطي", "الرئوي", "التاجي", "الوريد"],
          "a": "الأورطي",
        },
        {
          "q": "ضغط الدم الطبيعي؟",
          "options": ["120/80", "200/100", "50/30", "300/200"],
          "a": "120/80",
        },
        {
          "q": "معدل النبض الطبيعي؟",
          "options": ["60-100", "10-20", "200", "300"],
          "a": "60-100",
        },
      ],
      "مقالي": [
        {"q": "ما وظيفة القلب؟", "a": "ضخ الدم إلى الجسم"},
        {"q": "ما أسباب الجلطات؟", "a": "انسداد الأوعية الدموية"},
        {"q": "الفرق بين الشريان والوريد؟", "a": "الشريان يحمل دم مؤكسج"},
        {"q": "كيف نحافظ على صحة القلب؟", "a": "الرياضة والتغذية الصحية"},
      ],
    },

    /// ================= EYES =================
    "عيون": {
      "صح وغلط": [
        {"q": "الشبكية مسؤولة عن الرؤية", "a": "صح"},
        {"q": "المياه البيضاء مرض في القلب", "a": "خطأ"},
        {"q": "قصر النظر يعني رؤية القريب", "a": "صح"},
        {"q": "العمى دائم دائمًا", "a": "خطأ"},
      ],
      "اختياري": [
        {
          "q": "جزء مسؤول عن التركيز؟",
          "options": ["القرنية", "الشبكية", "العدسة", "العصب"],
          "a": "العدسة",
        },
        {
          "q": "قصر النظر يعني؟",
          "options": ["رؤية بعيد", "رؤية قريب", "عدم رؤية", "ألم"],
          "a": "رؤية قريب",
        },
        {
          "q": "مرض يصيب الشبكية؟",
          "options": ["سكري", "ضغط", "شبكية", "التهاب"],
          "a": "شبكية",
        },
        {
          "q": "العصب البصري وظيفته؟",
          "options": ["نقل الإشارة", "ضخ الدم", "الهضم", "التنفس"],
          "a": "نقل الإشارة",
        },
      ],
      "مقالي": [
        {"q": "اشرح وظيفة الشبكية", "a": "استقبال الضوء"},
        {"q": "ما هو قصر النظر؟", "a": "رؤية القريب بوضوح"},
        {"q": "أسباب ضعف النظر؟", "a": "وراثة أو إجهاد"},
        {"q": "كيف نحافظ على العين؟", "a": "راحة وتقليل الشاشات"},
      ],
    },

    /// ================= DENTAL =================
    "أسنان": {
      "صح وغلط": [
        {"q": "الأسنان تساعد في الهضم", "a": "صح"},
        {"q": "تسوس الأسنان غير مؤلم", "a": "خطأ"},
        {"q": "الفلورايد مفيد", "a": "صح"},
        {"q": "لا يجب تنظيف الأسنان", "a": "خطأ"},
      ],
      "اختياري": [
        {
          "q": "سبب التسوس؟",
          "options": ["بكتيريا", "هواء", "ماء", "ضوء"],
          "a": "بكتيريا",
        },
        {
          "q": "عدد الأسنان عند البالغ؟",
          "options": ["20", "28", "32", "40"],
          "a": "32",
        },
        {
          "q": "أفضل وقت للتنظيف؟",
          "options": ["مرة", "مرتين", "3", "لا"],
          "a": "مرتين",
        },
        {
          "q": "وظيفة الأسنان؟",
          "options": ["الهضم", "الرؤية", "السمع", "التنفس"],
          "a": "الهضم",
        },
      ],
      "مقالي": [
        {"q": "ما هو تسوس الأسنان؟", "a": "تآكل بسبب البكتيريا"},
        {"q": "كيف نحمي الأسنان؟", "a": "تنظيف مستمر"},
        {"q": "أهمية الفلورايد؟", "a": "تقوية الأسنان"},
        {"q": "أسباب ألم الأسنان؟", "a": "التسوس أو التهاب"},
      ],
    },
  };

  @override
  Widget build(BuildContext context) {
    final questions = data[section]?[type] ?? [];

    return Scaffold(
      backgroundColor: const Color(0xffF6F7FB),

      appBar: AppBar(
        title: Text(
          "$section - $type",
          style: TextStyle(
            color: AppColors.primary,
            fontSize: 22.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(color: AppColors.primary),
      ),

      body: ListView.builder(
        padding: EdgeInsets.all(12.w),
        itemCount: questions.length,
        itemBuilder: (context, index) {
          final q = questions[index];

          return Container(
            margin: EdgeInsets.only(bottom: 12.h),
            padding: EdgeInsets.all(14.w),
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(16.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12.withOpacity(.05),
                  blurRadius: 8,
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                /// السؤال
                Text(
                  q["q"],
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                SizedBox(height: 10.h),

                /// اختيارات
                if (q["options"] != null)
                  Column(
                    children: List.generate(
                      q["options"].length,
                      (i) => Container(
                        margin: EdgeInsets.only(bottom: 5.h),
                        padding: EdgeInsets.all(8.w),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            q["options"][i],
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                SizedBox(height: 5.h),

                /// الإجابة
                Text(
                  "الإجابة: ${q["a"]}",
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
