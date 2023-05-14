part of 'user_data_bloc.dart';

@immutable
abstract class UserDataEvent extends Equatable {
  const UserDataEvent();
}

class GetUserDataEvent extends UserDataEvent {
  const GetUserDataEvent({required this.id});
  final String id;
  @override
  List<Object?> get props => [id];
}

class GetProfileDataEvent extends UserDataEvent {
  final String userId;
  const GetProfileDataEvent({
    required this.userId,
  });
  @override
  // TODO: implement props
  List<Object?> get props => [userId];
}

class PushUserDataEvent extends UserDataEvent {
  const PushUserDataEvent({
    required this.myUser,
  });
  final MyUser myUser;
  @override
  List<Object?> get props => [myUser];
}

class UpdateUserProgressEvent extends UserDataEvent {
  final LearningMaterialType learningMaterialType;
  final String userId;
  final String courseName;
  //*it can be n_of_video or n_book_sheet
  final int progress;
  const UpdateUserProgressEvent({
    required this.learningMaterialType,
    required this.userId,
    required this.courseName,
    required this.progress,
  });
  @override
  // TODO: implement props
  List<Object?> get props =>
      [learningMaterialType, userId, courseName, progress];
}

class AddToFavoritesEvent extends UserDataEvent {
  const AddToFavoritesEvent({
    required this.courseName,
    required this.learningMaterialType,
  });
  final String courseName;
  final LearningMaterialType learningMaterialType;
  @override
  // TODO: implement props
  List<Object?> get props => [
        courseName,
        learningMaterialType,
      ];
}

class AddToUserLearningEvent extends UserDataEvent {
  final String courseName;
  final LearningMaterialType learningMaterialType;
  const AddToUserLearningEvent({
    required this.courseName,
    required this.learningMaterialType,
  });
  @override
  // TODO: implement props
  List<Object?> get props => [
        courseName,
        learningMaterialType,
      ];
}

class GetFavoritesEvent extends UserDataEvent {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class GetUserLearningEvent extends UserDataEvent {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class RemoveFromFavoritesEvent extends UserDataEvent {
  final String courseName;
  final LearningMaterialType learningMaterialType;
  const RemoveFromFavoritesEvent({
    required this.courseName,
    required this.learningMaterialType,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [
        courseName,
        learningMaterialType,
      ];
}

class RemoveFromUserLearningEvent extends UserDataEvent {
  final String courseName;
  final LearningMaterialType learningMaterialType;
  const RemoveFromUserLearningEvent({
    required this.courseName,
    required this.learningMaterialType,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [
        courseName,
        learningMaterialType,
      ];
}
