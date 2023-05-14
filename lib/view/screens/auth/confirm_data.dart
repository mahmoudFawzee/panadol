// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:panadol/data/local_data/user_data_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:panadol/logic/blocs/user_data_bloc/user_data_bloc.dart';
import 'package:panadol/data/firebase/models/user.dart';
import 'package:panadol/logic/cubits/image_picker_cubit/image_pick_cubit.dart';
import 'package:panadol/logic/cubits/user_data_preferences_cubit/user_data_preferences_cubit.dart';
import 'package:panadol/view/screens/auth/learning_field.dart';
import 'package:panadol/view/screens/auth/learning_goal.dart';
import 'package:panadol/view/screens/home/navigation.dart';
import 'package:panadol/view/widgets/custom_buttons/custom_elevated_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:panadol/view/widgets/custom_buttons/pop_screen_button.dart';

class ConfirmUserData extends StatelessWidget {
  const ConfirmUserData({
    Key? key,
  }) : super(key: key);
  static const pageRoute = 'confirm_user_data_page';

  @override
  Widget build(BuildContext context) {
    final localizationObj = AppLocalizations.of(context);
    final routeArgus =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    //*this id will be the email or the phone number.
    final id = routeArgus['id'];
    final imagePath = routeArgus['imagePath'];
    final firstName = routeArgus['firstName'];
    final lastName = routeArgus['lastName'];
    final learningGoal = routeArgus['learningGoal'];
    final jobField = routeArgus['jobField'];
    bool isUserDataLoading = false;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  PopScreenButton(
                    textDirection: TextDirection.ltr,
                    onPressed: () => Navigator.pop(context),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  const Text(
                    'your answers',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                      height: 4 / 3,
                      fontFamily: "Tajawal,",
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Text(
                localizationObj!.jobGoal,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w800,
                  height: 4 / 3,
                  fontFamily: "Tajawal,",
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    jobField,
                    style: const TextStyle(
                      fontFamily: "Tajawal",
                      fontWeight: FontWeight.bold,
                      fontSize: 12.5,
                    ),
                  ),
                  TextButton(
                    onPressed: () => Navigator.pushReplacementNamed(
                      context,
                      SelectedLearningField.pageRoute,
                      arguments: {
                        'id': id,
                        'firstName': firstName,
                        'lastName': lastName,
                        'imagePath': imagePath,
                        'learningGoal': learningGoal,
                      },
                    ),
                    child: Text(
                      localizationObj.edit,
                      style: const TextStyle(
                        color: Color(
                          0xff2B65F6,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                localizationObj.learningReason,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w800,
                  height: 4 / 3,
                  fontFamily: "Tajawal,",
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    learningGoal,
                    style: const TextStyle(
                      fontFamily: "Tajawal",
                      fontWeight: FontWeight.bold,
                      fontSize: 12.5,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(
                        context,
                        SelectLearningGoal.pageRoute,
                        arguments: {
                          'id': id,
                          'firstName': firstName,
                          'lastName': lastName,
                          'imagePath': imagePath,
                        },
                      );
                    },
                    child: Text(
                      localizationObj.edit,
                      style: const TextStyle(
                        color: Color(
                          0xff2B65F6,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: BlocListener<UserDataBloc, UserDataState>(
        listener: (context, state) {
          // TODO: implement listener
          if (state is NewUserDataPushedState) {
            context.read<UserDataPreferencesCubit>().getUserDataPreferences();
            Navigator.of(context)
                .pushReplacementNamed(NavigationPage.pageRoute, arguments: {
              'pageIndex': 0,
            });
          } else if (state is PushUserDataErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('user data error : ${state.error}'),
              ),
            );
          }
        },
        child: BlocConsumer<PickImageCubit, PickImageState>(
          listener: (context, state) async {
            print(state);
            if (state is GotProfileImageUrlState) {
              //here we will push the user data to the firebase
              MyUser myUser = MyUser(
                profileImageUrl: state.imageUrl,
                firstName: firstName,
                lastName: lastName,
                learningGoal: learningGoal,
                studyingCategory: jobField,
                userId: id,
              );
              context.read<UserDataBloc>().add(
                    PushUserDataEvent(myUser: myUser),
                  );
            } else if (state is ProfileImageUploadedState) {
              context.read<PickImageCubit>().getUrlEvent(
                    userId: id,
                  );
            } else if (state is ProfileImageUploadError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'profile image upload error : ${state.error}',
                  ),
                ),
              );
            } else if (state is NoImagePickedState) {
              //here we will push the user data to the firebase
              MyUser myUser = MyUser(
                profileImageUrl: null,
                firstName: firstName,
                lastName: lastName,
                learningGoal: learningGoal,
                studyingCategory: jobField,
                userId: id,
              );
              context.read<UserDataBloc>().add(
                    PushUserDataEvent(myUser: myUser),
                  );
              context.read<UserDataPreferencesCubit>().getUserDataPreferences();
            }
          },
          builder: (context, state) {
            if (state is ProfileImageUploadLoadingState || isUserDataLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            return CustomElevatedButton(
              text: localizationObj.next,
              filled: true,
              width: 74,
              height: 8,
              onPressed: () async {
                //TODO here we need to push the image url to the firebase.
                context.read<PickImageCubit>().uploadProfileImageEvent(
                      userId: id,
                      imagePath: imagePath,
                    );
              },
            );
          },
        ),
      ),
    );
  }
}
