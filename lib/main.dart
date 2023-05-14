// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:panadol/firebase_options.dart';
import 'package:panadol/logic/cubits/localization_cubit/localization_cubit.dart';
import 'package:panadol/view/routes/routes_manger.dart';
import 'package:panadol/view/screens/start/splash_screen.dart';
import 'package:panadol/view/theme/app_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  final prefs = await SharedPreferences.getInstance();
  String? lang = prefs.getString('lang');
  if (lang == null) {
    lang = 'en';
    runApp(MyApp(lang: lang));
  } else {
    runApp(MyApp(lang: lang));
  }
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key, required this.lang}) : super(key: key);
  final String lang;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _routesManger = RoutesManger();
  @override
  void dispose() {
    _routesManger.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LocalizationCubit>(
          create: (context) => LocalizationCubit(langCode: widget.lang),
        ),
      ],
      child: BlocBuilder<LocalizationCubit, LocalizationState>(
        builder: (context, state) {
          if (state is ChangeLanguageState) {
            return MyMaterialApp(
              langCode: state.newLang,
              routesManger: _routesManger,
            );
          } else {
            return MyMaterialApp(
              langCode: widget.lang,
              routesManger: _routesManger,
            );
          }
        },
      ),
    );
  }
}

class MyMaterialApp extends StatelessWidget {
  const MyMaterialApp({
    Key? key,
    required this.langCode,
    required this.routesManger,
  }) : super(key: key);

  final String langCode;
  final RoutesManger routesManger;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: Locale(langCode),
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      theme: AppTheme.getLightTheme(),
      supportedLocales: const [
        Locale('en', ''), // English, no country code
        Locale('ar', ''), // arabic, no country code
      ],
      initialRoute: SplashScreen.pageRoute,
      routes: routesManger.routes,
    );
  }
}
