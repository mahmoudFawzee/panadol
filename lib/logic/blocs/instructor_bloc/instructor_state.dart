part of 'instructor_bloc.dart';

@immutable
abstract class InstructorState extends Equatable {
  const InstructorState();
}

class InstructorDataLoading extends InstructorState {
  const InstructorDataLoading();
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class GotInstructorDataState extends InstructorState {
  final Instructor instructor;
  final List<LearningMaterial> courses;
  final int numberOfCourses;
  const GotInstructorDataState({
    required this.instructor,
    required this.courses,
    required this.numberOfCourses,
  });
  @override
  // TODO: implement props
  List<Object?> get props => [
        instructor,
        courses,
      ];
}

class GotInstructorDataErrorState extends InstructorState {
  final String error;
  const GotInstructorDataErrorState({
    required this.error,
  });
  @override
  // TODO: implement props
  List<Object?> get props => [error];
}
