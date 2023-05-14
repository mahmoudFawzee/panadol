// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:panadol/logic/cubits/user_data_preferences_cubit/user_data_preferences_cubit.dart';
import 'package:panadol/view/screens/auth/choose_lang.dart';
import 'package:panadol/view/screens/home/navigation.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);
  static const pageRoute = 'splash_screen';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(
      const Duration(
        seconds: 2,
      ),
      () {
        context.read<UserDataPreferencesCubit>().getUserId();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserDataPreferencesCubit, UserDataPreferencesState>(
      listener: (context, state) {
        //print(state);
        if (state is NoUserIdState) {
          Navigator.of(context).pushReplacementNamed(
            ChooseLang.pageRoute,
          );
        } else if (state is GotUserIdState) {
          context.read<UserDataPreferencesCubit>().getUserDataPreferences();
          Navigator.of(context).pushReplacementNamed(
            NavigationPage.pageRoute,
            arguments: {
              'pageIndex': 0,
            },
          );
        }
      },
      child: Scaffold(
        body: Center(
          child: Image.asset(
            'assets/images/splash_image.png',
          ),
        ),
      ),
    );
  }
}
