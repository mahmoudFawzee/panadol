// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:panadol/logic/blocs/instructor_bloc/instructor_bloc.dart';
import 'package:panadol/logic/blocs/learning_material_bloc/learning_material_bloc.dart';
import 'package:panadol/logic/blocs/learning_material_data_bloc/learning_materials_data_bloc.dart';
import 'package:panadol/logic/blocs/phone_auth_bloc/phone_auth_bloc.dart';
import 'package:panadol/logic/blocs/social_auth_bloc/social_auth_bloc.dart';
import 'package:panadol/logic/blocs/user_data_bloc/user_data_bloc.dart';
import 'package:panadol/logic/cubits/countries_code_cubit/countries_code_cubit.dart';
import 'package:panadol/logic/cubits/image_picker_cubit/image_pick_cubit.dart';
import 'package:panadol/logic/cubits/navigation_bar_cubit/navigation_bar_cubit.dart';
import 'package:panadol/logic/cubits/user_data_preferences_cubit/user_data_preferences_cubit.dart';
import 'package:panadol/logic/cubits/youtube_player_cubit/youtube_player_cubit.dart';
import 'package:panadol/view/screens/ali_pages/category_courses.dart';
import 'package:panadol/view/screens/ali_pages/download_options.dart';
import 'package:panadol/view/screens/ali_pages/exams_screen.dart';
import 'package:panadol/view/screens/ali_pages/quiz.dart';
import 'package:panadol/view/screens/ali_pages/video_playback_options.dart';
import 'package:panadol/view/screens/auth/choose_lang.dart';
import 'package:panadol/view/screens/auth/confirm_data.dart';
import 'package:panadol/view/screens/auth/countries_codes_page.dart';
import 'package:panadol/view/screens/auth/learning_field.dart';
import 'package:panadol/view/screens/auth/learning_goal.dart';
import 'package:panadol/view/screens/auth/otp_screen.dart';
import 'package:panadol/view/screens/auth/personal_data.dart';
import 'package:panadol/view/screens/auth/registration_page.dart';
import 'package:panadol/view/screens/courses_screens/course_details.dart';
import 'package:panadol/view/screens/courses_screens/my_courses.dart';
import 'package:panadol/view/screens/home/exams.dart';
import 'package:panadol/view/screens/home/navigation.dart';
import 'package:panadol/view/screens/instructor_profile.dart';
import 'package:panadol/view/screens/start/splash_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RoutesManger {
  // This widget is the root of your application.
  static final _learningMaterialBloc = LearningMaterialBloc();
  static final _phoneAuthBloc = PhoneAuthBloc();
  static final _socialAuthBloc = SocialAuthBloc();
  static final _userDataBloc = UserDataBloc();
  static final _instructorBloc = InstructorBloc();
  static final _navigationBarCubit = NavigationBarCubit();
  static final _countriesCodeCubit = CountriesCodeCubit();

  Map<String, Widget Function(BuildContext)> routes = {
    SplashScreen.pageRoute: (context) => MultiBlocProvider(
          providers: [
            BlocProvider.value(
              value: _userDataBloc,
            ),
          ],
          child: const SplashScreen(),
        ),
    ChooseLang.pageRoute: (context) => const ChooseLang(),
    SelectLearningGoal.pageRoute: (context) => const SelectLearningGoal(),
    SelectedLearningField.pageRoute: (context) => const SelectedLearningField(),
    ConfirmUserData.pageRoute: (context) => MultiBlocProvider(
          providers: [
            BlocProvider<UserDataBloc>(
              create: (context) => _userDataBloc,
            ),
            BlocProvider<PickImageCubit>(
              create: (context) => PickImageCubit(),
            ),
          ],
          child: const ConfirmUserData(),
        ),
    RegistrationPage.pageRoute: (context) => MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => _countriesCodeCubit,
              child: const CountriesCodesPage(),
            ),
          ],
          child: const RegistrationPage(),
        ),
    CountriesCodesPage.pageRoute: (context) => BlocProvider.value(
          value: _countriesCodeCubit,
          child: const CountriesCodesPage(),
        ),

    OTPScreen.pageRoute: (context) => BlocProvider.value(
          value: _phoneAuthBloc,
          child: const OTPScreen(),
        ),
    PersonalDataScreen.pageRoute: (context) => MultiBlocProvider(
          providers: [
            BlocProvider.value(
              value: _userDataBloc,
            ),
            BlocProvider(
              create: (context) => PickImageCubit(),
            )
          ],
          child: const PersonalDataScreen(),
        ),

    NavigationPage.pageRoute: (context) => MultiBlocProvider(
          providers: [
            BlocProvider.value(
              value: _userDataBloc,
            ),
            BlocProvider.value(
              value: _learningMaterialBloc,
            ),
            BlocProvider.value(
              value: _socialAuthBloc,
            ),
            BlocProvider.value(
              value: _navigationBarCubit,
            ),
            BlocProvider.value(
              value: BlocProvider.of<UserDataPreferencesCubit>(context),
            )
          ],
          child: const NavigationPage(),
        ),

    MyCoursesScreen.pageRoute: (context) => MultiBlocProvider(
          providers: [
            BlocProvider.value(
              value: _userDataBloc,
            ),
            BlocProvider.value(
              value: _navigationBarCubit,
            ),
            BlocProvider.value(
              value: BlocProvider.of<InstructorBloc>(context),
            ),
          ],
          child: const MyCoursesScreen(),
        ),
    CourseDetails.pageRoute: (context) => MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => YoutubePlayerCubit(),
            ),
            BlocProvider.value(
              value: BlocProvider.of<LearningMaterialsDataBloc>(context),
            ),
            BlocProvider.value(
              value: _userDataBloc,
            ),
          ],
          child: const CourseDetails(),
        ),
    InstructorProfile.pageRoute: (context) => MultiBlocProvider(
          providers: [
            BlocProvider.value(
              value: BlocProvider.of<LearningMaterialsDataBloc>(context),
            ),
            BlocProvider.value(
              value: BlocProvider.of<InstructorBloc>(context),
            ),
          ],
          child: const InstructorProfile(),
        ),

    //! ali screens ....
    ExamsScreen.pageRoute: (context) => const ExamsScreen(),
    CategoryCoursesScreen.pageRoute: (context) => const CategoryCoursesScreen(),
    DownloadOptions.pageRoute: (context) => const DownloadOptions(),
    QuizScreen.pageRoute: (context) => const QuizScreen(),
    VideoPlaybackOptions.pageRoute: (context) => const VideoPlaybackOptions(),
    CategoryExamsScreen.pageRoute: (context) => const CategoryExamsScreen(),
  };

  dispose() {
    _learningMaterialBloc.close();
    _phoneAuthBloc.close();
    _socialAuthBloc.close();
    _userDataBloc.close();
    _instructorBloc.close();
    _learningMaterialBloc.close();
    _navigationBarCubit.close();
    _countriesCodeCubit.close();
  }
}
