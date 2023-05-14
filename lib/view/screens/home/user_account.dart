// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:panadol/logic/blocs/social_auth_bloc/social_auth_bloc.dart';
import 'package:panadol/logic/blocs/user_data_bloc/user_data_bloc.dart';
import 'package:panadol/logic/cubits/user_data_preferences_cubit/user_data_preferences_cubit.dart';
import 'package:panadol/view/screens/auth/registration_page.dart';
import 'package:panadol/view/screens/courses_screens/my_courses.dart';

class UserAccountScreen extends StatefulWidget {
  const UserAccountScreen({Key? key}) : super(key: key);

  @override
  State<UserAccountScreen> createState() => _UserAccountScreenState();
}

class _UserAccountScreenState extends State<UserAccountScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserDataBloc, UserDataState>(
      builder: (context, state) {
        if (state is GotUserProfileDataState) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'my account',
                  style: TextStyle(
                    fontFamily: "Tajawal",
                    fontWeight: FontWeight.w800,
                    color: Colors.black,
                    fontSize: 13,
                    height: 3 / 2,
                  ),
                ),

                Center(
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundImage: NetworkImage(
                          state.imageUrl,
                        ),
                      ),
                      Text(
                        state.userName,
                        style: const TextStyle(
                          fontFamily: "Tajawal",
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          height: 3 / 2,
                        ),
                      ),
                      Text(
                        state.userId,
                        style: const TextStyle(
                          fontFamily: "Tajawal",
                          fontWeight: FontWeight.bold,
                          color: Color(0xff2B65F6),
                          fontSize: 12,
                          height: 3 / 2,
                        ),
                      ),
                    ],
                  ),
                ),

                textHeader(text: 'my info'),

                myListTileElement(
                    leading: 'learning passes',
                    //todo this will led to my courses page and isFav will false
                    onTap: () {
                      context.read<UserDataBloc>().add(GetUserLearningEvent());
                      Navigator.of(context).pushNamed(
                        MyCoursesScreen.pageRoute,
                        arguments: {
                          'isFav': false,
                          'userId': state.userId,
                        },
                      );
                    }),

                myListTileElement(
                    leading: 'fav elements list',
                    //todo this will led to my courses page and isFav will true
                    onTap: () {
                      context.read<UserDataBloc>().add(GetFavoritesEvent());
                      Navigator.of(context)
                          .pushNamed(MyCoursesScreen.pageRoute, arguments: {
                        'isFav': true,
                        'userId': state.userId,
                      });
                    }),

                textHeader(
                  text: 'video settings',
                ),
                myListTileElement(
                  leading: 'download options',
                  onTap: () {},
                ),
                myListTileElement(
                  leading: 'play video settings',
                  onTap: () {},
                ),
                myListTileElement(
                  leading: 'my courses',
                  onTap: () {},
                ),
                //**********************************************************
                textHeader(text: 'account settings'),
                myListTileElement(
                  leading: 'gmail notifications',
                  onTap: () {},
                ),
                myListTileElement(
                  leading: 'app settings',
                  onTap: () {},
                ),
                myListTileElement(
                  leading: 'account safety',
                  onTap: () {},
                ),
                myListTileElement(
                  leading: 'close account',
                  onTap: () {},
                ),
                textHeader(text: 'support'),
                myListTileElement(
                  leading: 'about panadol',
                  onTap: () {},
                ),
                myListTileElement(
                  leading: 'help and support',
                  onTap: () {},
                ),
                myListTileElement(
                  leading: 'share app ',
                  onTap: () {},
                ),
                Center(
                  child: BlocConsumer<SocialAuthBloc, SocialAuthState>(
                    listener: (context, state) {
                      if (state is SignOutSuccessfullyState) {
                        context
                            .read<UserDataPreferencesCubit>()
                            .removedUserDataPreferences();
                        Navigator.of(context).pushReplacementNamed(
                          RegistrationPage.pageRoute,
                        );
                      } else if (state is SignOutErrorState) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text('Sign out error : ${state.error}')));
                      }
                    },
                    builder: (context, state) {
                      if (state is SocialAuthLoadingState) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      return TextButton(
                        onPressed: () => context.read<SocialAuthBloc>().add(
                              SignOutEvent(),
                            ),
                        child: const Text(
                          'Sign out',
                          style: TextStyle(
                            color: Color(0xff2B65F6),
                            fontSize: 19,
                            height: 3 / 2,
                            fontFamily: 'Tajawal',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(
                  height: 80,
                )
              ],
            ),
          );
        } else if (state is UserDataErrorState) {
          return Center(
            child: Text(state.error),
          );
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  Text textHeader({
    required String text,
  }) {
    return Text(
      text,
      style: TextStyle(
        fontFamily: "Tajawal",
        fontSize: 11,
        fontWeight: FontWeight.bold,
        height: 3 / 2,
        color: Colors.black.withOpacity(
          .5,
        ),
      ),
    );
  }

  Builder myListTileElement({
    required String leading,
    required void Function()? onTap,
  }) {
    return Builder(builder: (context) {
      return ListTile(
        onTap: onTap,
        leading: Text(
          leading,
          style: const TextStyle(
            fontFamily: "Tajawal",
            fontWeight: FontWeight.w800,
            color: Colors.black,
            fontSize: 13,
            height: 3 / 2,
          ),
        ),
        trailing: const Icon(
          Icons.arrow_forward_ios,
          color: Colors.black,
          size: 13,
        ),
      );
    });
  }
}
