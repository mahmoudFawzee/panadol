// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:panadol/data/constants/enums.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:panadol/logic/blocs/learning_material_bloc/learning_material_bloc.dart';
import 'package:panadol/logic/blocs/learning_material_data_bloc/learning_materials_data_bloc.dart';
import 'package:panadol/logic/blocs/social_auth_bloc/social_auth_bloc.dart';
import 'package:panadol/logic/blocs/user_data_bloc/user_data_bloc.dart';
import 'package:panadol/logic/cubits/navigation_bar_cubit/navigation_bar_cubit.dart';
import 'package:panadol/logic/cubits/user_data_preferences_cubit/user_data_preferences_cubit.dart';
import 'package:panadol/view/screens/home/exams.dart';

import 'package:panadol/view/screens/home/user_account.dart';

import 'learning_material_screen.dart';

class NavigationPage extends StatefulWidget {
  static const pageRoute = "navigation_page";
  const NavigationPage({
    Key? key,
  }) : super(key: key);
  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  final List<Widget> _homeWidgets = [
    const LearningMaterialPage(
      learningMaterialType: LearningMaterialType.course,
    ),
    const LearningMaterialPage(
      learningMaterialType: LearningMaterialType.book,
    ),
    const LearningMaterialPage(
      learningMaterialType: LearningMaterialType.article,
    ),
    const ExamsScreen(),
    const UserAccountScreen(),
  ];
  String? userId;
  String? userCategory;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocBuilder<UserDataPreferencesCubit, UserDataPreferencesState>(
          builder: (context, state) {
        print(state);
        if (state is GotUserIdAndCategoryState) {
          userCategory = state.userCategory;
          userId = state.userId;
          context.read<LearningMaterialBloc>().add(
                GetCategoryMaterialsEvent(
                  learningMaterialType: LearningMaterialType.course,
                  category: state.userCategory,
                ),
              );
          return BlocBuilder<NavigationBarCubit, NavigationBarState>(
            builder: (context, state) {
              if (state is ChangedPageIndexState) {
                return Scaffold(
                  body: _homeWidgets[state.currentIndex],
                  bottomNavigationBar: Builder(builder: (context) {
                    return Container(
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(
                              15,
                            ),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black38,
                              spreadRadius: 0,
                              blurRadius: 2,
                            )
                          ]),
                      child: ClipRRect(
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(
                            15,
                          ),
                        ),
                        child: customBottomNavBar(
                          context,
                          currentPageIndex: state.currentIndex,
                        ),
                      ),
                    );
                  }),
                  floatingActionButtonLocation:
                      FloatingActionButtonLocation.centerFloat,
                  floatingActionButton: myFloatingActionButton(),
                );
              }
              return Scaffold(
                body: _homeWidgets[0],
                bottomNavigationBar: Builder(builder: (context) {
                  return Container(
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(
                            15,
                          ),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black38,
                            spreadRadius: 0,
                            blurRadius: 2,
                          )
                        ]),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(
                          15,
                        ),
                      ),
                      child: customBottomNavBar(
                        context,
                        currentPageIndex: 0,
                      ),
                    ),
                  );
                }),
                floatingActionButtonLocation:
                    FloatingActionButtonLocation.centerFloat,
                floatingActionButton: myFloatingActionButton(),
              );
            },
          );
        } else {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      }),
    );
  }

  BlocBuilder<LearningMaterialBloc, LearningMaterialState>
      myFloatingActionButton() {
    return BlocBuilder<LearningMaterialBloc, LearningMaterialState>(
      builder: (context, state) {
        if (state is GotCategoryMaterialsState) {
          return Container(
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.rectangle,
              border: Border.all(
                color: Colors.black,
                width: .5,
              ),
            ),
            height: 70,
            width: 370,
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Image.network(
                    state.learningMaterial!.first.courseImagePath,
                    width: 108,
                    fit: BoxFit.fitWidth,
                  ),
                ),
                Expanded(
                    flex: 5,
                    child: Row(
                      children: [
                        controlButton(
                          iconPath: 'assets/icons/control icons/remove_15.png',
                          isEditTimeButton: true,
                          onPressed: () {},
                        ),
                        controlButton(
                          iconPath: 'assets/icons/control icons/play.png',
                          isEditTimeButton: false,
                          onPressed: () {},
                        ),
                        controlButton(
                          iconPath: 'assets/icons/control icons/add_15.png',
                          isEditTimeButton: true,
                          onPressed: () {},
                        ),
                        controlButton(
                          iconPath: 'assets/icons/control icons/headPhones.png',
                          isEditTimeButton: false,
                          onPressed: () {},
                        ),
                      ],
                    ))
              ],
            ),
          );
        }
        return Container();
      },
    );
  }

/*
  Builder myBottomNavigationBar() {
    return Builder(builder: (context) {
      return Container(
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(
                15,
              ),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black38,
                spreadRadius: 0,
                blurRadius: 2,
              )
            ]),
        child: ClipRRect(
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(
              15,
            ),
          ),
          child: BlocBuilder<NavigationBarCubit, NavigationBarState>(
            builder: (context, state) {
              print('builder 2 state is $state');
              if (state is ChangedPageIndexState) {
                return customBottomNavBar(
                  context,
                  currentPageIndex: state.currentIndex,
                );
              }
              return customBottomNavBar(
                context,
                currentPageIndex: 0,
              );
            },
          ),
        ),
      );
    });
  }
*/
  BottomNavigationBar customBottomNavBar(
    BuildContext context, {
    required int currentPageIndex,
  }) {
    return BottomNavigationBar(
      onTap: (value) {
        //todo add a event reader for the learning material bloc for each one of the materials
        List<LearningMaterialType> learningMaterialTypes = [
          LearningMaterialType.course,
          LearningMaterialType.book,
          LearningMaterialType.article,
        ];
        print(value);

        if (currentPageIndex != value) {
          if (value < 3) {
            context.read<LearningMaterialBloc>().add(
                  GetCategoryMaterialsEvent(
                    learningMaterialType: learningMaterialTypes[value],
                    category: userCategory!,
                  ),
                );
          } else if (value == 3) {
            //todo this is the calling of user exams
          } else {
            //here value will be 4 which is user account
            //so we must call here the bloc for getting
            //the user data account
            context.read<UserDataBloc>().add(
                  GetProfileDataEvent(userId: userId!),
                );
          }

          context.read<NavigationBarCubit>().changePage(
                pageIndex: value,
              );
        }
      },
      currentIndex: currentPageIndex,
      selectedItemColor: Colors.blue,
      unselectedItemColor: Colors.grey,
      showSelectedLabels: true,
      showUnselectedLabels: true,
      selectedLabelStyle: const TextStyle(
        color: Colors.blue,
        fontFamily: "Tajawal",
        fontSize: 7,
        height: 1.3,
        fontWeight: FontWeight.bold,
      ),
      unselectedLabelStyle: const TextStyle(
        color: Colors.grey,
        fontFamily: "Tajawal",
        fontSize: 7,
        height: 1.3,
        fontWeight: FontWeight.bold,
      ),
      items: [
        BottomNavigationBarItem(
          icon: Image.asset(
            'assets/images/icons/courses.png',
            color:
                currentPageIndex == 0 ? const Color(0xff2B65F6) : Colors.grey,
          ),
          label: 'courses',
        ),
        BottomNavigationBarItem(
          icon: Image.asset(
            'assets/images/icons/books.png',
            color:
                currentPageIndex == 1 ? const Color(0xff2B65F6) : Colors.grey,
          ),
          label: 'books',
        ),
        BottomNavigationBarItem(
          icon: Image.asset(
            'assets/images/icons/articles.png',
            color:
                currentPageIndex == 2 ? const Color(0xff2B65F6) : Colors.grey,
          ),
          label: 'articles',
        ),
        BottomNavigationBarItem(
          icon: Image.asset(
            'assets/images/icons/exams.png',
            color:
                currentPageIndex == 3 ? const Color(0xff2B65F6) : Colors.grey,
          ),
          label: 'exams',
        ),
        BottomNavigationBarItem(
          icon: Image.asset(
            'assets/images/icons/account.png',
            color:
                currentPageIndex == 4 ? const Color(0xff2B65F6) : Colors.grey,
          ),
          label: 'profile',
        ),
      ],
    );
  }

  TextButton controlButton({
    required String iconPath,
    required bool isEditTimeButton,
    required void Function()? onPressed,
  }) {
    return TextButton(
      onPressed: onPressed,
      child: isEditTimeButton
          ? Stack(
              children: [
                Image.asset(
                  iconPath,
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 5.0, left: 2),
                  child: Text(
                    '15',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 9,
                    ),
                  ),
                ),
              ],
            )
          : Image.asset(
              iconPath,
            ),
    );
  }
}


/*
builder: (context, state) {
        print('user data state is $state');
        if (state is GotUserDataState) {
          
          return MultiBlocProvider(
            providers: [
              BlocProvider<LearningMaterialBloc>(
                create: (context) => LearningMaterialBloc()
                  ..add(
                    GetCategoryMaterialsEvent(
                      learningMaterialType: LearningMaterialType.course,
                      category: state.user.studyingCategory,
                    ),
                  ),
              ),

              BlocProvider.value(
                value: BlocProvider.of<UserDataBloc>(context)..add(GetUserDataEvent(id: userId!)),
              ),

              //!we will use this for just sign out
              BlocProvider.value(
                value: BlocProvider.of<SocialAuthBloc>(context),
              ),
            ],
            child: Scaffold(
              body: SafeArea(
                child: BlocBuilder<NavigationBarCubit, NavigationBarState>(
                  builder: (context, state) {
                    if (state is ChangedPageIndexState) {
                      print('state current index ${state.currentIndex}');
                      return _homeWidgets[state.currentIndex];
                    } else {
                      return _homeWidgets[0];
                    }
                  },
                ),
              ),
              bottomNavigationBar: myBottomNavigationBar(),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerFloat,
              floatingActionButton:
                  BlocBuilder<LearningMaterialBloc, LearningMaterialState>(
                builder: (context, state) {
                  if (state is GotCategoryMaterialsState) {
                    return Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.rectangle,
                        border: Border.all(
                          color: Colors.black,
                          width: .5,
                        ),
                      ),
                      height: 70,
                      width: 370,
                      child: Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Image.network(
                              state.learningMaterial!.first.courseImagePath,
                              width: 108,
                              fit: BoxFit.fitWidth,
                            ),
                          ),
                          Expanded(
                              flex: 5,
                              child: Row(
                                children: [
                                  controlButton(
                                    iconPath:
                                        'assets/icons/control icons/remove_15.png',
                                    isEditTimeButton: true,
                                    onPressed: () {},
                                  ),
                                  controlButton(
                                    iconPath:
                                        'assets/icons/control icons/play.png',
                                    isEditTimeButton: false,
                                    onPressed: () {},
                                  ),
                                  controlButton(
                                    iconPath:
                                        'assets/icons/control icons/add_15.png',
                                    isEditTimeButton: true,
                                    onPressed: () {},
                                  ),
                                  controlButton(
                                    iconPath:
                                        'assets/icons/control icons/headPhones.png',
                                    isEditTimeButton: false,
                                    onPressed: () {},
                                  ),
                                ],
                              ))
                        ],
                      ),
                    );
                  }
                  return Container();
                },
              ),
            ),
          );
        
        } else if (state is GotUserProfileDataState) {
          return Scaffold(
            body: SafeArea(
              child: BlocBuilder<NavigationBarCubit, NavigationBarState>(
                builder: (context, state) {
                  if (state is ChangedPageIndexState) {
                    print('state current index ${state.currentIndex}');
                    return _homeWidgets[state.currentIndex];
                  } else {
                    return _homeWidgets[4];
                  }
                },
              ),
            ),
            bottomNavigationBar: myBottomNavigationBar(),
          );
        }
        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      }, */