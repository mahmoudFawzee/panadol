// ignore_for_file: depend_on_referenced_packages

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:panadol/data/firebase/apis/auth_api.dart';
import 'package:panadol/data/firebase/apis/user_data_api.dart';

part 'social_auth_event.dart';
part 'social_auth_state.dart';

class SocialAuthBloc extends Bloc<SocialAuthEvent, SocialAuthState> {
  final _firebaseAuthApi = FirebaseAuthApi();
  SocialAuthBloc() : super(const SocialAuthInitialState()) {
    on<SignInWithGoogleEvent>((event, emit) async {
      emit(const SocialAuthLoadingState());
      try {
        bool signInSuccess = await _firebaseAuthApi.signInGoogle();

        if (signInSuccess) {
          String? userEmail = _firebaseAuthApi.userEmail;
          final UserDataApi userDataApi = UserDataApi();
          bool isRegistered = await userDataApi.isUserExists(id: userEmail!);
          if (isRegistered) {
            emit(UserAlreadyRegisteredSocialState(userId: userEmail));
            // ignore: dead_code
          } else {
            emit(NewSocialUserState(userId: userEmail));
          }
        }
      } on FirebaseException catch (e) {
        emit(GoogleSignInErrorState(error: e.code));
      } catch (e) {
        emit(GoogleSignInErrorState(error: e.toString()));
      }
    });

    on<SignInWithFacebookEvent>((event, emit) async {
      emit(const SocialAuthLoadingState());
      try {
        bool isSignedIn = await _firebaseAuthApi.signInWithFacebook();
        if (isSignedIn) {
          String? userEmail = _firebaseAuthApi.userEmail;
          final UserDataApi userDataApi = UserDataApi();
          bool isRegistered = await userDataApi.isUserExists(id: userEmail!);
          if (isRegistered) {
            emit(UserAlreadyRegisteredSocialState(userId: userEmail));
          } else {
            emit(NewSocialUserState(userId: userEmail));
          }
        }
      } on FirebaseException catch (e) {
        emit(FacebookSignInErrorState(error: e.code));
      } catch (e) {
        emit(FacebookSignInErrorState(error: e.toString()));
      }
    });
    //?we will just use this method to sign out as we don't need to specify the
    //?the auth method.
    on<SignOutEvent>((event, emit) async {
      emit(const SocialAuthLoadingState());
      try {
        await _firebaseAuthApi.signOut();
        emit(const SignOutSuccessfullyState());
      } on FirebaseException catch (e) {
        emit(SignOutErrorState(error: e.code));
      } catch (e) {
        emit(SignOutErrorState(error: e.toString()));
      }
    });
  }
}
