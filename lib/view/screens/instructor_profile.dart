import 'package:flutter/material.dart';
import 'package:panadol/data/constants/enums.dart';
import 'package:panadol/data/firebase/models/instructor.dart';
import 'package:panadol/data/firebase/models/learning_material.dart';
import 'package:panadol/logic/blocs/instructor_bloc/instructor_bloc.dart';
import 'package:panadol/logic/blocs/learning_material_data_bloc/learning_materials_data_bloc.dart';
import 'package:panadol/view/screens/courses_screens/course_details.dart';
import 'package:panadol/view/screens/home/navigation.dart';
import 'package:panadol/view/widgets/courses_forms_data/my_courses_form.dart';
import 'package:panadol/view/widgets/custom_buttons/pop_screen_button.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_bloc/flutter_bloc.dart';

class InstructorProfile extends StatefulWidget {
  const InstructorProfile({
    super.key,
  });
  static const pageRoute = "instructor_profile";
  @override
  State<InstructorProfile> createState() => _InstructorProfileState();
}

class _InstructorProfileState extends State<InstructorProfile> {
  @override
  Widget build(BuildContext context) {
    final routeArgus =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    List<LearningMaterial> courses = routeArgus['courses'];
    Instructor instructor = routeArgus['instructor'];
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0.0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        title: const Text(
          'instructor',
          style: TextStyle(
            fontFamily: "Tajawal",
            fontSize: 13,
            height: 3 / 2,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        leading: PopScreenButton(
          textDirection: TextDirection.ltr,
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 1,
                      child: CircleAvatar(
                        radius: 40,
                        backgroundImage: NetworkImage(
                          instructor.profilePhoto,
                        ),
                      ),
                    ),
                    const Spacer(),
                    Expanded(
                      flex: 3,
                      child: RichText(
                        textAlign: TextAlign.end,
                        text: TextSpan(
                          text: '${instructor.name}\n',
                          style:
                              Theme.of(context).textTheme.headline5!.copyWith(
                                    color: const Color(0xff2B65F6),
                                  ),
                          children: <TextSpan>[
                            TextSpan(
                              text: '${instructor.description}\n',
                              style: Theme.of(context).textTheme.headline6,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 100, 0),
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: SizedBox(
                  height: 45,
                  child: Row(
                    children: [
                      Column(
                        children: [
                          RichText(
                              textAlign: TextAlign.end,
                              text: TextSpan(
                                  text: 'اجمالي التقييمات\n',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline6!
                                      .copyWith(
                                        color: const Color(0xff2B65F6),
                                      ),
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: '${instructor.rating}\n',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline6!,
                                    ),
                                  ]))
                        ],
                      ),
                      const SizedBox(
                        width: 30,
                      ),
                      Column(
                        children: [
                          RichText(
                            textAlign: TextAlign.end,
                            text: TextSpan(
                              text: 'اجمالي عدد الطلاب\n',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6!
                                  .copyWith(
                                    color: const Color(0xff2B65F6),
                                  ),
                              children: <TextSpan>[
                                TextSpan(
                                  text: '${instructor.numberOfStudents}\n',
                                  style: Theme.of(context).textTheme.headline6!,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.topRight,
                child: Text(
                  'نبذة عن المحاضر',
                  style: Theme.of(context).textTheme.headline5,
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: Text(
                      instructor.description,
                      style: Theme.of(context).textTheme.headline6!,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.topRight,
                child: Text(
                  'كورسات المحاضر (${courses.length})',
                  style: Theme.of(context).textTheme.headline5,
                ),
              ),
            ),
            //TODO here we will show the instructor courses,

            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: courses.length,
              itemBuilder: (context, index) => MyCourseForm(
                isFavorite: true,
                name: courses[index].name,
                imagePath: courses[index].courseImagePath,
                instructor: courses[index].instructorName,
                numberOfRates: courses[index].numberOfRating,
                rate: courses[index].rating,
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
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    CourseDetails.pageRoute,
                    ModalRoute.withName(
                      NavigationPage.pageRoute,
                    ),
                  );
                },
              iconOnPressed: null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
