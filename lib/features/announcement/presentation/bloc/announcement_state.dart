import 'package:arabas_app/features/announcement/domain/entities/announcement_entity.dart';

abstract class AnnouncementState {}

class AnnouncementInitial extends AnnouncementState {}

class AnnouncementLoading extends AnnouncementState {}

class AnnouncementSuccess extends AnnouncementState {
  final List<AnnouncementEntity> announcements;

  AnnouncementSuccess(this.announcements);
}

class AnnouncementError extends AnnouncementState {
  final String error;

  AnnouncementError(this.error);
}
