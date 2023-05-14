// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:panadol/data/constants/constant.dart';
import 'package:panadol/data/constants/enums.dart';
import 'package:panadol/data/firebase/apis/learning_materials_data_api.dart';
import 'package:panadol/data/firebase/apis/user_data_api.dart';
import 'package:panadol/data/firebase/models/book.dart';
import 'package:panadol/data/firebase/models/course.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:panadol/data/firebase/models/learning_material.dart';

part 'learning_materials_data_event.dart';
part 'learning_materials_data_state.dart';

class LearningMaterialsDataBloc
    extends Bloc<LearningMaterialsDataEvent, LearningMaterialsDataState> {
  final LearningMaterialsDataApi learningMaterialsDataApi =
      LearningMaterialsDataApi();
  final UserDataApi userDataApi = UserDataApi();
  LearningMaterialsDataBloc()
      : super(const LearningMaterialDataLoadingState()) {
    on<GetCourseEvent>((event, emit) async {
      emit(const LearningMaterialDataLoadingState());
      try {
        final course = await learningMaterialsDataApi.getCourse(
          courseName: event.courseName,
          courseCategory: event.courseCategory,
        );
        List<String> userLearningList =
            await userDataApi.getUserLearningCoursesNames(
          learningMaterialType: course.materialType,
        );
        bool isInUserLearning = userLearningList.contains(course.name);
        print('course is $isInUserLearning');
        emit(GotCourseDataState(
          course: course,
          isInUserLearning: isInUserLearning,
        ));
      } on FirebaseException catch (e) {
        emit(GotLearningMaterialErrorState(error: e.code));
      } catch (e) {
        emit(GotLearningMaterialErrorState(error: e.toString()));
      }
    });

    on<GetBookEvent>((event, emit) async {
      emit(const LearningMaterialDataLoadingState());
      try {
        final book = await learningMaterialsDataApi.getBook(
          bookId: event.bookId,
          learningMaterialType: event.learningMaterialType,
        );
        emit(GotBookDataState(book: book));
      } on FirebaseException catch (e) {
        emit(GotLearningMaterialErrorState(error: e.code));
      } catch (e) {
        emit(GotLearningMaterialErrorState(error: e.toString()));
      }
    });
  }
}
