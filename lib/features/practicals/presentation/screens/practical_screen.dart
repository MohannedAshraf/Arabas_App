import 'package:arabas_app/config/di/di.dart';
import 'package:arabas_app/features/practicals/presentation/bloc/practical_cubit.dart';
import 'package:arabas_app/features/practicals/presentation/bloc/practical_details_cubit.dart';
import 'package:arabas_app/features/practicals/presentation/bloc/practical_state.dart';
import 'package:arabas_app/features/practicals/presentation/screens/practical_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';

class PracticalScreen extends StatefulWidget {
  const PracticalScreen({super.key});

  @override
  State<PracticalScreen> createState() => _PracticalScreenState();
}

class _PracticalScreenState extends State<PracticalScreen> {
  @override
  void initState() {
    context.read<PracticalCubit>().getPracticals();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "التدريب العملي",
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
            color: AppColors.primary,
          ),
        ),
        centerTitle: true,
        leading: BackButton(color: AppColors.primary),
      ),

      body: BlocBuilder<PracticalCubit, PracticalState>(
        builder: (context, state) {
          if (state is PracticalLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is PracticalError) {
            return Center(child: Text(state.message));
          }

          if (state is PracticalSuccess) {
            return ListView.builder(
              padding: EdgeInsets.all(16.w),
              itemCount: state.practicals.length,
              itemBuilder: (context, index) {
                final item = state.practicals[index];

                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (_) => BlocProvider(
                              create: (_) => sl<PracticalDetailsCubit>(),
                              child: PracticalDetailsScreen(id: item.id),
                            ),
                      ),
                    );
                  },
                  child: Container(
                    margin: EdgeInsets.only(bottom: 16.h),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20.r),
                      boxShadow: [
                        BoxShadow(blurRadius: 10, color: Colors.black12),
                      ],
                    ),
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(20.r),
                          ),
                          child: Image.network(
                            item.imageUrl,
                            height: 200.h,
                            width: double.infinity,
                            fit: BoxFit.cover,

                            errorBuilder: (context, error, stackTrace) {
                              debugPrint(error.toString());

                              return Container(
                                height: 200.h,
                                width: double.infinity,
                                color: Colors.grey.shade200,
                                child: const Icon(
                                  Icons.image_not_supported,
                                  size: 50,
                                ),
                              );
                            },

                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) {
                                return child;
                              }

                              return SizedBox(
                                height: 200.h,
                                child: const Center(
                                  child: CircularProgressIndicator(),
                                ),
                              );
                            },
                          ),
                        ),
                        SizedBox(height: 12.h),
                        Padding(
                          padding: EdgeInsets.only(left: 16.w, bottom: 10.h),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              item.title,
                              textDirection: TextDirection.ltr,
                              style: TextStyle(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.bold,
                                color: AppColors.primary,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }

          return const SizedBox();
        },
      ),
    );
  }
}
