part of 'localization_cubit.dart';

@immutable
abstract class LocalizationState extends Equatable {
  const LocalizationState();
}

class GetLanguageCodeState extends LocalizationState {
  final String langCode;
  const GetLanguageCodeState({required this.langCode,});
  @override
  // TODO: implement props
  List<Object?> get props => [langCode];
}

class ChangeLanguageState extends LocalizationState {
  final String newLang;
  const ChangeLanguageState({required this.newLang});

  @override
  // TODO: implement props
  List<Object?> get props => [newLang];
}
