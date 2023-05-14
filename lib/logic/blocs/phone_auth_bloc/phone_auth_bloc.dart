// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:panadol/data/firebase/apis/auth_api.dart';
import 'package:panadol/data/firebase/apis/user_data_api.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'phone_auth_event.dart';
part 'phone_auth_state.dart';

class PhoneAuthBloc extends Bloc<PhoneAuthEvent, PhoneAuthState> {
  FirebaseAuthApi authApi = FirebaseAuthApi();
  final _firebaseUserDataApi = UserDataApi();
  PhoneAuthBloc() : super(const PhoneAuthInitial()) {
    on<SendOtpCodeEvent>((event, emit) async {
      emit(const PhoneAuthLoadingState());
      try {
        await authApi.sendOtpCode(
          phoneNumber: event.phoneNumber,
        );
        emit(const CodeRequestedState());
      } on FirebaseException catch (e) {
        emit(PhoneSignInErrorState(error: e.code));
      } catch (e) {
        emit(PhoneSignInErrorState(error: e.toString()));
      }
    });

    on<VerifyOtpCodeEvent>((event, emit) async {
      emit(const PhoneAuthLoadingState());
      try {
        bool verified = await authApi.verifyOTP(
          otp: event.code,
        );
        if (verified) {
          bool isExist = await _firebaseUserDataApi.isUserExists(id: event.id);
          if (isExist) {
            emit( UserAlreadyRegisteredPhoneState(userId: event.id));
          } else {
            emit(NewPhoneUserState(userId: event.id));
          }
        }
      } on FirebaseException catch (e) {
        emit(PhoneSignInErrorState(error: e.code));
      } catch (e) {
        emit(PhoneSignInErrorState(error: e.toString()));
      }
    });
  }
}
