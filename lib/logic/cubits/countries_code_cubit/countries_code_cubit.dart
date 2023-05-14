// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:equatable/equatable.dart';

import 'package:country_calling_code_picker/picker.dart';
part 'countries_code_state.dart';

class CountriesCodeCubit extends Cubit<CountriesCodeState> {
  CountriesCodeCubit()
      : super(
          const CountriesCodeInitial(
            country: Country('Egypt', 'flags/egy.png', 'eg', '+20'),
          ),
        );

  void showCountriesCodes({
    required BuildContext context,
  }) async {
    emit(const CountriesCodesLoadingState());
    try {
      List<Country> countriesCodesList =
          await _getCountriesCodes(context: context);
      emit(GotCountryCodesListState(countriesCodesList: countriesCodesList));
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> addNoCountrySelectedEvent() async{
    emit(const NoCountrySelectedState());
  }

  void selectCountryCode({required Country country}) {
    try {
      emit(GotCountryState(country: country));
    } catch (e) {
      print(e.toString());
    }
  }

  Future<List<Country>> _getCountriesCodes({
    required BuildContext context,
  }) async {
    return await getCountries(context);
  }
}
