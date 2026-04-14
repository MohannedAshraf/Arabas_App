// ignore_for_file: use_build_context_synchronously

import 'package:arabas_app/config/di/di.dart';
import 'package:arabas_app/core/helpers/device_helper.dart';
import 'package:arabas_app/features/auth/presentation/bloc/register_cubit.dart';
import 'package:arabas_app/features/auth/presentation/screens/register_screen.dart';
import 'package:arabas_app/features/home/presentation/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';
import '../bloc/login_cubit.dart';
import '../bloc/login_state.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  bool rememberMe = false;
  bool obscurePassword = true;

  /// validation helpers
  String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Email is required";
    }
    if (value.contains(" ")) {
      return "Email cannot contain spaces";
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return "Password is required";
    }
    if (value.contains(" ")) {
      return "Password cannot contain spaces";
    }
    if (value.length < 6) {
      return "Password must be at least 6 characters";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: BlocListener<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is LoginSuccess) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const HomeScreen()),
            );
          } else if (state is LoginFailure) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              width: size.width > 500 ? 400.w : size.width * 0.9,
              padding: EdgeInsets.all(20.w),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "The Curator",
                      style: TextStyle(
                        color: AppColors.primary,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    SizedBox(height: 10.h),

                    Text(
                      "Login",
                      style: TextStyle(
                        fontSize: 26.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    SizedBox(height: 20.h),

                    /// Email
                    Text("Email", style: TextStyle(fontSize: 14.sp)),
                    SizedBox(height: 6.h),

                    TextFormField(
                      controller: emailController,
                      validator: validateEmail,
                      decoration: _inputDecoration("name@example.com"),
                    ),

                    SizedBox(height: 16.h),

                    /// Password
                    Text("Password", style: TextStyle(fontSize: 12.sp)),

                    SizedBox(height: 6.h),

                    TextFormField(
                      controller: passwordController,
                      obscureText: obscurePassword,
                      validator: validatePassword,
                      decoration: _inputDecoration("********").copyWith(
                        suffixIcon: IconButton(
                          icon: Icon(
                            obscurePassword
                                ? Icons.visibility_off
                                : Icons.visibility,
                            size: 20.sp,
                          ),
                          onPressed: () {
                            setState(() {
                              obscurePassword = !obscurePassword;
                            });
                          },
                        ),
                      ),
                    ),

                    SizedBox(height: 12.h),

                    Row(
                      children: [
                        Checkbox(
                          value: rememberMe,
                          onChanged:
                              (value) => setState(() => rememberMe = value!),
                        ),
                        Text("Remember me", style: TextStyle(fontSize: 13.sp)),
                        SizedBox(width: 42.w),
                        Text(
                          "FORGOT PASSWORD?",
                          style: TextStyle(
                            color: AppColors.primary,
                            fontSize: 12.sp,
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 8.h),

                    BlocBuilder<LoginCubit, LoginState>(
                      builder: (context, state) {
                        if (state is LoginLoading) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }

                        return SizedBox(
                          width: double.infinity,
                          height: 50.h,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                            ),
                            onPressed: () async {
                              if (formKey.currentState!.validate()) {
                                final deviceId =
                                    await DeviceHelper.getDeviceId();
                                final platform = DeviceHelper.getPlatform();

                                context.read<LoginCubit>().login(
                                  email: emailController.text.trim(),
                                  password: passwordController.text.trim(),
                                  deviceId: deviceId,
                                  platform: platform,
                                );
                              }
                            },
                            child: Text(
                              "Login",
                              style: TextStyle(
                                color: AppColors.white,
                                fontSize: 16.sp,
                              ),
                            ),
                          ),
                        );
                      },
                    ),

                    SizedBox(height: 16.h),

                    Row(
                      children: [
                        Text(
                          "New to The Curator? ",
                          style: TextStyle(fontSize: 16.sp),
                        ),
                        SizedBox(width: 50.w),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (_) => BlocProvider(
                                      create: (_) => sl<RegisterCubit>(),
                                      child: const RegisterScreen(),
                                    ),
                              ),
                            );
                          },
                          child: Text(
                            "Sign Up",
                            style: TextStyle(
                              color: AppColors.primary,
                              fontWeight: FontWeight.w500,
                              fontSize: 16.sp,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: TextStyle(fontSize: 13.sp),
      filled: true,
      fillColor: const Color(0xffE6ECF2),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.r),
        borderSide: BorderSide.none,
      ),
    );
  }
}
