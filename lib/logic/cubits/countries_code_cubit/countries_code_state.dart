part of 'countries_code_cubit.dart';

@immutable
abstract class CountriesCodeState extends Equatable {
  const CountriesCodeState();
}

class CountriesCodeInitial extends CountriesCodeState {
  final Country country;
  const CountriesCodeInitial({
    required this.country,
  });
  @override
  // TODO: implement props
  List<Object?> get props => [country];
}

class GotCountryState extends CountriesCodeState {
  final Country country;
  const GotCountryState({required this.country});
  @override
  // TODO: implement props
  List<Object?> get props => [
        country,
      ];
}

class GotCountryCodesListState extends CountriesCodeState {
  final List<Country> countriesCodesList;
  const GotCountryCodesListState({
    required this.countriesCodesList,
  });
  @override
  // TODO: implement props
  List<Object?> get props => [
        countriesCodesList,
      ];
}

class CountriesCodesLoadingState extends CountriesCodeState {
  const CountriesCodesLoadingState();
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class NoCountrySelectedState extends CountriesCodeState {
  const NoCountrySelectedState();
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
