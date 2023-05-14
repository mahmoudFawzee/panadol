// ignore_for_file: depend_on_referenced_packages

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:panadol/data/firebase/models/learning_material.dart';
import 'package:panadol/logic/blocs/instructor_bloc/instructor_bloc.dart';
import 'package:panadol/logic/blocs/learning_material_data_bloc/learning_materials_data_bloc.dart';
import 'package:panadol/logic/blocs/user_data_bloc/user_data_bloc.dart';
import 'package:panadol/logic/cubits/navigation_bar_cubit/navigation_bar_cubit.dart';
import 'package:panadol/logic/cubits/user_data_preferences_cubit/user_data_preferences_cubit.dart';
import 'package:panadol/view/screens/courses_screens/course_details.dart';
import 'package:panadol/view/screens/home/navigation.dart';
import 'package:panadol/view/widgets/courses_forms_data/my_courses_form.dart';
import 'package:panadol/view/widgets/custom_buttons/pop_screen_button.dart';

import '../../../data/constants/enums.dart';

class MyCoursesScreen extends StatelessWidget {
  const MyCoursesScreen({
    Key? key,
  }) : super(key: key);
  static const pageRoute = 'my_courses_page';
  @override
  Widget build(BuildContext context) {
    final routeArgus =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
        final userId=routeArgus['userId'];

    //? will pop scope let us to manage the back button pressing in our app
    return WillPopScope(
      onWillPop: () async {
        print('button pressed');
        context.read<UserDataBloc>().add(GetProfileDataEvent(userId: userId!));
        context.read<NavigationBarCubit>().changePage(
              pageIndex: 4,
            );
        Navigator.of(context).pushReplacementNamed(
          NavigationPage.pageRoute,
        );
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(
            routeArgus['isFav']! ? 'my favorite courses' : 'my courses',
            style: const TextStyle(
              fontFamily: "Tajawal",
              fontSize: 13,
              height: 3 / 2,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 0,

          leading: PopScreenButton(
            textDirection: TextDirection.ltr,
            onPressed: () {
              context.read<UserDataBloc>().add(GetProfileDataEvent(userId: userId!));
              context.read<NavigationBarCubit>().changePage(
                    pageIndex: 4,
                  );
              Navigator.of(context).pushReplacementNamed(
                NavigationPage.pageRoute,
              );
            },
          ),
        ),
        body: BlocBuilder<UserDataBloc, UserDataState>(
          builder: (context, state) {
            if (state is GotUserFavoritesState) {
              List<LearningMaterial> courses = state.favorites;
              return ListView.builder(
                shrinkWrap: true,
                //todo put the list of items and the length ...
                itemCount: courses.length,
                itemBuilder: (context, index) => MyCourseForm(
                  isFavorite: routeArgus['isFav']!,
                  imagePath: courses[index].courseImagePath,
                  instructor: courses[index].instructorName,
                  name: courses[index].name,
                  rate: courses[index].rating,
                  numberOfRates: courses[index].numberOfRating,
                  onTap: () {
                    if (courses[index].materialType ==
                        LearningMaterialType.course) {
                      context.read<LearningMaterialsDataBloc>().add(
                            GetCourseEvent(
                              courseName: courses[index].name,
                              courseCategory: courses[index].category,
                            ),
                          );
                      context.read<InstructorBloc>().add(GetInstructorDataEvent(
                            instructorName: courses[index].instructorName,
                          ));
                    } else {
                      context.read<LearningMaterialsDataBloc>().add(
                            GetBookEvent(
                              bookId: courses[index].name,
                              learningMaterialType: courses[index].materialType,
                            ),
                          );
                      context.read<InstructorBloc>().add(GetInstructorDataEvent(
                            instructorName: courses[index].instructorName,
                          ));
                    }
                    Navigator.of(context).pushNamed(CourseDetails.pageRoute);
                  },
                  iconOnPressed: () {
                    context.read<UserDataBloc>().add(
                          RemoveFromFavoritesEvent(
                            courseName: courses[index].name,
                            learningMaterialType: courses[index].materialType,
                          ),
                        );
                  },
                ),
              );
            } else if (state is GotUserLearningState) {
              List<LearningMaterial> learningCourses = state.learning;
              return ListView.builder(
                shrinkWrap: true,
                //todo put the list of items and the length ...
                itemCount: learningCourses.length,
                itemBuilder: (context, index) => MyCourseForm(
                  isFavorite: routeArgus['isFav']!,
                  imagePath: learningCourses[index].courseImagePath,
                  instructor: learningCourses[index].instructorName,
                  name: learningCourses[index].name,
                  rate: learningCourses[index].rating,
                  numberOfRates: learningCourses[index].numberOfRating,
                  onTap: () {
                    if (learningCourses[index].materialType ==
                        LearningMaterialType.course) {
                      context.read<LearningMaterialsDataBloc>().add(
                            GetCourseEvent(
                              courseName: learningCourses[index].name,
                              courseCategory: learningCourses[index].category,
                            ),
                          );
                      context.read<InstructorBloc>().add(GetInstructorDataEvent(
                            instructorName:
                                learningCourses[index].instructorName,
                          ));
                    } else {
                      context.read<LearningMaterialsDataBloc>().add(
                            GetBookEvent(
                              bookId: learningCourses[index].name,
                              learningMaterialType:
                                  learningCourses[index].materialType,
                            ),
                          );
                      context.read<InstructorBloc>().add(GetInstructorDataEvent(
                            instructorName:
                                learningCourses[index].instructorName,
                          ));
                    }
                    Navigator.of(context).pushNamed(CourseDetails.pageRoute);
                  },
                  iconOnPressed: null,
                ),
              );
            } else if (state is UserDataErrorState) {
              return Center(
                child: Text(state.error),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
