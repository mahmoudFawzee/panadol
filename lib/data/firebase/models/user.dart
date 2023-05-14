import 'package:panadol/data/constants/constant.dart';

class MyUser {
  final String? profileImageUrl;
  final String firstName;
  final String lastName;
  final String learningGoal;
  final String studyingCategory;
  final String userId;
  MyUser({
    required this.profileImageUrl,
    required this.firstName,
    required this.lastName,
    required this.learningGoal,
    required this.studyingCategory,
    required this.userId,
  });

  Map<String, Object?> toFirestoreObj() {
    return {
      'userId': userId,
      'firstName': firstName,
      'lastName': lastName,
      'profileImage': profileImageUrl,
      'job': studyingCategory,
      'learningGoal': learningGoal,
    };
  }

  factory MyUser.fromFirebase(
    Map<String, dynamic>? firebaseUser,
  ) {
    String firstName = firebaseUser!['firstName'];
    String lastName = firebaseUser['lastName'];
    String userId = firebaseUser['userId'];
    String learningGoal = firebaseUser['learningGoal'];
    String profileImageUrl = firebaseUser['profileImage'] ?? noProfileImage;
    String job = firebaseUser['job'];

    return MyUser(
      firstName: firstName,
      lastName: lastName,
      userId: userId,
      learningGoal: learningGoal,
      studyingCategory: job,
      profileImageUrl: profileImageUrl,
    );
  }
}
