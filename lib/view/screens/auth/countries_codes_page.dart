// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:panadol/logic/cubits/countries_code_cubit/countries_code_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:panadol/view/widgets/country_info_item_form.dart';

class CountriesCodesPage extends StatelessWidget {
  const CountriesCodesPage({
    super.key,
  });
  static const pageRoute = 'countries_codes_page';
  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return WillPopScope(
        onWillPop: () async {
          await context.read<CountriesCodeCubit>().addNoCountrySelectedEvent();
          return true;
        },
        child: Scaffold(
          body: BlocConsumer<CountriesCodeCubit, CountriesCodeState>(
            listener: (context, state) {
              // TODO: implement listener
              if (state is GotCountryState) {
                print(state.country.callingCode);
                Navigator.of(context).pop();
              }
            },
            builder: (context, state) {
              if (state is CountriesCodesLoadingState) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is GotCountryCodesListState) {
                final countriesList = state.countriesCodesList;
                return ListView.builder(
                  itemCount: state.countriesCodesList.length,
                  itemBuilder: (context, index) {
                    return CountryInfoItemForm(
                      country: countriesList[index],
                      onTap: () {
                        context.read<CountriesCodeCubit>().selectCountryCode(
                              country: countriesList[index],
                            );
                      },
                    );
                  },
                );
              }
              return Container();
            },
          ),
        ),
      );
    });
  }
}
