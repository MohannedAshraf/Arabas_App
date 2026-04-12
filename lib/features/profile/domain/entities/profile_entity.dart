class ProfileEntity {
  final String id;
  final String fullName;
  final String email;
  final String phoneNumber;
  final String role;
  final String imageUrl;
  final List<String> phoneName;
  final List<String> platform;
  final int totalCourses;
  final int totalExamSolve;

  ProfileEntity({
    required this.id,
    required this.fullName,
    required this.email,
    required this.phoneNumber,
    required this.role,
    required this.imageUrl,
    required this.phoneName,
    required this.platform,
    required this.totalCourses,
    required this.totalExamSolve,
  });
}
