import 'package:panadol/data/constants/enums.dart';

class LearningMaterial {
  const LearningMaterial({
    required this.name,
    required this.materialType,
    required this.category,
    required this.instructorName,
    required this.numberOfRating,
    required this.courseImagePath,
    required this.rating,
  });
  final String name;
  final LearningMaterialType materialType;
  final String category;
  final String instructorName;
  final int numberOfRating;
  final double rating;
  final String courseImagePath;

  Map<String, Object?> toFirestoreObj() {
    return {
      'name': name,
      'materialType': materialsTypes[materialType],
      'category': category,
      'instructor': instructorName,
      'numberOfRates': numberOfRating,
      'courseImageUrl': courseImagePath,
      'rate': rating,
    };
  }

  factory LearningMaterial.fromFirebase(
    Map<String, dynamic>? firebaseLearningMaterial,
  ) {
    String instructorName = firebaseLearningMaterial!['instructor'];
    //print(instructorName);
    String category = firebaseLearningMaterial['category'];
    //print(category);
    String courseImagePath = firebaseLearningMaterial['courseImageUrl'];
    //print(courseImagePath);
    String type = firebaseLearningMaterial['materialType'];
    //print(type);
    String name = firebaseLearningMaterial['name'];
   // print(name);
    int numberOfRating = firebaseLearningMaterial['numberOfRates'];
    //print(numberOfRating);
    double rating = firebaseLearningMaterial['rate'];
    //print(rating);

    LearningMaterialType learningMaterialType = materialsTypes.keys.firstWhere(
      (key) => materialsTypes[key] == type,
    );

    return LearningMaterial(
      name: name,
      materialType: learningMaterialType,
      category: category,
      instructorName: instructorName,
      numberOfRating: numberOfRating,
      courseImagePath: courseImagePath,
      rating: rating,
    );
  }
}
