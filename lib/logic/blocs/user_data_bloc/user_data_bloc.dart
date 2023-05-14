// ignore_for_file: depend_on_referenced_packages, avoid_print

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:panadol/data/constants/constant.dart';
import 'package:panadol/data/constants/enums.dart';
import 'package:panadol/data/firebase/apis/user_data_api.dart';
import 'package:panadol/data/firebase/models/learning_material.dart';
import 'package:panadol/data/firebase/models/user.dart';

part 'user_data_event.dart';
part 'user_data_state.dart';

class UserDataBloc extends Bloc<UserDataEvent, UserDataState> {
  final userDataApi = UserDataApi();

  UserDataBloc() : super(const UserDataLoadingState()) {
    on<GetUserDataEvent>((event, emit) async {
      // TODO: implement event handler
      emit(const UserDataLoadingState());
      try {
        final user = await userDataApi.getUserData(
          id: event.id,
        );
        if (user != null) {
          emit(GotUserDataState(user: user));
        } else {
          emit(const UserDataErrorState(error: 'حدث خطأ ما'));
        }
      } on FirebaseException catch (e) {
        emit(UserDataErrorState(error: e.code));
      } catch (e) {
        print(e.toString());
        emit(UserDataErrorState(error: e.toString()));
      }
    });

    on<GetProfileDataEvent>((event, emit) async {
      try {
        final myUser = await userDataApi.getUserData(id: event.userId);
        emit(GotUserProfileDataState(
          userName: '${myUser!.firstName} ${myUser.lastName}',
          imageUrl: myUser.profileImageUrl!,
          userId: myUser.userId,
        ));
      } on FirebaseException catch (e) {
        emit(UserDataErrorState(error: e.code));
      } catch (e) {
        emit(UserDataErrorState(error: e.toString()));
      }
    });

    on<PushUserDataEvent>((event, emit) async {
      emit(const PushUserDataLoadingState());
      try {
        await userDataApi.addUserDate(user: event.myUser);
        emit(const NewUserDataPushedState());
      } on FirebaseException catch (e) {
        emit(PushUserDataErrorState(error: e.code));
      } catch (e) {
        emit(PushUserDataErrorState(error: e.toString()));
      }
    });

    on<AddToFavoritesEvent>((event, emit) async {
      emit(const UserDataLoadingState());
      await userDataApi.addToUserLearningOrFavorites(
        courseName: event.courseName,
        learningMaterialType: event.learningMaterialType,
        collectionName: favoritesCollectionName,
      );
      emit(const AddedToFavoritesState());
    });

    on<GetFavoritesEvent>((event, emit) async {
      emit(const UserDataLoadingState());
      try {
        List<LearningMaterial> favorites =
            await userDataApi.getUserLearningOrFavorites(
          collectionName: favoritesCollectionName,
        );
        if (favorites.isEmpty) {
          emit(const UserDataErrorState(error: 'nothing for now'));
        } else {
          emit(GotUserFavoritesState(favorites: favorites));
        }
      } on FirebaseException catch (e) {
        emit(UserDataErrorState(error: e.code));
      } catch (e) {
        emit(UserDataErrorState(error: e.toString()));
      }
    });

//*we will use this in case of update the progress or add a new course.
    on<UpdateUserProgressEvent>((event, emit) async {
      emit(const UserDataLoadingState());
      try {
        await userDataApi.updateProgress(
          courseName: event.courseName,
          currentProgress: event.progress,
          learningMaterialType: event.learningMaterialType,
        );
        emit(const UserProgressUpdatedState());
      } on FirebaseException catch (e) {
        print(e.code);
      } catch (e) {
        print(e.toString());
      }
    });

    on<AddToUserLearningEvent>((event, emit) async {
      emit(const UserDataLoadingState());
      try {
        await userDataApi.addToUserLearningOrFavorites(
          collectionName: userLearningCollectionName,
          courseName: event.courseName,
          learningMaterialType: event.learningMaterialType,
        );
        await userDataApi.removeFromFavoritesOrUserLearning(
          collectionName: favoritesCollectionName,
          courseName: event.courseName,
          materialType: event.learningMaterialType,
        );
        emit(const AddedToUserLearningState());
      } on FirebaseException catch (e) {
        emit(UserDataErrorState(error: e.code));
      } catch (e) {
        emit(UserDataErrorState(error: e.toString()));
      }
    });

    on<GetUserLearningEvent>((event, emit) async {
      emit(const UserDataLoadingState());
      try {
        List<LearningMaterial> learningList =
            await userDataApi.getUserLearningOrFavorites(
          collectionName: userLearningCollectionName,
        );
        print(learningList);
        if (learningList.isEmpty) {
          emit(const UserDataErrorState(error: 'nothing for now'));
        } else {
          emit(GotUserLearningState(learning: learningList));
        }
      } on FirebaseException catch (e) {
        emit(UserDataErrorState(error: e.code));
      } catch (e) {
        emit(UserDataErrorState(error: e.toString()));
      }
    });

    on<RemoveFromFavoritesEvent>((event, emit) async {
      emit(const UserDataLoadingState());
      try {
        await userDataApi.removeFromFavoritesOrUserLearning(
          collectionName: favoritesCollectionName,
          materialType: event.learningMaterialType,
          courseName: event.courseName,
        );
        List<LearningMaterial> newFavorites =
            await userDataApi.getUserLearningOrFavorites(
          collectionName: favoritesCollectionName,
        );
        if (newFavorites.isEmpty) {
          emit(const UserDataErrorState(error: 'nothing for now'));
        } else {
          emit(GotUserFavoritesState(favorites: newFavorites));
        }
      } on FirebaseException catch (e) {
        emit(UserDataErrorState(error: e.code));
      } catch (e) {
        emit(UserDataErrorState(error: e.toString()));
      }
    });

    on<RemoveFromUserLearningEvent>((event, emit) async {
      emit(const UserDataLoadingState());
      try {
        await userDataApi.removeFromFavoritesOrUserLearning(
          collectionName: userLearningCollectionName,
          materialType: event.learningMaterialType,
          courseName: event.courseName,
        );
        emit(const RemovedFromUserLearningState());
      } on FirebaseException catch (e) {
        emit(UserDataErrorState(error: e.code));
      } catch (e) {
        emit(UserDataErrorState(error: e.toString()));
      }
    });
  }
}
