import 'package:panadol/data/constants/enums.dart';
import 'package:panadol/data/firebase/models/learning_material.dart';

class Book extends LearningMaterial {
  final String bookUrl;
  const Book({
    required String name,
    required this.bookUrl,
    required String category,
    required String instructorName,
    required String bookCoverPath,
    required int numberOfRatings,
    required double rating,
    required LearningMaterialType learningMaterialType,
  }) : super(
          name: name,
          category: category,
          instructorName: instructorName,
          courseImagePath: bookCoverPath,
          materialType: learningMaterialType,
          numberOfRating: numberOfRatings,
          rating: rating,
        );

  factory Book.fromFirebase(
    {required Map<String, dynamic>? firebaseObj,}
  ) {
    String name = firebaseObj!['name'];
    String bookUrl = firebaseObj['bookUrl'];
    String type = firebaseObj['materialType'];
    LearningMaterialType learningMaterialType = materialsTypes.keys.firstWhere(
      (key) => materialsTypes[key] == type,
    );
    String instructorName = firebaseObj['instructorName'];
    String category = firebaseObj['category'];
    int numberOfRating = firebaseObj['numberOfRating'];
    String bookCoverPath = firebaseObj['courseImagePath'];
    double rating = firebaseObj['rate'];

    return Book(
      name: name,
      bookUrl: bookUrl,
      learningMaterialType: learningMaterialType,
      category: category,
      instructorName: instructorName,
      numberOfRatings: numberOfRating,
      bookCoverPath: bookCoverPath,
      rating: rating,
    );
  }
}
