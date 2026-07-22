import 'package:equatable/equatable.dart';

class MyDiplomaEntity extends Equatable {
  final String diplomaId;
  final String diplomaName;
  final String diplomaImage;
  final int daysRemaining;
  final double progressPercent;
  final String description;
  final String introVideoUrl;

  const MyDiplomaEntity({
    required this.diplomaId,
    required this.diplomaName,
    required this.diplomaImage,
    required this.daysRemaining,
    required this.progressPercent,
    required this.description,
    required this.introVideoUrl,
  });

  @override
  List<Object?> get props => [
    diplomaId,
    diplomaName,
    diplomaImage,
    daysRemaining,
    progressPercent,
    description,
    introVideoUrl,
  ];
}
