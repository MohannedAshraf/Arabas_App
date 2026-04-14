// ignore_for_file: avoid_print, use_build_context_synchronously

import 'package:arabas_app/config/di/di.dart';
import 'package:arabas_app/core/helpers/device_helper.dart';
import 'package:arabas_app/core/theme/app_colors.dart';
import 'package:arabas_app/features/auth/data/models/register_model.dart';
import 'package:arabas_app/features/auth/presentation/bloc/login_cubit.dart';
import 'package:arabas_app/features/auth/presentation/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../bloc/register_cubit.dart';
import '../bloc/register_state.dart';

/// Regex
final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
final egyptPhoneRegex = RegExp(r'^01[0125][0-9]{8}$');
final passwordRegex = RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*[\W_]).{6,}$');

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  Future<void> register() async {
    if (!formKey.currentState!.validate()) return;

    final deviceId = await DeviceHelper.getDeviceId();
    final deviceName = await DeviceHelper.getDeviceName();
    final platform = DeviceHelper.getPlatform();

    final model = RegisterRequestModel(
      firstName: firstNameController.text.trim(),
      lastName: lastNameController.text.trim(),
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
      confirmPassword: confirmPasswordController.text.trim(),
      phoneNumber: phoneController.text.trim(),
      deviceId: deviceId,
      deviceName: deviceName,
      platform: platform,
      fingerprint: "",
    );
    print("deviceId: $deviceId");
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

            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder:
                    (_) => BlocProvider(
                      create: (_) => sl<LoginCubit>(),
                      child: const LoginScreen(),
                    ),
              ),
              (route) => false,
            );
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
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  SizedBox(height: 30.h),

                  Container(
                    padding: EdgeInsets.all(20.w),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24.r),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 20,
                          offset: Offset(0, 5),
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

                        /// First + Last name
                        Row(
                          children: [
                            Expanded(
                              child: AppTextField(
                                hint: "First Name",
                                controller: firstNameController,
                                validator:
                                    (v) =>
                                        v == null || v.isEmpty
                                            ? "Required"
                                            : null,
                              ),
                            ),
                            SizedBox(width: 10.w),
                            Expanded(
                              child: AppTextField(
                                hint: "Last Name",
                                controller: lastNameController,
                                validator:
                                    (v) =>
                                        v == null || v.isEmpty
                                            ? "Required"
                                            : null,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 15.h),

                        /// Email
                        AppTextField(
                          hint: "Email Address",
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          validator: (v) {
                            if (v == null || v.isEmpty) return "Email required";
                            if (!emailRegex.hasMatch(v)) return "Invalid email";
                            return null;
                          },
                        ),
                        SizedBox(height: 15.h),

                        /// Phone
                        AppTextField(
                          hint: "Phone Number",
                          controller: phoneController,
                          keyboardType: TextInputType.phone,
                          validator: (v) {
                            if (v == null || v.isEmpty) return "Phone required";
                            if (!egyptPhoneRegex.hasMatch(v)) {
                              return "Invalid Egyptian number";
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 15.h),

                        /// Password
                        AppTextField(
                          hint: "Password",
                          controller: passwordController,
                          isPassword: true,
                          validator: (v) {
                            if (v == null || v.isEmpty) return "Required";
                            if (!passwordRegex.hasMatch(v)) {
                              return "6+ chars, Upper, Lower, Symbol";
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 15.h),

                        /// Confirm Password
                        AppTextField(
                          hint: "Confirm Password",
                          controller: confirmPasswordController,
                          isPassword: true,
                          validator: (v) {
                            if (v != passwordController.text) {
                              return "Passwords do not match";
                            }
                            return null;
                          },
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
                        SizedBox(height: 20.h),

                        Row(
                          children: [
                            Text(
                              " have an account?   ",
                              style: TextStyle(
                                color: AppColors.textGray,
                                fontSize: 16.sp,
                              ),
                            ),
                            SizedBox(width: 50.w),
                            GestureDetector(
                              onTap: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder:
                                        (_) => BlocProvider(
                                          create: (_) => sl<LoginCubit>(),
                                          child: const LoginScreen(),
                                        ),
                                  ),
                                );
                              },
                              child: Text(
                                "Login",
                                style: TextStyle(
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.sp,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
