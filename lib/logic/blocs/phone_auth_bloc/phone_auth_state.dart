part of 'phone_auth_bloc.dart';

abstract class PhoneAuthState extends Equatable {
  const PhoneAuthState();

  @override
  List<Object?> get props => [];
}

class PhoneAuthInitial extends PhoneAuthState {
  const PhoneAuthInitial({isLoggedIn = false});
  @override
  List<Object?> get props => [];
}

class PhoneAuthLoadingState extends PhoneAuthState {
  const PhoneAuthLoadingState();
  @override
  List<Object?> get props => [];
}

class PhoneSignInErrorState extends PhoneAuthState {
  final String error;
  const PhoneSignInErrorState({
    required this.error,
  });
  @override
  List<Object?> get props => [error];
}

class CodeRequestedState extends PhoneAuthState {
  const CodeRequestedState();
  @override
  List<Object?> get props => [];
}

class UserAlreadyRegisteredPhoneState extends PhoneAuthState {
  final String userId;
  const UserAlreadyRegisteredPhoneState({required this.userId});
  @override
  List<Object?> get props => [userId];
}

class NewPhoneUserState extends PhoneAuthState {
  const NewPhoneUserState({required this.userId});
  final String userId;

  @override
  List<Object?> get props => [userId];
}
