// ignore_for_file: deprecated_member_use

import 'package:arabas_app/config/di/di.dart';
import 'package:arabas_app/core/theme/app_colors.dart';
import 'package:arabas_app/features/certificates/presentation/bloc/my_certificates_cubit.dart';
import 'package:arabas_app/features/certificates/presentation/bloc/my_certificates_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class MyCertificatesScreen extends StatelessWidget {
  const MyCertificatesScreen({super.key});

  Future<void> openCertificate(String url) async {
    final uri = Uri.parse(url);

    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  void showQrDialog(BuildContext context, String verificationUrl) {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.r),
          ),
          title: const Center(
            child: Text(
              "QR Verification",
              style: TextStyle(color: AppColors.primary),
            ),
          ),
          content: SizedBox(
            width: 250.w,
            height: 250.h,
            child: QrImageView(data: verificationUrl, version: QrVersions.auto),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<CertificateCubit>()..getCertificates(),
      child: Scaffold(
        backgroundColor: const Color(0xffF7F8FC),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          title: const Text(
            "شهاداتي",
            style: TextStyle(
              color: AppColors.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
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

              return ListView.builder(
                padding: EdgeInsets.all(16.w),
                itemCount: state.certificates.length,
                itemBuilder: (context, index) {
                  final cert = state.certificates[index];

                  return Container(
                    margin: EdgeInsets.only(bottom: 18.h),
                    padding: EdgeInsets.all(18.w),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24.r),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(.05),
                          blurRadius: 15,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 12.w,
                                      vertical: 4.h,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.green.shade50,
                                      borderRadius: BorderRadius.circular(8.r),
                                    ),
                                    child: Text(
                                      "مكتمل",
                                      style: TextStyle(
                                        color: Colors.green,
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),

                                  SizedBox(height: 10.h),

                                  Text(
                                    cert.courseName,
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      color: AppColors.primary,
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),

                                  SizedBox(height: 10.h),

                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        cert.studentName,
                                        style: TextStyle(
                                          fontSize: 14.sp,
                                          color: AppColors.textGray,
                                        ),
                                      ),
                                      SizedBox(width: 5.w),
                                      Icon(
                                        Icons.person_outline,
                                        size: 18.sp,
                                        color: AppColors.textGray,
                                      ),
                                    ],
                                  ),

                                  SizedBox(height: 8.h),

                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        "تم إكمال ${cert.totalVideo} فيديوهات",
                                        style: TextStyle(
                                          fontSize: 13.sp,
                                          color: AppColors.textGray,
                                        ),
                                      ),
                                      SizedBox(width: 5.w),
                                      Icon(
                                        Icons.ondemand_video_outlined,
                                        size: 18.sp,
                                        color: AppColors.textGray,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: 12.w),

                            Stack(
                              clipBehavior: Clip.none,
                              children: [
                                Container(
                                  width: 90.w,
                                  height: 90.h,
                                  decoration: BoxDecoration(
                                    color: const Color(0xffF5EEF3),
                                    borderRadius: BorderRadius.circular(18.r),
                                  ),
                                  child: Icon(
                                    Icons.workspace_premium_outlined,
                                    color: AppColors.primary,
                                    size: 45.sp,
                                  ),
                                ),

                                Positioned(
                                  top: 80.h,
                                  right: 4.w,
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 8.w,
                                      vertical: 4.h,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.green,
                                      borderRadius: BorderRadius.circular(10.r),
                                    ),
                                    child: Text(
                                      "${cert.scorePercentage}%",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            SizedBox(width: 12.w),
                          ],
                        ),

                        SizedBox(height: 20.h),

                        Divider(color: Colors.grey.shade200),

                        SizedBox(height: 15.h),

                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(
                            horizontal: 16.w,
                            vertical: 12.h,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xffF2F3FC),
                            borderRadius: BorderRadius.circular(16.r),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  cert.certificateNumber,
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    color: AppColors.primary,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15.sp,
                                  ),
                                ),
                              ),

                              Text(
                                "رقم التحقق",
                                style: TextStyle(
                                  color: AppColors.textGray,
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20.h),

                        Row(
                          children: [
                            Expanded(
                              child: SizedBox(
                                height: 55.h,
                                child: OutlinedButton.icon(
                                  style: OutlinedButton.styleFrom(
                                    backgroundColor: const Color(0xffEEF1F6),
                                    side: BorderSide.none,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.r),
                                    ),
                                  ),
                                  onPressed: () {
                                    showQrDialog(context, cert.verificationUrl);
                                  },
                                  icon: const Icon(
                                    Icons.qr_code,
                                    color: AppColors.primary,
                                  ),
                                  label: Text(
                                    "عرض QR",
                                    textDirection: TextDirection.rtl,
                                    style: TextStyle(
                                      color: AppColors.primary,
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),

                            SizedBox(width: 12.w),

                            Expanded(
                              child: SizedBox(
                                height: 55.h,
                                child: ElevatedButton.icon(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.primary,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.r),
                                    ),
                                  ),
                                  onPressed: () {
                                    openCertificate(cert.certificateUrl);
                                  },
                                  icon: const Icon(
                                    Icons.download_outlined,
                                    color: Colors.white,
                                  ),
                                  label: Text(
                                    "تحميل الشهادة",
                                    textDirection: TextDirection.rtl,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
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
