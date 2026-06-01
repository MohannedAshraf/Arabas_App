// ignore_for_file: file_names, deprecated_member_use

import 'package:arabas_app/config/di/di.dart';
import 'package:arabas_app/core/theme/app_colors.dart';
import 'package:arabas_app/features/question_bank/presentation/bloc/bank_questions_cubit.dart';
import 'package:arabas_app/features/question_bank/presentation/bloc/bank_questions_state.dart';
import 'package:arabas_app/features/question_bank/presentation/bloc/question_cubit.dart';
import 'package:arabas_app/features/question_bank/presentation/screens/questions_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BankQuestionsScreen extends StatefulWidget {
  const BankQuestionsScreen({super.key});

  @override
  State<BankQuestionsScreen> createState() => _BankQuestionsScreenState();
}

class _BankQuestionsScreenState extends State<BankQuestionsScreen> {
  @override
  void initState() {
    context.read<BankQuestionsCubit>().getSections();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "بنك الأسئلة",
          style: TextStyle(color: AppColors.primary),
        ),
      ),

      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 10, 16, 0),
            child: TextField(
              readOnly: true,
              decoration: InputDecoration(
                hintText: "ابحث عن قسم...",
                prefixIcon: const Icon(Icons.search, color: AppColors.primary),
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(vertical: 14),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: const BorderSide(color: Colors.black12),
                ),
              ),
            ),
          ),

          SizedBox(height: 20.h),

          Expanded(
            child: BlocBuilder<BankQuestionsCubit, BankQuestionsState>(
              builder: (context, state) {
                if (state is BankQuestionsLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (state is BankQuestionsError) {
                  return Center(child: Text(state.message));
                }

                if (state is BankQuestionsSuccess) {
                  return ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    itemCount: state.sections.length,
                    itemBuilder: (context, index) {
                      final section = state.sections[index];

                      return InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (_) => BlocProvider(
                                    create:
                                        (_) =>
                                            sl<QuestionsCubit>()..getQuestions(
                                              medicalSectionId: section.id,
                                              questionType: 1,
                                            ),
                                    child: QuestionsScreen(
                                      medicalSectionId: section.id,
                                      sectionName: section.nameAr,
                                    ),
                                  ),
                            ),
                          );
                        },
                        child: Container(
                          margin: EdgeInsets.only(top: 10.h),
                          child: Container(
                            width: double.infinity,
                            padding: EdgeInsets.fromLTRB(
                              18.w,
                              16.h,
                              18.w,
                              16.h,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xffE7EBF0),
                              borderRadius: BorderRadius.circular(26.r),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  section.nameAr,
                                  textAlign: TextAlign.right,
                                  textDirection: TextDirection.rtl,
                                  style: TextStyle(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.primary,
                                  ),
                                ),

                                SizedBox(height: 20.h),

                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    const Icon(
                                      Icons.arrow_back,
                                      color: AppColors.primary,
                                    ),
                                    SizedBox(width: 6.w),
                                    Text(
                                      "استعرض الأسئلة",
                                      style: TextStyle(
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.primary,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
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
