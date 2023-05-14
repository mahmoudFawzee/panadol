// ignore_for_file: depend_on_referenced_packages, avoid_print

import 'package:flutter/material.dart';
import 'package:panadol/logic/cubits/localization_cubit/localization_cubit.dart';
import 'package:panadol/view/screens/auth/registration_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChooseLang extends StatelessWidget {
  const ChooseLang({Key? key}) : super(key: key);
  static const pageRoute = 'choose_lang_page';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              flex: 10,
              child: Image.asset(
                'assets/images/splash_image.png',
              ),
            ),
            Expanded(
              flex: 2,
              child: BlocListener<LocalizationCubit, LocalizationState>(
                listener: (context, state) {
                  if (state is ChangeLanguageState) {
                    Navigator.of(context).pushReplacementNamed(
                      RegistrationPage.pageRoute,
                    );
                  }
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextButton(
                      onPressed: () {
                        context
                            .read<LocalizationCubit>()
                            .changLang(newLangCode: 'ar');
                      },
                      child: const Text(
                        '🇸🇦   العربية',
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Tajawal',
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const Divider(
                      height: 1,
                      thickness: 1,
                    ),
                    TextButton(
                      onPressed: () {
                        context
                            .read<LocalizationCubit>()
                            .changLang(newLangCode: 'en');
                      },
                      child: const Text(
                        '🇺🇸  english',
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Tajawal',
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
