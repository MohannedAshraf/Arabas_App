// ignore_for_file: deprecated_member_use

import 'package:arabas_app/core/theme/app_colors.dart';
import 'package:arabas_app/features/question_bank/domain/entities/question_entity.dart';
import 'package:arabas_app/features/question_bank/presentation/bloc/question_cubit.dart';
import 'package:arabas_app/features/question_bank/presentation/bloc/question_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class QuestionsScreen extends StatefulWidget {
  final String medicalSectionId;
  final String sectionName;

  const QuestionsScreen({
    super.key,
    required this.medicalSectionId,
    required this.sectionName,
  });

  @override
  State<QuestionsScreen> createState() => _QuestionsScreenState();
}

class _QuestionsScreenState extends State<QuestionsScreen>
    with SingleTickerProviderStateMixin {
  late TabController controller;

  int currentType = 1;

  @override
  void initState() {
    super.initState();

    controller = TabController(length: 4, vsync: this);

    controller.addListener(() {
      if (!controller.indexIsChanging) return;

      currentType = controller.index + 1;

      context.read<QuestionsCubit>().getQuestions(
        medicalSectionId: widget.medicalSectionId,
        questionType: currentType,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,

        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.primary),
          onPressed: () => Navigator.pop(context),
        ),

        title: Text(
          "الأسئلة",
          style: TextStyle(
            color: AppColors.primary,
            fontSize: 22.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16.w),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: TabBar(
              controller: controller,
              labelColor: AppColors.white,
              unselectedLabelColor: AppColors.primary,

              indicator: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(12.r),
              ),

              tabs: const [
                Tab(text: "اختياري"),
                Tab(text: "مقالي"),
                Tab(text: "صح/خطأ"),
                Tab(text: "توصيل"),
              ],
            ),
          ),

          SizedBox(height: 20.h),

          Expanded(
            child: BlocBuilder<QuestionsCubit, QuestionsState>(
              builder: (context, state) {
                if (state is QuestionsLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (state is QuestionsError) {
                  return Center(child: Text(state.message));
                }

                if (state is QuestionsLoaded) {
                  if (state.questions.isEmpty) {
                    return const Center(child: Text("لا توجد أسئلة"));
                  }

                  return ListView.builder(
                    padding: EdgeInsets.all(16.w),
                    itemCount: state.questions.length,
                    itemBuilder: (context, index) {
                      final question = state.questions[index];

                      switch (question.questionType) {
                        case 1:
                          return _mcqWidget(question);

                        case 2:
                          return _essayWidget(question);

                        case 3:
                          return _trueFalseWidget(question);

                        case 4:
                          return _matchingWidget(question);

                        default:
                          return const SizedBox();
                      }
                    },
                  );
                }

                return const SizedBox();
              },
            ),
          ),
        ],
      ),
    );
  }
}

Widget _mcqWidget(QuestionEntity question) {
  return Container(
    margin: EdgeInsets.only(bottom: 16.h),
    padding: EdgeInsets.all(18.w),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20.r),
      boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 6.r)],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(question.questionText, textAlign: TextAlign.left),
        ),
        SizedBox(height: 20.h),

        ...question.mcqOptions!.map(
          (option) => Container(
            margin: EdgeInsets.only(bottom: 10.h),
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(
                color: option.isCorrect ? AppColors.primary : Colors.black12,
              ),
            ),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                option.optionText,
                style: TextStyle(
                  color: option.isCorrect ? AppColors.primary : AppColors.black,
                  fontWeight:
                      option.isCorrect ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _essayWidget(QuestionEntity question) {
  return Container(
    margin: EdgeInsets.only(bottom: 16.h),
    padding: EdgeInsets.all(18.w),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20.r),
      boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 6.r)],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(question.questionText, textAlign: TextAlign.left),
        ),

        SizedBox(height: 20.h),

        Container(
          width: double.infinity,
          padding: EdgeInsets.all(14.w),
          decoration: BoxDecoration(
            color: AppColors.primary.withOpacity(.1),
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Text(
            question.essayAnswerText ?? "",

            style: const TextStyle(color: AppColors.primary),
          ),
        ),
      ],
    ),
  );
}

Widget _trueFalseWidget(QuestionEntity question) {
  return Container(
    margin: EdgeInsets.only(bottom: 16.h),
    padding: EdgeInsets.all(18.w),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20.r),
      boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 6.r)],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(question.questionText, textAlign: TextAlign.left),
        ),

        SizedBox(height: 20.h),

        Row(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.all(12.w),
                decoration: BoxDecoration(
                  color:
                      question.isTrue == false
                          ? AppColors.primary
                          : Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Text(
                  "خطأ",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color:
                        question.isTrue == false ? Colors.white : Colors.black,
                  ),
                ),
              ),
            ),

            SizedBox(width: 10.w),

            Expanded(
              child: Container(
                padding: EdgeInsets.all(12.w),
                decoration: BoxDecoration(
                  color:
                      question.isTrue == true
                          ? AppColors.primary
                          : Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Text(
                  "صح",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color:
                        question.isTrue == true ? Colors.white : Colors.black,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget _matchingWidget(QuestionEntity question) {
  return Container(
    margin: EdgeInsets.only(bottom: 16.h),
    padding: EdgeInsets.all(18.w),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20.r),
      boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 6.r)],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(question.questionText, textAlign: TextAlign.left),
        ),

        SizedBox(height: 20.h),

        ...question.matchingPairs!.map(
          (pair) => Container(
            margin: EdgeInsets.only(bottom: 12.h),
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(14.r),
            ),
            child: Row(
              children: [
                Text(pair.leftItem, style: TextStyle(fontSize: 18.sp)),

                const Spacer(),

                const Icon(Icons.arrow_back, color: AppColors.primary),

                const Spacer(),

                Text(pair.rightItem, style: TextStyle(fontSize: 18.sp)),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}
