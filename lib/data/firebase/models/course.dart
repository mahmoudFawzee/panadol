import 'package:panadol/data/constants/enums.dart';
import 'package:panadol/data/firebase/models/learning_material.dart';
import 'package:panadol/data/models/video.dart';

class Course extends LearningMaterial {
  final String playlistId;
  final Duration duration;
  final String description;
  List<Video>? videos;
  Course({
    required this.duration,
    required this.playlistId,
    required this.description,
    required String name,
    required String instructorName,
    required String courseImagePath,
    required int numberOfRatings,
    required double rating,
    required String category,
  }) : super(
          category: category,
          name: name,
          instructorName: instructorName,
          courseImagePath: courseImagePath,
          materialType: LearningMaterialType.course,
          numberOfRating: numberOfRatings,
          rating: rating,
        );
  factory Course.fromFirebase({
    required Map<String, dynamic>? firebaseObj,
  }) {
    String name = firebaseObj!['name'];
    print(name);
    String instructorName = firebaseObj['instructor'];
    print(instructorName);
    String playlistId = firebaseObj['playlistId'];
    print(playlistId);
    String category = firebaseObj['category'];
    print(category);
    int numberOfRating = firebaseObj['numberOfRates'];
    print(numberOfRating);
    String courseImagePath = firebaseObj['courseImageUrl'];
    print(courseImagePath);
    double rating = firebaseObj['rate'];
    print(rating);
    int duration = firebaseObj['duration'];
    print(duration);
    String description = firebaseObj['description'];
    return Course(
      playlistId: playlistId,
      name: name,
      category: category,
      instructorName: instructorName,
      courseImagePath: courseImagePath,
      duration: Duration(
          hours: int.parse(
        duration.toString(),
      )),
      numberOfRatings: numberOfRating,
      rating: rating,
      description: description,
    );
  }
}
