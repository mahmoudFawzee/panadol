// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'localization_state.dart';

class LocalizationCubit extends Cubit<LocalizationState> {
  final String? langCode;
  LocalizationCubit({
    required this.langCode,
  }) : super(GetLanguageCodeState(langCode: langCode!));
  Future<void> changLang({
    required String newLangCode,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('lang', newLangCode);
    emit(ChangeLanguageState(newLang: newLangCode));
  }
}
