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
              labelColor: AppColors.primary,
              unselectedLabelColor: AppColors.primary,

              indicatorColor: AppColors.primary,
              indicatorWeight: 3,
              indicatorSize: TabBarIndicatorSize.label,

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
      borderRadius: BorderRadius.circular(24.r),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(.05),
          blurRadius: 10,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          question.questionText,
          style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w700),
        ),

        SizedBox(height: 24.h),

        ...question.mcqOptions!.map((option) {
          final isCorrect = option.isCorrect;

          return Container(
            margin: EdgeInsets.only(bottom: 12.h),
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 18.h),
            decoration: BoxDecoration(
              color: isCorrect ? const Color(0xffEAF5F1) : Colors.white,
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(
                color:
                    isCorrect ? const Color(0xff1F7A63) : Colors.grey.shade300,
                width: isCorrect ? 2 : 1,
              ),
            ),
            child: Row(
              children: [
                if (isCorrect)
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10.w,
                      vertical: 4.h,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xff1F7A63),
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Text(
                      "Correct",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 11.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                const Spacer(),

                Expanded(
                  flex: 4,
                  child: Text(
                    option.optionText,
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      fontSize: 18.sp,
                      color:
                          isCorrect ? const Color(0xff1F7A63) : Colors.black87,
                      fontWeight: isCorrect ? FontWeight.w700 : FontWeight.w500,
                    ),
                  ),
                ),

                SizedBox(width: 12.w),

                Container(
                  width: 28.w,
                  height: 28.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color:
                        isCorrect
                            ? const Color(0xff1F7A63)
                            : Colors.transparent,
                    border: Border.all(
                      color: isCorrect ? const Color(0xff1F7A63) : Colors.grey,
                      width: 2,
                    ),
                  ),
                  child:
                      isCorrect
                          ? Icon(Icons.check, size: 16.sp, color: Colors.white)
                          : null,
                ),
              ],
            ),
          );
        }),
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
  final bool isTrueAnswer = question.isTrue ?? false;

  return Container(
    margin: EdgeInsets.only(bottom: 16.h),
    padding: EdgeInsets.all(18.w),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(24.r),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(.05),
          blurRadius: 10,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          question.questionText,
          style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w700),
        ),

        SizedBox(height: 24.h),

        _trueFalseOption(text: "صح", isCorrect: isTrueAnswer),

        SizedBox(height: 12.h),

        _trueFalseOption(text: "خطأ", isCorrect: !isTrueAnswer),
      ],
    ),
  );
}

Widget _trueFalseOption({required String text, required bool isCorrect}) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 18.h),
    decoration: BoxDecoration(
      color: isCorrect ? const Color(0xffEAF5F1) : Colors.white,
      borderRadius: BorderRadius.circular(16.r),
      border: Border.all(
        color: isCorrect ? const Color(0xff1F7A63) : Colors.grey.shade300,
        width: isCorrect ? 2 : 1,
      ),
    ),
    child: Row(
      children: [
        if (isCorrect)
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
            decoration: BoxDecoration(
              color: const Color(0xff1F7A63),
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Text(
              "Correct",
              style: TextStyle(
                color: Colors.white,
                fontSize: 11.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

        const Spacer(),

        Text(
          text,
          style: TextStyle(
            fontSize: 18.sp,
            color: isCorrect ? const Color(0xff1F7A63) : Colors.black87,
            fontWeight: isCorrect ? FontWeight.w700 : FontWeight.w500,
          ),
        ),

        SizedBox(width: 12.w),

        Container(
          width: 28.w,
          height: 28.w,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isCorrect ? const Color(0xff1F7A63) : Colors.transparent,
            border: Border.all(
              color: isCorrect ? const Color(0xff1F7A63) : Colors.grey,
              width: 2,
            ),
          ),
          child:
              isCorrect
                  ? Icon(Icons.check, size: 16.sp, color: Colors.white)
                  : null,
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
      borderRadius: BorderRadius.circular(24.r),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(.05),
          blurRadius: 10,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// Header

        /// Question
        Text(
          question.questionText,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w700),
        ),

        SizedBox(height: 24.h),

        /// Pairs
        ...question.matchingPairs!.map(
          (pair) => Padding(
            padding: EdgeInsets.only(bottom: 14.h),
            child: Row(
              children: [
                /// Left Item
                Expanded(
                  child: Container(
                    height: 52.h,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16.r),
                      border: Border.all(color: Colors.grey.shade300),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primary.withOpacity(.15),
                          blurRadius: 3,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Text(
                      pair.leftItem,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),

                SizedBox(width: 16.w),

                /// Matching Icon
                Icon(
                  Icons.compare_arrows_rounded,
                  color: AppColors.primary,
                  size: 34.sp,
                ),

                SizedBox(width: 16.w),

                /// Right Item
                Expanded(
                  child: Container(
                    height: 52.h,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: const Color(0xffEAF1FB),
                      borderRadius: BorderRadius.circular(16.r),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: Text(
                      pair.rightItem,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}
