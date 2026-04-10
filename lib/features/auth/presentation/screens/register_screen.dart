// ignore_for_file: avoid_print, use_build_context_synchronously

import 'package:arabas_app/core/helpers/device_helper.dart';
import 'package:arabas_app/core/theme/app_colors.dart';
import 'package:arabas_app/features/auth/data/models/register_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../bloc/register_cubit.dart';
import '../bloc/register_state.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  Future<void> register() async {
    /// التأكد ان الباسوردين متطابقين
    if (passwordController.text != confirmPasswordController.text) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Passwords do not match")));
      return;
    }

    /// جلب بيانات الجهاز الحقيقية
    final deviceId = await DeviceHelper.getDeviceId();
    final deviceName = await DeviceHelper.getDeviceName();
    final platform = DeviceHelper.getPlatform();

    /// تقسيم الاسم
    final fullNameParts = fullNameController.text.trim().split(" ");
    final firstName = fullNameParts.first;
    final lastName = fullNameParts.length > 1 ? fullNameParts.last : "";

    final model = RegisterRequestModel(
      firstName: firstName,
      lastName: lastName,
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
      confirmPassword: confirmPasswordController.text.trim(),
      phoneNumber: phoneController.text.trim(),
      deviceId: deviceId,

      deviceName: deviceName,
      platform: platform,
    );
    print("Device ID: $deviceId");
    context.read<RegisterCubit>().register(model);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Text(
          "Register",
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),

      body: BlocListener<RegisterCubit, RegisterState>(
        listener: (context, state) {
          if (state is RegisterSuccess) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }

          if (state is RegisterError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.error)));
          }
        },
        child: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              children: [
                SizedBox(height: 20.h),

                SizedBox(height: 30.h),

                /// Card
                Container(
                  padding: EdgeInsets.all(20.w),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24.r),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 20,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Create your account",
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        "Access our curated gallery of knowledge and expertise.",
                        style: TextStyle(
                          color: AppColors.textGray,
                          fontSize: 13.sp,
                        ),
                      ),

                      SizedBox(height: 25.h),

                      AppTextField(
                        hint: "Full Name",
                        controller: fullNameController,
                      ),
                      SizedBox(height: 15.h),

                      AppTextField(
                        hint: "Email Address",
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                      ),
                      SizedBox(height: 15.h),

                      AppTextField(
                        hint: "Phone Number",
                        controller: phoneController,
                        keyboardType: TextInputType.phone,
                      ),
                      SizedBox(height: 15.h),

                      /// Password
                      AppTextField(
                        hint: "Password",
                        controller: passwordController,
                        isPassword: true,
                      ),
                      SizedBox(height: 15.h),

                      /// Confirm Password
                      AppTextField(
                        hint: "Confirm Password",
                        controller: confirmPasswordController,
                        isPassword: true,
                      ),

                      SizedBox(height: 20.h),

                      Text.rich(
                        TextSpan(
                          text: "By joining, you agree to our ",
                          style: TextStyle(
                            color: AppColors.textGray,
                            fontSize: 12.sp,
                          ),
                          children: [
                            TextSpan(
                              text: "Terms of Service",
                              style: TextStyle(color: AppColors.green),
                            ),
                            const TextSpan(text: " and "),
                            TextSpan(
                              text: "Privacy Policy",
                              style: TextStyle(color: AppColors.green),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 25.h),

                      BlocBuilder<RegisterCubit, RegisterState>(
                        builder: (context, state) {
                          return AppButton(
                            text: "Create account",
                            isLoading: state is RegisterLoading,
                            onTap: register,
                          );
                        },
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 20.h),

                Text.rich(
                  TextSpan(
                    text: "Already have an account? ",
                    style: TextStyle(color: AppColors.textGray),
                    children: const [
                      TextSpan(
                        text: "Login",
                        style: TextStyle(
                          color: AppColors.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 30.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
