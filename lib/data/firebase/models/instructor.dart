class Instructor {
  final String name;
  final String profilePhoto;
  final double rating;
  final int numberOfStudents;
  final String description;

  Instructor({
    required this.name,
    required this.profilePhoto,
    required this.rating,
    required this.numberOfStudents,
    required this.description,
  });
  factory Instructor.fromFirebase({
    required Map<String, dynamic>? firebaseObj,
  }) {
    String name = firebaseObj!['name'];
    String profilePhoto = firebaseObj['profile photo'];
    double rating = firebaseObj['rate'];
    int numberOfStudents = firebaseObj['numberOfStudents'];
    String description = firebaseObj['description'];
    return Instructor(
      name: name,
      profilePhoto: profilePhoto,
      rating: rating,
      numberOfStudents: numberOfStudents,
      description: description,
    );
  }
}
