part of 'instructor_bloc.dart';

@immutable
abstract class InstructorEvent extends Equatable {
  const InstructorEvent();
}

class GetInstructorDataEvent extends InstructorEvent {
  final String instructorName;
  
  const GetInstructorDataEvent({
    required this.instructorName,
  });
  @override
  // TODO: implement props
  List<Object?> get props => [instructorName];
}
