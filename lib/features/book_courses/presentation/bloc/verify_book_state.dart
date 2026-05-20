part of 'verify_book_cubit.dart';

abstract class VerifyBookState {}

class VerifyBookInitial extends VerifyBookState {}

class VerifyBookLoading extends VerifyBookState {}

class VerifyBookSuccess extends VerifyBookState {}

class VerifyBookError extends VerifyBookState {
  final String message;

  VerifyBookError(this.message);
}
