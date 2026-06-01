import 'package:arabas_app/config/di/di.dart';
import 'package:arabas_app/core/theme/app_colors.dart';
import 'package:arabas_app/features/diplomas/presentation/bloc/diploma_details_cubit.dart';
import 'package:arabas_app/features/diplomas/presentation/bloc/diplomas_cubit.dart';
import 'package:arabas_app/features/diplomas/presentation/bloc/diplomas_state.dart';
import 'package:arabas_app/features/diplomas/presentation/screens/diploma_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DiplomaScreen extends StatefulWidget {
  const DiplomaScreen({super.key});

  @override
  State<DiplomaScreen> createState() => _DiplomaScreenState();
}

class _DiplomaScreenState extends State<DiplomaScreen> {
  @override
  void initState() {
    context.read<DiplomaCubit>().getDiplomas();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.primary),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "الدبلومات",
          style: TextStyle(
            color: AppColors.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: BlocBuilder<DiplomaCubit, DiplomaState>(
        builder: (context, state) {
          if (state is DiplomaLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is DiplomaError) {
            return Center(child: Text(state.message));
          }

          if (state is DiplomaLoaded) {
            return ListView.builder(
              padding: EdgeInsets.all(16.w),
              itemCount: state.diplomas.length,
              itemBuilder: (context, index) {
                final diploma = state.diplomas[index];

                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (_) => BlocProvider(
                              create:
                                  (_) =>
                                      sl<DiplomaDetailsCubit>()
                                        ..getDiplomaDetails(diploma.id),
                              child: DiplomaDetailsScreen(
                                diplomaId: diploma.id,
                              ),
                            ),
                      ),
                    );
                  },
                  child: Container(
                    margin: EdgeInsets.only(bottom: 18.h),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20.r),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 8,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(20.r),
                          ),
                          child: Image.network(
                            diploma.imageUrl,
                            height: 220.h,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),

                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 10.w,
                            vertical: 10.h,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                diploma.title,
                                textDirection: TextDirection.ltr,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.primary,
                                ),
                              ),

                              SizedBox(height: 10.h),

                              Text(
                                diploma.description
                                    .replaceAll(RegExp(r'<[^>]*>'), ' ')
                                    .replaceAll('&nbsp;', ' ')
                                    .replaceAll(RegExp(r'\s+'), ' ')
                                    .trim(),
                                textDirection: TextDirection.rtl,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 13.sp,
                                  color: AppColors.textGray,
                                ),
                              ),

                              SizedBox(height: 10.h),

                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    "${diploma.priceInEGP} جنيه",
                                    textDirection: TextDirection.rtl,
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.primary,
                                    ),
                                  ),

                                  Spacer(),
                                  Icon(
                                    Icons.schedule,
                                    color: AppColors.primary,
                                    size: 18.sp,
                                  ),
                                  SizedBox(width: 5.w),
                                  Text(
                                    "${diploma.durationHours} ساعة",
                                    textDirection: TextDirection.rtl,
                                    style: TextStyle(fontSize: 13.sp),
                                  ),
                                ],
                              ),
                            ],
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
