// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:panadol/logic/blocs/instructor_bloc/instructor_bloc.dart';
import 'package:panadol/logic/blocs/learning_material_bloc/learning_material_bloc.dart';
import 'package:panadol/data/constants/constant.dart';
import 'package:panadol/data/constants/enums.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:panadol/logic/blocs/learning_material_data_bloc/learning_materials_data_bloc.dart';
import 'package:panadol/view/screens/courses_screens/course_details.dart';
import 'package:panadol/view/widgets/courses_forms_data/course_form.dart';

class LearningMaterialPage extends StatelessWidget {
  const LearningMaterialPage({
    Key? key,
    required this.learningMaterialType,
  }) : super(key: key);
  final LearningMaterialType learningMaterialType;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: BlocBuilder<LearningMaterialBloc, LearningMaterialState>(
          builder: (context, state) {
            print(state);
            if (state is GotCategoryMaterialsState) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    decoration: InputDecoration(
                      //TODO : use the translation here
                      hintText: 'search...',
                      constraints: const BoxConstraints(
                        maxHeight: 40,
                      ),
                      contentPadding: const EdgeInsets.only(
                        left: 10,
                        right: 10,
                      ),
                      fillColor: const Color(0xffE5E6F9),
                      filled: true,
                      prefixIconConstraints: const BoxConstraints(
                        minHeight: 40,
                        minWidth: 65,
                      ),
                      prefixIcon: InkWell(
                        onTap: () {},
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color(0xff2B65F6),
                            borderRadius: BorderRadius.circular(
                              30,
                            ),
                          ),
                          child: const Icon(
                            Icons.search,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                          30,
                        ),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    onChanged: (value) {},
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    'most viewed ${materialsTypes[learningMaterialType]}',
                    //here we will show the most viewed courses or books etc...
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  SingleChildScrollView(
                    padding: const EdgeInsets.only(bottom: 10, top: 10),
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: state.learningMaterial!.map((element) {
                        return CourseForm(
                          courseName: element.name,
                          instructorName: element.instructorName,
                          rating: element.rating,
                          numberOfRates: element.numberOfRating,
                          courseImagePath: element.courseImagePath,
                          onTap: () {
                            print(
                              'instructor name is : ${element.instructorName}',
                            );
                            if (learningMaterialType ==
                                LearningMaterialType.course) {
                              context.read<LearningMaterialsDataBloc>().add(
                                    GetCourseEvent(
                                      courseName: element.name,
                                      courseCategory: element.category,
                                    ),
                                  );
                              context
                                  .read<InstructorBloc>()
                                  .add(GetInstructorDataEvent(
                                    instructorName: element.instructorName,
                                  ));
                            } else {
                              context.read<LearningMaterialsDataBloc>().add(
                                    GetBookEvent(
                                      bookId: element.name,
                                      learningMaterialType:
                                          learningMaterialType,
                                    ),
                                  );
                              context
                                  .read<InstructorBloc>()
                                  .add(GetInstructorDataEvent(
                                    instructorName: element.instructorName,
                                  ));
                            }
                            Navigator.of(context)
                                .pushNamed(CourseDetails.pageRoute);
                          },
                        );
                      }).toList(),
                    ),
                  ),
                  Text(
                    'most popular ${materialsTypes[learningMaterialType]}',
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  SingleChildScrollView(
                    padding: const EdgeInsets.only(bottom: 10, top: 10),
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: state.learningMaterial!.map((element) {
                        return CourseForm(
                          courseName: element.name,
                          instructorName: element.instructorName,
                          rating: element.rating,
                          numberOfRates: element.numberOfRating,
                          courseImagePath: element.courseImagePath,
                          onTap: () {
                            if (learningMaterialType ==
                                LearningMaterialType.course) {
                              context.read<LearningMaterialsDataBloc>().add(
                                    GetCourseEvent(
                                      courseName: element.name,
                                      courseCategory: element.category,
                                    ),
                                  );
                              context
                                  .read<InstructorBloc>()
                                  .add(GetInstructorDataEvent(
                                    instructorName: element.instructorName,
                                  ));
                            } else {
                              context.read<LearningMaterialsDataBloc>().add(
                                    GetBookEvent(
                                      bookId: element.name,
                                      learningMaterialType:
                                          learningMaterialType,
                                    ),
                                  );
                              context
                                  .read<InstructorBloc>()
                                  .add(GetInstructorDataEvent(
                                    instructorName: element.instructorName,
                                  ));
                            }
                          },
                        );
                      }).toList(),
                    ),
                  ),
                  Text(
                    'Categories',
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  Wrap(
                    children: mostFamousCategories
                        .map(
                          (category) => InkWell(
                            onTap: () {
                              context.read<LearningMaterialBloc>().add(
                                    GetCategoryMaterialsEvent(
                                      learningMaterialType:
                                          learningMaterialType,
                                      category: category,
                                    ),
                                  );
                              //TODO go to category courses screen ali already made it
                              print(state);
                            },
                            child: Card(
                              margin: const EdgeInsets.all(
                                5,
                              ),
                              shadowColor: Colors.black,
                              color: Colors.white,
                              elevation: 8,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                  30,
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  category,
                                  style: const TextStyle(
                                    color: Color(0xff2B65F6),
                                    fontSize: 9,
                                    height: 4 / 3,
                                    fontFamily: "Tajawal",
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  ),

                  Text(
                    'most rating ${materialsTypes[learningMaterialType]}',
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  //todo show here the most rated courses
                  SingleChildScrollView(
                    padding: const EdgeInsets.only(bottom: 10, top: 10),
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: state.learningMaterial!.map((element) {
                        return CourseForm(
                          courseName: element.name,
                          instructorName: element.instructorName,
                          rating: element.rating,
                          numberOfRates: element.numberOfRating,
                          courseImagePath: element.courseImagePath,
                          onTap: () {
                            if (learningMaterialType ==
                                LearningMaterialType.course) {
                              context.read<LearningMaterialsDataBloc>().add(
                                    GetCourseEvent(
                                      courseName: element.name,
                                      courseCategory: element.category,
                                    ),
                                  );
                              context
                                  .read<InstructorBloc>()
                                  .add(GetInstructorDataEvent(
                                    instructorName: element.instructorName,
                                  ));
                            } else {
                              context.read<LearningMaterialsDataBloc>().add(
                                    GetBookEvent(
                                      bookId: element.name,
                                      learningMaterialType:
                                          learningMaterialType,
                                    ),
                                  );
                              context
                                  .read<InstructorBloc>()
                                  .add(GetInstructorDataEvent(
                                    instructorName: element.instructorName,
                                  ));
                            }
                          },
                        );
                      }).toList(),
                    ),
                  ),
                ],
              );
            } else if (state is GetMaterialsLoadingState) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is GetMaterialsErrorState) {
              return Text(
                state.error,
              );
            } else {
              return const Center(
                child: Text(
                  'some thing went wrong',
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
