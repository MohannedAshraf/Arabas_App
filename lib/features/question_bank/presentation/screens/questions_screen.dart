// ignore_for_file: must_be_immutable, deprecated_member_use

import 'package:arabas_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class QuestionsScreen extends StatefulWidget {
  final String section;

  const QuestionsScreen({super.key, required this.section});

  @override
  State<QuestionsScreen> createState() => _QuestionsScreenState();
}

class _QuestionsScreenState extends State<QuestionsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final List<String> types = ["اختياري", "صح وغلط", "مقالي"];

  final Map<String, Map<String, List<Map<String, dynamic>>>> data = {
    /// ================= القلب =================
    "قلب": {
      "صح وغلط": List.generate(
        5,
        (i) => {"q": "القلب يضخ الدم (س${i + 1})", "a": "صح"},
      ),
      "اختياري": List.generate(
        5,
        (i) => {
          "q": "عدد حجرات القلب؟ (س${i + 1})",
          "options": ["2", "3", "4", "5"],
          "a": "4",
        },
      ),
      "مقالي": List.generate(
        5,
        (i) => {
          "q": "كيف نحافظ على صحة القلب؟ (س${i + 1})",
          "a": "رياضة وغذاء صحي",
        },
      ),
    },

    /// ================= عيون =================
    "عيون": {
      "صح وغلط": List.generate(
        5,
        (i) => {"q": "الشبكية مسؤولة عن الرؤية (س${i + 1})", "a": "صح"},
      ),
      "اختياري": List.generate(
        5,
        (i) => {
          "q": "جزء مسؤول عن التركيز؟ (س${i + 1})",
          "options": ["القرنية", "الشبكية", "العدسة", "العصب"],
          "a": "العدسة",
        },
      ),
      "مقالي": List.generate(
        5,
        (i) => {"q": "كيف نحافظ على العين؟ (س${i + 1})", "a": "تقليل الشاشات"},
      ),
    },

    /// ================= ENT =================
    "أنف وأذن وحنجرة": {
      "صح وغلط": List.generate(
        5,
        (i) => {"q": "اللوزتين جزء من المناعة (س${i + 1})", "a": "صح"},
      ),
      "اختياري": List.generate(
        5,
        (i) => {
          "q": "عضو السمع هو؟ (س${i + 1})",
          "options": ["العين", "الأذن", "القلب", "الأنف"],
          "a": "الأذن",
        },
      ),
      "مقالي": List.generate(
        5,
        (i) => {"q": "ما أسباب التهاب الأذن؟ (س${i + 1})", "a": "عدوى"},
      ),
    },

    /// ================= أسنان =================
    "أسنان": {
      "صح وغلط": List.generate(
        5,
        (i) => {"q": "الفلورايد مفيد للأسنان (س${i + 1})", "a": "صح"},
      ),
      "اختياري": List.generate(
        5,
        (i) => {
          "q": "عدد الأسنان عند البالغ؟ (س${i + 1})",
          "options": ["20", "28", "32", "40"],
          "a": "32",
        },
      ),
      "مقالي": List.generate(
        5,
        (i) => {"q": "كيف نحمي الأسنان؟ (س${i + 1})", "a": "تنظيف يومي"},
      ),
    },

    /// ================= باطنة =================
    "باطنة": {
      "صح وغلط": List.generate(
        5,
        (i) => {"q": "الضغط مرض مزمن (س${i + 1})", "a": "صح"},
      ),
      "اختياري": List.generate(
        5,
        (i) => {
          "q": "السكري يؤثر على؟ (س${i + 1})",
          "options": ["العين", "الكلى", "الأعصاب", "كل ما سبق"],
          "a": "كل ما سبق",
        },
      ),
      "مقالي": List.generate(
        5,
        (i) => {"q": "ما هو السكري؟ (س${i + 1})", "a": "ارتفاع سكر الدم"},
      ),
    },

    /// ================= أطفال =================
    "أطفال": {
      "صح وغلط": List.generate(
        5,
        (i) => {"q": "التطعيمات مهمة (س${i + 1})", "a": "صح"},
      ),
      "اختياري": List.generate(
        5,
        (i) => {
          "q": "مدة الرضاعة الطبيعية؟ (س${i + 1})",
          "options": ["6 شهور", "سنة", "3", "يوم"],
          "a": "6 شهور",
        },
      ),
      "مقالي": List.generate(
        5,
        (i) => {"q": "أهمية التطعيم؟ (س${i + 1})", "a": "وقاية"},
      ),
    },

    /// ================= نساء وتوليد =================
    "نساء وتوليد": {
      "صح وغلط": List.generate(
        5,
        (i) => {"q": "حمض الفوليك مهم للحمل (س${i + 1})", "a": "صح"},
      ),
      "اختياري": List.generate(
        5,
        (i) => {
          "q": "مدة الحمل؟ (س${i + 1})",
          "options": ["9 شهور", "6", "12", "3"],
          "a": "9 شهور",
        },
      ),
      "مقالي": List.generate(
        5,
        (i) => {"q": "أهمية متابعة الحمل؟ (س${i + 1})", "a": "سلامة الأم"},
      ),
    },

    /// ================= عظام =================
    "عظام": {
      "صح وغلط": List.generate(
        5,
        (i) => {"q": "الجبس يعالج الكسور (س${i + 1})", "a": "صح"},
      ),
      "اختياري": List.generate(
        5,
        (i) => {
          "q": "أقوى عظمة؟ (س${i + 1})",
          "options": ["الفخذ", "الذراع", "الجمجمة", "اليد"],
          "a": "الفخذ",
        },
      ),
      "مقالي": List.generate(
        5,
        (i) => {"q": "علاج الكسور؟ (س${i + 1})", "a": "تثبيت"},
      ),
    },

    /// ================= مخ وأعصاب =================
    "مخ وأعصاب": {
      "صح وغلط": List.generate(
        5,
        (i) => {"q": "المخ يتحكم بالجسم (س${i + 1})", "a": "صح"},
      ),
      "اختياري": List.generate(
        5,
        (i) => {
          "q": "سبب الجلطة؟ (س${i + 1})",
          "options": ["نزيف", "انسداد", "هواء", "ماء"],
          "a": "انسداد",
        },
      ),
      "مقالي": List.generate(
        5,
        (i) => {"q": "أعراض الجلطة؟ (س${i + 1})", "a": "شلل مفاجئ"},
      ),
    },

    /// ================= جلدية =================
    "جلدية": {
      "صح وغلط": List.generate(
        5,
        (i) => {"q": "الشمس تؤذي الجلد (س${i + 1})", "a": "صح"},
      ),
      "اختياري": List.generate(
        5,
        (i) => {
          "q": "سبب حب الشباب؟ (س${i + 1})",
          "options": ["هرمونات", "كسر", "نزيف", "برد"],
          "a": "هرمونات",
        },
      ),
      "مقالي": List.generate(
        5,
        (i) => {"q": "الوقاية من الشمس؟ (س${i + 1})", "a": "واقي شمسي"},
      ),
    },

    /// ================= طوارئ =================
    "طوارئ": {
      "صح وغلط": List.generate(
        5,
        (i) => {"q": "النزيف الحاد خطر (س${i + 1})", "a": "صح"},
      ),
      "اختياري": List.generate(
        5,
        (i) => {
          "q": "CPR يعني؟ (س${i + 1})",
          "options": ["إنعاش قلبي", "تنفس", "دواء", "عملية"],
          "a": "إنعاش قلبي",
        },
      ),
      "مقالي": List.generate(
        5,
        (i) => {"q": "خطوات الإسعاف؟ (س${i + 1})", "a": "تأمين مجرى الهواء"},
      ),
    },

    /// ================= جراحة =================
    "جراحة عامة": {
      "صح وغلط": List.generate(
        5,
        (i) => {"q": "التخدير ضروري (س${i + 1})", "a": "صح"},
      ),
      "اختياري": List.generate(
        5,
        (i) => {
          "q": "الزائدة تقع؟ (س${i + 1})",
          "options": ["يمين أسفل", "يسار", "صدر", "ظهر"],
          "a": "يمين أسفل",
        },
      ),
      "مقالي": List.generate(
        5,
        (i) => {"q": "ما هو البطن الحاد؟ (س${i + 1})", "a": "ألم مفاجئ"},
      ),
    },
  };

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: types.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final currentType = types[_tabController.index];
    final questions = data[widget.section]?[currentType] ?? [];

    return Scaffold(
      backgroundColor: const Color(0xffF6F7FB),

      appBar: AppBar(
        title: Text(
          widget.section,
          style: TextStyle(
            color: AppColors.primary,
            fontSize: 22.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(color: AppColors.primary),

        bottom: TabBar(
          controller: _tabController,
          indicatorColor: AppColors.primary,
          labelColor: AppColors.primary,
          unselectedLabelColor: Colors.grey,
          onTap: (_) => setState(() {}),

          tabs: const [
            Tab(text: "اختياري"),
            Tab(text: "صح وغلط"),
            Tab(text: "مقالي"),
          ],
        ),
      ),

      body: ListView.builder(
        padding: EdgeInsets.all(12.w),
        itemCount: questions.length,
        itemBuilder: (context, index) {
          final q = questions[index];

          if (currentType == "اختياري") {
            return McqQuestionCard(q: q);
          }

          if (currentType == "صح وغلط") {
            return TrueFalseQuestionCard(q: q);
          }

          return EssayQuestionCard(q: q);
        },
      ),
    );
  }
}

class McqQuestionCard extends StatelessWidget {
  final Map<String, dynamic> q;

  const McqQuestionCard({super.key, required this.q});

  @override
  Widget build(BuildContext context) {
    int correctIndex = q["options"].indexOf(q["a"]);

    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Question
          Text(
            q["q"],
            style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
          ),

          SizedBox(height: 12.h),

          /// Options
          ...List.generate(q["options"].length, (i) {
            bool isCorrect = i == correctIndex;

            return Container(
              margin: EdgeInsets.only(bottom: 10.h),
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
              decoration: BoxDecoration(
                color:
                    isCorrect
                        ? AppColors.primary.withOpacity(0.1)
                        : Color(0xFFEDF4FF),
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(
                  color: isCorrect ? AppColors.primary : Colors.transparent,
                  width: 1.5,
                ),
              ),
              child: Row(
                children: [
                  /// Circle / Check
                  Container(
                    width: 20.w,
                    height: 20.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isCorrect ? AppColors.primary : Colors.transparent,
                      border: Border.all(
                        color: isCorrect ? AppColors.primary : Colors.grey,
                      ),
                    ),
                    child:
                        isCorrect
                            ? Icon(
                              Icons.check,
                              size: 14.sp,
                              color: Colors.white,
                            )
                            : null,
                  ),

                  SizedBox(width: 10.w),

                  /// Text
                  Expanded(
                    child: Text(
                      q["options"][i],
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: isCorrect ? AppColors.primary : Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}

class TrueFalseQuestionCard extends StatelessWidget {
  final Map<String, dynamic> q;

  const TrueFalseQuestionCard({super.key, required this.q});

  @override
  Widget build(BuildContext context) {
    List<String> options = ["صح", "غلط"];
    int correctIndex = options.indexOf(q["a"]);

    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// السؤال
          Text(
            q["q"],
            style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
          ),

          SizedBox(height: 12.h),

          /// الاختيارات (صح / غلط)
          ...List.generate(options.length, (i) {
            bool isCorrect = i == correctIndex;

            return Container(
              margin: EdgeInsets.only(bottom: 10.h),
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
              decoration: BoxDecoration(
                color:
                    isCorrect
                        ? AppColors.primary.withOpacity(0.1)
                        : const Color(0xFFEDF4FF),
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(
                  color: isCorrect ? AppColors.primary : Colors.transparent,
                  width: 1.5,
                ),
              ),
              child: Row(
                children: [
                  /// circle + check
                  Container(
                    width: 20.w,
                    height: 20.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isCorrect ? AppColors.primary : Colors.transparent,
                      border: Border.all(
                        color: isCorrect ? AppColors.primary : Colors.grey,
                      ),
                    ),
                    child:
                        isCorrect
                            ? Icon(
                              Icons.check,
                              size: 14.sp,
                              color: Colors.white,
                            )
                            : null,
                  ),

                  SizedBox(width: 10.w),

                  /// النص
                  Expanded(
                    child: Text(
                      options[i],
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: isCorrect ? AppColors.primary : Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}

class EssayQuestionCard extends StatelessWidget {
  final Map<String, dynamic> q;

  const EssayQuestionCard({super.key, required this.q});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// السؤال
          Text(
            q["q"],
            style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
          ),

          SizedBox(height: 12.h),

          /// بوكس الإجابة (نفس شكل الـ TextField)
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
            decoration: BoxDecoration(
              color: const Color(0xFFF8FAFC),
              borderRadius: BorderRadius.circular(14.r),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: Text(
              q["a"], // 👈 الإجابة بتظهر هنا
              style: TextStyle(
                fontSize: 14.sp,
                height: 1.5,
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
