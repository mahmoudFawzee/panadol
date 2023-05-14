// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:panadol/data/local_data/user_data_preferences.dart';
import 'package:panadol/logic/blocs/social_auth_bloc/social_auth_bloc.dart';
import 'package:panadol/logic/blocs/phone_auth_bloc/phone_auth_bloc.dart';
import 'package:panadol/logic/blocs/user_data_bloc/user_data_bloc.dart';
import 'package:panadol/logic/cubits/countries_code_cubit/countries_code_cubit.dart';
import 'package:panadol/logic/cubits/image_picker_cubit/image_pick_cubit.dart';
import 'package:panadol/data/constants/enums.dart';
import 'package:panadol/logic/cubits/navigation_bar_cubit/navigation_bar_cubit.dart';
import 'package:panadol/logic/cubits/user_data_preferences_cubit/user_data_preferences_cubit.dart';
import 'package:panadol/view/screens/auth/countries_codes_page.dart';
import 'package:panadol/view/screens/auth/otp_screen.dart';
import 'package:panadol/view/screens/auth/personal_data.dart';
import 'package:panadol/view/screens/home/navigation.dart';
import 'package:panadol/view/widgets/custom_buttons/custom_elevated_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:panadol/view/widgets/custom_text_field.dart';
import 'package:panadol/view/widgets/custom_buttons/social_signin_icons.dart';
import 'package:country_calling_code_picker/picker.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({Key? key}) : super(key: key);
  static const pageRoute = 'registration_page';

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  //now we need controllers to get the value from the fields
  TextEditingController? phoneNumberController;
  String? phoneNumber;
  Country country = const Country('Egypt', 'flags/egy.png', 'eg', '+20');
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    phoneNumberController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    // phoneNumberController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final localizationObj = AppLocalizations.of(context);
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        height: double.infinity,
        margin: EdgeInsets.only(
          top: height * (20 / 147),
        ),
        decoration: const BoxDecoration(
          color: Color.fromARGB(51, 0, 0, 0),
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(25),
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(top: 20),
          child: Column(
            children: [
              const SizedBox(
                height: 150,
                child: Text(
                  'Log in',
                  style: TextStyle(
                    fontSize: 30,
                    color: Color.fromARGB(255, 16, 37, 91),
                    fontFamily: 'Tajwal',
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              CustomTextField(
                controller: phoneNumberController!,
                hint: localizationObj!.phoneNumber,
                label: '${localizationObj.add}${localizationObj.phoneNumber}',
                inputType: TextInputType.phone,
                fieldsType: FieldsType.phoneNumber,
                height: height,
                width: width,
                prefixIcon:
                    BlocConsumer<CountriesCodeCubit, CountriesCodeState>(
                  listener: (context, state) {
                    if (state is CountriesCodeInitial) {
                      //?here first thing we will do is assign the value of initial to
                      //variable country
                      country = state.country;
                    } else if (state is GotCountryState) {
                      country = state.country;
                    }
                  },
                  builder: (context, state) {
                    if (state is CountriesCodeInitial) {
                      return selectYourCountry(
                        context,
                        Image.asset(
                          state.country.flag,
                          package: countryCodePackageName,
                        ),
                      );
                    } else if (state is GotCountryState) {
                      return selectYourCountry(
                        context,
                        Image.asset(
                          state.country.flag,
                          package: countryCodePackageName,
                        ),
                      );
                    }
                    //? the state of no country selected
                    return selectYourCountry(
                      context,
                      Image.asset(
                        country.flag,
                        package: countryCodePackageName,
                      ),
                    );
                  },
                ),
                validator: (value) {
                  if (value == null) {
                    return 'you must enter you phone number';
                  } else if (value.length < 10) {
                    return 'please, enter a valid phone number';
                  } else {
                    return null;
                  }
                },
              ),
              const SizedBox(
                height: 20,
              ),
              BlocConsumer<PhoneAuthBloc, PhoneAuthState>(
                listener: (context, state) {
                  if (state is CodeRequestedState) {
                    Navigator.of(context).pushNamed(
                      OTPScreen.pageRoute,
                      arguments: {
                        'phoneNumber': '${country.callingCode}$phoneNumber',
                      },
                    );
                  }
                },
                builder: (context, state) {
                  if (state is PhoneAuthLoadingState) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return CustomElevatedButton(
                    filled: true,
                    text: localizationObj.login,
                    width: 74,
                    height: 8,
                    onPressed: () {
                      if (phoneNumberController!.value.text.isNotEmpty) {
                        phoneNumber = phoneNumberController!.value.text;
                        context.read<PhoneAuthBloc>().add(
                              SendOtpCodeEvent(
                                phoneNumber:
                                    '${country.callingCode}$phoneNumber',
                              ),
                            );
                      } else if (phoneNumberController!.value.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'phone number can not be empty',
                            ),
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'please enter a valid phone number',
                            ),
                          ),
                        );
                      }
                    },
                  );
                },
              ),
              const SizedBox(
                height: 100,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  localizationObj.anotherWayToLogin,
                  style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              BlocListener<SocialAuthBloc, SocialAuthState>(
                listener: (context, state) {
                  if (state is UserAlreadyRegisteredSocialState) {
                    context
                        .read<UserDataPreferencesCubit>()
                        .getUserDataPreferences();                    
                    Navigator.of(context).pushReplacementNamed(
                      NavigationPage.pageRoute, arguments: {
                          'pageIndex': 0,
                        },
                    );
                  } else if (state is NewSocialUserState) {
                    Navigator.of(context).pushNamed(
                      PersonalDataScreen.pageRoute,
                      arguments: {
                        'userId': state.userId,
                      },
                    );
                  } else if (state is FacebookSignInErrorState) {
                    print(state.error);
                  } else if (state is GoogleSignInErrorState) {
                    print(state.error);
                  }
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SocialSignInIcon(
                      iconPath: 'assets/images/social_media_images/google.png',
                      onTap: () {
                        context.read<SocialAuthBloc>().add(
                              const SignInWithGoogleEvent(),
                            );
                      },
                    ),
                    SocialSignInIcon(
                      iconPath:
                          'assets/images/social_media_images/facebook.png',
                      onTap: () {
                        context.read<SocialAuthBloc>().add(
                              const SignInWithFacebookEvent(),
                            );
                      },
                    ),
                    SocialSignInIcon(
                      iconPath: 'assets/images/social_media_images/apple.png',
                      onTap: () {},
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  TextButton selectYourCountry(
    BuildContext context,
    Widget child1,
  ) {
    return TextButton(
      onPressed: () {
        context.read<CountriesCodeCubit>().showCountriesCodes(context: context);
        Navigator.of(context).pushNamed(CountriesCodesPage.pageRoute);
      },
      child: SizedBox(
        height: 25,
        width: 35,
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: child1,
            ),
            const Expanded(
              flex: 1,
              child: Icon(
                Icons.arrow_drop_down,
                color: Colors.black,
                size: 25,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
