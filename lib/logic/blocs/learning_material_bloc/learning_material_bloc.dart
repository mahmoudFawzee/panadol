// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:panadol/data/constants/enums.dart';
import 'package:panadol/data/firebase/apis/learning_material_api.dart';
import 'package:panadol/data/firebase/models/learning_material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'learning_material_event.dart';
part 'learning_material_state.dart';

class LearningMaterialBloc
    extends Bloc<LearningMaterialEvent, LearningMaterialState> {
  final LearningMaterialApi learningMaterialApi = LearningMaterialApi();
  LearningMaterialBloc() : super(const GetMaterialsLoadingState()) {
    on<GetCategoryMaterialsEvent>((event, emit) async {
      // TODO: implement event handler
      emit(const GetMaterialsLoadingState());
      try {
        List<LearningMaterial> materials =
            await learningMaterialApi.getCategoryLearningMaterialData(
          category: event.category,
          learningMaterialType: event.learningMaterialType,
        );
        print('materials len is: ${materials.length}');
        if (materials.isEmpty) {
          emit(const GetMaterialsErrorState(error: 'Nothing to show here...'));
        } else {
          emit(GotCategoryMaterialsState(learningMaterial: materials));
        }
      } on FirebaseException catch (e) {
        emit(GetMaterialsErrorState(error: e.code));
      } catch (e) {
        emit(GetMaterialsErrorState(error: e.toString()));
        print(e.toString());
      }
    });

    on<StartSearchEvent>((event, emit) async {
      // TODO: implement event handler
      emit(const GetMaterialsLoadingState());
      try {
        await learningMaterialApi.getAllMaterials();
        emit(const GotMaterialsForSearchState());
      } on FirebaseException catch (e) {
        emit(GetMaterialsErrorState(error: e.code));
      } catch (e) {
        emit(GetMaterialsErrorState(error: e.toString()));
      }
    });

    on<SearchInMaterialsEvent>((event, emit) {
      emit(const GetMaterialsLoadingState());
      List<LearningMaterial> learningMaterialList =
          learningMaterialApi.searchInMaterials(searchKey: event.searchKey);
      if (learningMaterialList.isEmpty) {
        emit(const GotSearchedMaterialsState(learningMaterial: null));
      } else {
        emit(GotSearchedMaterialsState(learningMaterial: learningMaterialList));
      }
    });
  }
}
