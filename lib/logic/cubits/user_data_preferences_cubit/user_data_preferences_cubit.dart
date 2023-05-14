// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:panadol/data/local_data/user_data_preferences.dart';

part 'user_data_preferences_state.dart';

class UserDataPreferencesCubit extends Cubit<UserDataPreferencesState> {
  final _userDataPreferences = UserDataPreferences();
  UserDataPreferencesCubit() : super(const UserDataPreferencesInitial());

  Future<void> getUserDataPreferences() async {
    String? userId = await _userDataPreferences.getUserId();
    String? userCategory = await _userDataPreferences.getUserCategory();
    emit(
      GotUserIdAndCategoryState(
        userId: userId!,
        userCategory: userCategory!,
      ),
    );
  }

  Future<void> getUserId() async {
    String? userId = await _userDataPreferences.getUserId();

    if (userId == null) {
      emit(const NoUserIdState());
    } else {
      emit(GotUserIdState(userId: userId));
    }
  }

  Future<void> removedUserDataPreferences() async {
    try {
      bool prefsRemoved = await UserDataPreferences.removeUserDataPreferences();
      if (prefsRemoved) {
        emit(const RemovedUserDataPreferences());
      } else {
        print('$prefsRemoved some thing went wrong');
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<bool> setUserId({required userId}) async {
    try {
      bool idSet = await UserDataPreferences.setUserId(userId);
      return idSet;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  Future<bool> setUserCategory({required String category}) async {
    try {
      bool categorySet = await UserDataPreferences.setUserCategory(category);
      return categorySet;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }
}
