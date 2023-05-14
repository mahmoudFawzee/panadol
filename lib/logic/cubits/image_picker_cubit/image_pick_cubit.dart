// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:image_picker/image_picker.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';
import 'dart:io';

part 'image_pick_state.dart';

class PickImageCubit extends Cubit<PickImageState> {
  PickImageCubit() : super(const PickImageInitial());
  final fireStorage = FirebaseStorage.instance;

  final _picker = ImagePicker();
  File? _imagePicked;
  Future<void> _pickImage({
    required bool fromCamera,
  }) async {
    try {
      XFile? pickedImage = await _picker.pickImage(
        source: fromCamera ? ImageSource.camera : ImageSource.gallery,
      );
      if (pickedImage != null) {
        print(pickedImage.path);
        _imagePicked = File(pickedImage.path);
      } else if (pickedImage == null) {
        print('no image picked');
        return;
      }
    } catch (e) {
      print(e.toString());
    }
  }

  void pickImageEvent({required bool isFromCamera}) async {
    try {
      await _pickImage(fromCamera: isFromCamera);
      if (_imagePicked == null) {
        emit(const NoImagePickedState());
      } else {
        print('_picked image is : ${_imagePicked!.path}');
        emit(PickedImageState(file: _imagePicked!));
      }
    } catch (e) {
      emit(PickedImageErrorState(error: e.toString()));
    }
  }

  Future<void> uploadProfileImageEvent({
    required String userId,
    required String? imagePath,
  }) async {
    emit(const ProfileImageUploadLoadingState());
    try {
      if (imagePath != null) {
        print(imagePath);
        File image = File(imagePath);
        bool hadUploaded = await _uploadFile(
          userId: userId,
          image: image,
        );
        if (hadUploaded) {
          emit(const ProfileImageUploadedState());
        }
      } else {
        print('no image state');
        emit(
          const NoImagePickedState(),
        );
      }
    } catch (e) {
      emit(ProfileImageUploadError(error: 'e: error${e.toString()}'));
    }
  }

  void getUrlEvent({required String userId}) async {
    emit(const ProfileImageUploadLoadingState());
    try {
      String imageUrl = await _getProfileImageUrl(userId: userId);
      print('image url is : $imageUrl');
      emit(
        GotProfileImageUrlState(imageUrl: imageUrl),
      );
    } catch (e) {
      emit(ProfileImageUploadError(error: 'e: error${e.toString()}'));
    }
  }

  Future<String> _getProfileImageUrl({required String userId}) async {
    Reference ref = fireStorage.ref('users profile photos/$userId');
    final result = await ref.listAll();
    String url = await _getFileDownloadLink(reference: result.items.first);
    return url;
  }

  Future<String> _getFileDownloadLink({required Reference reference}) async {
    return await reference.getDownloadURL();
  }

//!this works perfectly.

  Future<bool> _uploadFile({
    required String userId,
    required File image,
  }) async {
    try {
      final fileName = basename(image.path);
      final destination = 'users profile photos/$userId/$fileName';
      final task = _uploadTask(file: image, destination: destination);
      await task!;
      return true;
    } catch (e) {
      return false;
    }
  }

  UploadTask? _uploadTask({
    required File? file,
    required String destination,
  }) {
    Reference ref = fireStorage.ref(destination);
    return ref.putFile(file!);
  }
}
