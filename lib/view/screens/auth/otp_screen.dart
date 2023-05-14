// ignore_for_file: depend_on_referenced_packages
import 'package:flutter/material.dart';
import 'package:panadol/data/local_data/user_data_preferences.dart';
import 'package:panadol/logic/blocs/phone_auth_bloc/phone_auth_bloc.dart';
import 'package:panadol/logic/blocs/user_data_bloc/user_data_bloc.dart';
import 'package:panadol/logic/cubits/image_picker_cubit/image_pick_cubit.dart';
import 'package:panadol/logic/cubits/user_data_preferences_cubit/user_data_preferences_cubit.dart';
import 'package:panadol/view/screens/auth/personal_data.dart';
import 'package:panadol/view/screens/home/navigation.dart';

import 'package:panadol/view/widgets/custom_buttons/custom_elevated_button.dart';
import 'package:pinput/pinput.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class OTPScreen extends StatefulWidget {
  const OTPScreen({Key? key}) : super(key: key);
  static const pageRoute = 'OTP_page';
  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  final pinController = TextEditingController();
  final focusNode = FocusNode();

  @override
  void dispose() {
    pinController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final localizationObj = AppLocalizations.of(context);
    const fillColor = Color(0xffDBD6D3);
    final pageArgus =
        ModalRoute.of(context)!.settings.arguments as Map<String, String>;
    final phoneNumber = pageArgus['phoneNumber'];

    final defaultPinTheme = PinTheme(
      width: 46,
      height: 78,
      textStyle: const TextStyle(
        fontSize: 22,
        color: Color.fromRGBO(30, 60, 87, 1),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
    );
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(
              horizontal: 8,
              vertical: 80,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/splash_image.png',
                  height: 90,
                  width: 90,
                ),
                const SizedBox(
                  height: 40,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8.0,
                    ),
                    child: Text(
                      localizationObj!.registerCode,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                        fontFamily: "Tajawal",
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8.0,
                    ),
                    child: Text(
                      localizationObj.codeSent,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 10,
                        fontFamily: "Tajawal",
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  phoneNumber!,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                    color: Color(0xff2B65F6),
                    fontFamily: "Tajawal",
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Directionality(
                  textDirection: TextDirection.ltr,
                  child: Pinput(
                    controller: pinController,
                    length: 6,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    focusNode: focusNode,
                    defaultPinTheme: defaultPinTheme,
                    onClipboardFound: (_) {
                      // debugPrint('onClipboardFound: $value');
                      // pinController.setText(value);
                    },
                    hapticFeedbackType: HapticFeedbackType.lightImpact,
                    onCompleted: (pin) {
                      debugPrint('onCompleted: ');
                    },
                    onChanged: (value) {
                      debugPrint('onChanged: ');
                    },
                    cursor: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(bottom: 9),
                          width: 22,
                          height: 1,
                        ),
                      ],
                    ),
                    followingPinTheme: defaultPinTheme.copyWith(
                      decoration: defaultPinTheme.decoration!.copyWith(
                        color: fillColor,
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    focusedPinTheme: defaultPinTheme.copyWith(
                      decoration: defaultPinTheme.decoration!.copyWith(
                        borderRadius: BorderRadius.circular(8),
                        color: fillColor,
                      ),
                    ),
                    submittedPinTheme: defaultPinTheme.copyWith(
                      decoration: defaultPinTheme.decoration!.copyWith(
                        color: fillColor,
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    errorPinTheme: defaultPinTheme.copyBorderWith(
                      border: Border.all(color: Colors.redAccent),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                //todo : this is the problem of the OTP
                //! the problem is you call the listener in a new route
                //! which does not include the phone auth bloc
                BlocConsumer<PhoneAuthBloc, PhoneAuthState>(
                  listener: (context, state) {
                    if (state is UserAlreadyRegisteredPhoneState) {
                      context
                          .read<UserDataPreferencesCubit>()
                          .getUserDataPreferences();
                      Navigator.of(context).pushReplacementNamed(
                        NavigationPage.pageRoute,
                        arguments: {
                          'pageIndex': 0,
                        },
                      );
                    } else if (state is NewPhoneUserState) {
                      Navigator.of(context).pushReplacementNamed(
                        PersonalDataScreen.pageRoute,
                        arguments: {
                          'userId': state.userId,
                        },
                      );
                    } else if (state is PhoneSignInErrorState) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('phone sing in error ${state.error}'),
                        ),
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
                      text: localizationObj.registration,
                      filled: true,
                      width: 74,
                      height: 8,
                      onPressed: () {
                        context.read<PhoneAuthBloc>().add(
                              VerifyOtpCodeEvent(
                                code: pinController.value.text,
                                id: phoneNumber,
                              ),
                            );
                      },
                    );
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      localizationObj.codeDidNotArrive,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                        fontFamily: "Tajawal",
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        context.read<PhoneAuthBloc>().add(
                              SendOtpCodeEvent(
                                phoneNumber: phoneNumber,
                              ),
                            );
                        pinController.clear();
                      },
                      child: Text(
                        localizationObj.resendCode,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                          color: Color(0xff2B65F6),
                          fontFamily: "Tajawal",
                        ),
                      ),
                    ),
                  ],
                ),
                Text(
                  localizationObj.or,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                    fontFamily: "Tajawal",
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    localizationObj.registerWithAccount,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                      color: Color(0xff2B65F6),
                      fontFamily: "Tajawal",
                    ),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
