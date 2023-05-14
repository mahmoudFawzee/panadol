part of 'phone_auth_bloc.dart';

abstract class PhoneAuthEvent extends Equatable {
  const PhoneAuthEvent();

  @override
  List<Object> get props => [];
}

//todo:this will be in the elevated button in sign in page
class SendOtpCodeEvent extends PhoneAuthEvent {
  final String phoneNumber;
  const SendOtpCodeEvent({
    required this.phoneNumber,
  });

  @override
  List<Object> get props => [phoneNumber];
}

//todo we will call this in otp page
class VerifyOtpCodeEvent extends PhoneAuthEvent {
  final String code;
  final String id;

  const VerifyOtpCodeEvent({
    required this.code,
    required this.id,
  });

  @override
  List<Object> get props => [
        code,
        id,
      ];
}
