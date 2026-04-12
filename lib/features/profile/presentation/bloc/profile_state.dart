import 'package:arabas_app/features/profile/domain/entities/profile_entity.dart';

abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileRefreshing extends ProfileState {}

class ProfileSuccess extends ProfileState {
  final ProfileEntity profile;
  ProfileSuccess(this.profile);
}

class ProfileSessionExpired extends ProfileState {
  final String message;
  ProfileSessionExpired(this.message);
}

class ProfileError extends ProfileState {
  final String message;
  ProfileError(this.message);
}
