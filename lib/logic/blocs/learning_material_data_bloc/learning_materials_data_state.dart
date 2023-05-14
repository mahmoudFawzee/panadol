part of 'learning_materials_data_bloc.dart';

@immutable
abstract class LearningMaterialsDataState extends Equatable {
  const LearningMaterialsDataState();
}

class LearningMaterialDataLoadingState extends LearningMaterialsDataState {
  const LearningMaterialDataLoadingState();
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class GotCourseDataState extends LearningMaterialsDataState {
  final Course course;
  final bool isInUserLearning;
  const GotCourseDataState({
    required this.course,
    required this.isInUserLearning,
  });
  @override
  // TODO: implement props
  List<Object?> get props => [
        course,
        isInUserLearning,
      ];
}

class GotBookDataState extends LearningMaterialsDataState {
  final Book book;
  const GotBookDataState({
    required this.book,
  });
  @override
  // TODO: implement props
  List<Object?> get props => [
        book,
      ];
}

class GotLearningMaterialErrorState extends LearningMaterialsDataState {
  final String error;
  const GotLearningMaterialErrorState({
    required this.error,
  });
  @override
  // TODO: implement props
  List<Object?> get props => [
        error,
      ];
}
