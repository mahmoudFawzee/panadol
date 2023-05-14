part of 'user_data_bloc.dart';

@immutable
abstract class UserDataState extends Equatable {
  const UserDataState();
}

class GotUserDataState extends UserDataState {
  final MyUser user;
  const GotUserDataState({required this.user});
  @override
  List<Object?> get props => [user];
}

class GotUserProfileDataState extends UserDataState {
  final String userName;
  final String imageUrl;
  final String userId;
  const GotUserProfileDataState({
    required this.userName,
    required this.imageUrl,
    required this.userId,
  });
  @override
  // TODO: implement props
  List<Object?> get props => [userName,imageUrl,userId,];
}

class UserDataErrorState extends UserDataState {
  final String error;
  const UserDataErrorState({required this.error});
  @override
  List<Object?> get props => [error];
}

class UserDataLoadingState extends UserDataState {
  const UserDataLoadingState();
  @override
  List<Object?> get props => [];
}

class PushUserDataState extends UserDataState {
  final bool pushed;
  const PushUserDataState({required this.pushed});
  @override
  List<Object?> get props => [pushed];
}

class PushUserDataErrorState extends UserDataState {
  final String error;
  const PushUserDataErrorState({required this.error});
  @override
  List<Object?> get props => [error];
}

class PushUserDataLoadingState extends UserDataState {
  const PushUserDataLoadingState();
  @override
  List<Object?> get props => [];
}

class NewUserDataPushedState extends UserDataState {
  const NewUserDataPushedState();
  @override
  List<Object?> get props => [];
}

class UserProgressUpdatedState extends UserDataState {
  const UserProgressUpdatedState();
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class AddedToFavoritesState extends UserDataState {
  const AddedToFavoritesState();
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class GotUserFavoritesState extends UserDataState {
  final List<LearningMaterial> favorites;
  const GotUserFavoritesState({required this.favorites});
  @override
  // TODO: implement props
  List<Object?> get props => [favorites];
}

class GotUserLearningState extends UserDataState {
  final List<LearningMaterial> learning;
  const GotUserLearningState({required this.learning});
  @override
  // TODO: implement props
  List<Object?> get props => [learning];
}

class AddedToUserLearningState extends UserDataState {
  const AddedToUserLearningState();
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class RemovedFromUserLearningState extends UserDataState {
  const RemovedFromUserLearningState();
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
