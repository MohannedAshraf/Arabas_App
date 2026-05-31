import 'package:arabas_app/features/certificates/presentation/bloc/my_certificates_cubit.dart';
import 'package:arabas_app/features/certificates/presentation/bloc/my_certificates_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../config/di/di.dart';
import '../../../../core/theme/app_colors.dart';

class MyCertificatesScreen extends StatelessWidget {
  const MyCertificatesScreen({super.key});

  Future<void> openCertificate(String url) async {
    final Uri uri = Uri.parse(url);

    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<CertificateCubit>()..getCertificates(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "شهاداتي",
            style: TextStyle(color: AppColors.primary),
          ),
          centerTitle: true,
          leading: const BackButton(color: AppColors.primary),
        ),
        body: BlocBuilder<CertificateCubit, CertificateState>(
          builder: (context, state) {
            if (state is CertificateLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is CertificateError) {
              return Center(child: Text(state.message));
            }

            if (state is CertificateSuccess) {
              if (state.certificates.isEmpty) {
                return const Center(child: Text("لا توجد شهادات"));
              }

              return ListView.separated(
                padding: EdgeInsets.all(12.w),
                itemCount: state.certificates.length,
                separatorBuilder: (_, __) => SizedBox(height: 10.h),
                itemBuilder: (context, index) {
                  final cert = state.certificates[index];

                  return Container(
                    padding: EdgeInsets.all(12.w),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(color: AppColors.primaryLight),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          cert.courseName,
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary,
                          ),
                        ),

                        SizedBox(height: 8.h),

                        Align(
                          alignment: AlignmentDirectional.centerEnd,
                          child: Text(
                            "الدرجة: ${cert.scorePercentage}%",
                            textDirection: TextDirection.rtl,
                            style: TextStyle(
                              fontSize: 16.sp,
                              color: AppColors.textGray,
                            ),
                          ),
                        ),

                        SizedBox(height: 8.h),

                        Align(
                          alignment: AlignmentDirectional.centerEnd,
                          child: Text(
                            "رقم الشهادة: ${cert.certificateNumber}",
                            textDirection: TextDirection.rtl,
                            style: TextStyle(
                              fontSize: 16.sp,
                              color: AppColors.textGray,
                            ),
                          ),
                        ),

                        SizedBox(height: 15.h),

                        SizedBox(
                          width: double.infinity,
                          height: 50.h,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                            ),
                            onPressed: () {
                              openCertificate(cert.certificateUrl);
                              print(
                                "Opening certificate URL: ${cert.certificateUrl}",
                              );
                            },
                            child: Text(
                              "عرض الشهادة",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            }

            return const SizedBox();
          },
        ),
      ),
    );
  }
}
