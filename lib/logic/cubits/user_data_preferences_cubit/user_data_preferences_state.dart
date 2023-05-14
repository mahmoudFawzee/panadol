part of 'user_data_preferences_cubit.dart';

@immutable
abstract class UserDataPreferencesState extends Equatable {
  const UserDataPreferencesState();
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class UserDataPreferencesInitial extends UserDataPreferencesState {
  const UserDataPreferencesInitial();
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class GotUserIdAndCategoryState extends UserDataPreferencesState {
  final String userId;
  final String userCategory;
  const GotUserIdAndCategoryState({
    required this.userId,
    required this.userCategory,
  });
  @override
  // TODO: implement props
  List<Object?> get props => [userId, userCategory];
}

class GotUserIdState extends UserDataPreferencesState {
  final String userId;

  const GotUserIdState({
    required this.userId,
  });
  @override
  // TODO: implement props
  List<Object?> get props => [
        userId,
      ];
}

class GotUserCategoryState extends UserDataPreferencesState {
  final String userCategory;

  const GotUserCategoryState({
    required this.userCategory,
  });
  @override
  // TODO: implement props
  List<Object?> get props => [
        userCategory,
      ];
}

class NoUserIdState extends UserDataPreferencesState {
  const NoUserIdState();
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class NoUserCategoryState extends UserDataPreferencesState {
  const NoUserCategoryState();
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class RemovedUserDataPreferences extends UserDataPreferencesState {
  const RemovedUserDataPreferences();
  @override
  // TODO: implement props
  List<Object?> get props => super.props;
}
