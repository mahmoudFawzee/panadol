part of 'image_pick_cubit.dart';

@immutable
abstract class PickImageState extends Equatable {
  const PickImageState();
}

class PickImageInitial extends PickImageState {
  const PickImageInitial();
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class PickedImageState extends PickImageState {
  final File file;
  const PickedImageState({required this.file});
  @override
  // TODO: implement props
  List<Object?> get props => [file];
}

class NoImagePickedState extends PickImageState {
  const NoImagePickedState();
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class PickedImageErrorState extends PickImageState {
  const PickedImageErrorState({
    required this.error,
  });
  final String error;
  @override
  // TODO: implement props
  List<Object?> get props => [error];
}

class GotProfileImageUrlState extends PickImageState {
  const GotProfileImageUrlState({
    required this.imageUrl,
  });
  final String imageUrl;
  @override
  // TODO: implement props
  List<Object?> get props => [
        imageUrl,
      ];
}

class ProfileImageUploadedState extends PickImageState {
  const ProfileImageUploadedState();
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class ProfileImageUploadLoadingState extends PickImageState {
  const ProfileImageUploadLoadingState();
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class ProfileImageUploadError extends PickImageState {
  const ProfileImageUploadError({required this.error});
  final String error;
  @override
  // TODO: implement props
  List<Object?> get props => [error];
}
