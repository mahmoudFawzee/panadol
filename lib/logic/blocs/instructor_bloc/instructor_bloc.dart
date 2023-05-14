// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';

import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:panadol/data/firebase/apis/instructor_data_api.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:panadol/data/firebase/models/instructor.dart';
import 'package:panadol/data/firebase/models/learning_material.dart';

part 'instructor_event.dart';
part 'instructor_state.dart';

class InstructorBloc extends Bloc<InstructorEvent, InstructorState> {
  final InstructorDataApi instructorDataApi = InstructorDataApi();
  InstructorBloc() : super(const InstructorDataLoading()) {
    on<GetInstructorDataEvent>((event, emit) async {
      // TODO: implement event handler
      try {
        Instructor? instructorData = await instructorDataApi.getInstructorData(
          instructorName: event.instructorName,
        );
        print(event.instructorName);
        List<LearningMaterial>? instructorCourses = await instructorDataApi
            .getInstructorCourses(instructorName: event.instructorName);
        emit(
          GotInstructorDataState(
            instructor: instructorData,
            courses: instructorCourses,
            numberOfCourses: instructorCourses.length,
          ),
        );
      } on FirebaseException catch (e) {
        print(e.code);
        emit(GotInstructorDataErrorState(error: e.code));
      } catch (e) {
        print(e.toString());
        emit(GotInstructorDataErrorState(error: e.toString()));
      }
    });
  }
}
