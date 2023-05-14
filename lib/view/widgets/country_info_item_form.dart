// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';

import 'package:country_calling_code_picker/picker.dart';

class CountryInfoItemForm extends StatelessWidget {
  const CountryInfoItemForm({
    super.key,
    required this.country,
    required this.onTap,
  });
  final Country country;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: SizedBox(
        height: 30,
        width: 35,
        child: Image.asset(
          country.flag,
          package: countryCodePackageName,
        ),
      ),
      title: Text(
        country.name,
        style: Theme.of(context).textTheme.headline5,
      ),
      subtitle: Text(
        country.callingCode,
        style: Theme.of(context).textTheme.headline6,
      ),
    );
  }
}
