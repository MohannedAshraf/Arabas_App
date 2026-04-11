import '../../domain/entities/profile_entity.dart';

abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileSuccess extends ProfileState {
  final ProfileEntity profile;

  ProfileSuccess(this.profile);
}

class ProfileError extends ProfileState {
  final String message;

  ProfileError(this.message);
}
