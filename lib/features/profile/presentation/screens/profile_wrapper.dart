import 'package:arabas_app/config/di/di.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/profile_cubit.dart';
import 'profile_screen.dart';

class ProfileWrapper extends StatelessWidget {
  const ProfileWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<ProfileCubit>()..getProfile(),
      child: const ProfileScreen(),
    );
  }
}
