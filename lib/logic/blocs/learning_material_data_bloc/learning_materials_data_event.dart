part of 'learning_materials_data_bloc.dart';

@immutable
abstract class LearningMaterialsDataEvent extends Equatable {
  const LearningMaterialsDataEvent();
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class GetCourseEvent extends LearningMaterialsDataEvent {
  //? course id will be the course name and the course instructor like => courseNameByCourseInstructor
  final String courseName;
  final String courseCategory;
  const GetCourseEvent({
    required this.courseName,
    required this.courseCategory,
  });
  @override
  // TODO: implement props
  List<Object?> get props => [courseName,courseCategory,];
}

class GetBookEvent extends LearningMaterialsDataEvent {
  //? course id will be the course name and the course instructor like => courseNameByCourseInstructor
  final String bookId;
  final LearningMaterialType learningMaterialType;
  const GetBookEvent({
    required this.bookId,
    required this.learningMaterialType,
  });
  @override
  // TODO: implement props
  List<Object?> get props => [bookId,learningMaterialType,];
}
