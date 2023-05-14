// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:panadol/logic/blocs/instructor_bloc/instructor_bloc.dart';
import 'package:panadol/logic/blocs/learning_material_data_bloc/learning_materials_data_bloc.dart';
import 'package:panadol/logic/blocs/user_data_bloc/user_data_bloc.dart';
import 'package:panadol/logic/cubits/youtube_player_cubit/youtube_player_cubit.dart';
import 'package:panadol/view/screens/instructor_profile.dart';
import 'package:panadol/view/widgets/custom_buttons/custom_elevated_button.dart';
import 'package:panadol/view/widgets/custom_buttons/pop_screen_button.dart';
import 'package:panadol/view/widgets/rating_indicator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class CourseDetails extends StatefulWidget {
  const CourseDetails({
    Key? key,
  }) : super(key: key);
  static const pageRoute = 'course_content_page';

  @override
  State<CourseDetails> createState() => _CourseDetailsState();
}

class _CourseDetailsState extends State<CourseDetails> {
  YoutubePlayerController? youtubePlayerController;

  @override
  void dispose() {
    // TODO: implement dispose

    super.dispose();
    youtubePlayerController!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //TODO here from my learning we will show the page with the youtube player
    //and we will start playing it if not from my learning we will just show the course
    //cover and the sections of it and disable the list tiles to not work at all
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return BlocBuilder<LearningMaterialsDataBloc, LearningMaterialsDataState>(
      builder: (context, state) {
        if (state is GotCourseDataState) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              elevation: 0,
              leading: PopScreenButton(
                onPressed: () {
                  if (youtubePlayerController!.value.hasPlayed) {
                    youtubePlayerController!.pause();
                  }
                  Navigator.of(context).pop();
                },
                textDirection: TextDirection.ltr,
              ),
            ),
            body: BlocBuilder<LearningMaterialsDataBloc,
                LearningMaterialsDataState>(
              builder: (context, state) {
                print('state is $state');
                if (state is GotCourseDataState) {
                  final course = state.course;
                  youtubePlayerController = YoutubePlayerController(
                    initialVideoId: course.videos!.first.id,
                    flags: const YoutubePlayerFlags(
                      autoPlay: false,
                    ),
                  );
                  return SafeArea(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          BlocBuilder<YoutubePlayerCubit, YoutubePlayerState>(
                            builder: (context, state) {
                              if (state is GotVideoIdState) {
                                youtubePlayerController!.load(state.videoId);
                                youtubePlayerController!.play();
                                return Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 5),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: YoutubePlayer(
                                      controller: youtubePlayerController!,
                                    ),
                                  ),
                                );
                              } else if (state is GotVideoIdErrorState) {
                                return Center(
                                  child: Text(
                                    state.error,
                                  ),
                                );
                              } else if (state is VideoPlayerLoadingState) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              } else {
                                return Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 5),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: YoutubePlayer(
                                      controller: youtubePlayerController!,
                                    ),
                                  ),
                                );
                              }
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  course.name,
                                  style: Theme.of(context).textTheme.headline5,
                                ),

                                Text(
                                  course.description,
                                  style: Theme.of(context).textTheme.headline6,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),

                                Row(
                                  children: [
                                    Text(
                                      '(${course.numberOfRating})', //*this is the number of ratings
                                      style: const TextStyle(
                                        fontFamily: "Tajawal",
                                        fontSize: 11,
                                        fontWeight: FontWeight.bold,
                                        height: 1.4,
                                      ),
                                    ),
                                    RatingBar(
                                      initialRating: course
                                          .rating, //*this will be the rating as double
                                      direction: Axis.horizontal,
                                      allowHalfRating: true,
                                      itemCount: 5,
                                      itemPadding: const EdgeInsets.symmetric(
                                          horizontal: .5),
                                      itemSize: 15,
                                      ignoreGestures: true,
                                      ratingWidget: RatingWidget(
                                        full: const Icon(
                                          Icons.star,
                                          color: Colors.amber,
                                        ),
                                        empty: const Icon(
                                          Icons.star_outline,
                                          color: Colors.grey,
                                        ),
                                        half: const Icon(
                                          Icons.star_half_outlined,
                                          color: Colors.amber,
                                        ),
                                      ),
                                      updateOnDrag: false,

                                      onRatingUpdate: (_) {},
                                    ),
                                    Text(
                                      '${course.rating}',
                                      style: const TextStyle(
                                        fontFamily: "Tajawal",
                                        fontSize: 11,
                                        fontWeight: FontWeight.bold,
                                        height: 1.4,
                                        color: Colors.amber,
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        course.instructorName,
                                        style: const TextStyle(
                                          fontFamily: "Tajawal",
                                          fontSize: 11,
                                          fontWeight: FontWeight.bold,
                                          height: 1.4,
                                          color: Color(0xff2B65F6),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  'Lectures',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline5!
                                      .copyWith(
                                        color: const Color(
                                          0xff2B65F6,
                                        ),
                                      ),
                                ),
                                //TODO here design the lectures

                                ListView.builder(
                                  itemCount: state.course.videos!.length,
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    return ListTile(
                                      enabled:
                                          index == 0 || state.isInUserLearning,
                                      onTap: () {
                                        print(index == 0);
                                        print(state.isInUserLearning);
                                        context
                                            .read<YoutubePlayerCubit>()
                                            .playVideoEvent(
                                              videoId: state
                                                  .course.videos![index].id,
                                            );
                                      },
                                      contentPadding: const EdgeInsets.all(0),
                                      leading: Text(
                                        'section ${index + 1} :',
                                        style:
                                            index == 0 || state.isInUserLearning
                                                ? Theme.of(context)
                                                    .textTheme
                                                    .headline6!
                                                    .copyWith(
                                                      color: Colors.black,
                                                    )
                                                : Theme.of(context)
                                                    .textTheme
                                                    .headline6,
                                      ),
                                      title: Text(
                                        " ${state.course.videos![index].title}",
                                        style:
                                            index == 0 || state.isInUserLearning
                                                ? Theme.of(context)
                                                    .textTheme
                                                    .headline6!
                                                    .copyWith(
                                                      color: Colors.black,
                                                    )
                                                : Theme.of(context)
                                                    .textTheme
                                                    .headline6,
                                      ),
                                      trailing: Icon(
                                        Icons.play_circle_outline_sharp,
                                        color:
                                            index == 0 || state.isInUserLearning
                                                ? const Color(0xff2B65F6)
                                                : Colors.grey,
                                        size: 15,
                                      ),
                                    );
                                  },
                                ),

                                Visibility(
                                  visible: !state.isInUserLearning,
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          'course description',
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline5,
                                        ),
                                        Text(
                                          course.description,
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline6,
                                        ),
                                        //TODO here get all courses in the same category of this course
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        BlocBuilder<InstructorBloc,
                                            InstructorState>(
                                          builder: (context, state) {
                                            if (state
                                                is GotInstructorDataState) {
                                              final instructor =
                                                  state.instructor;
                                              return Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'instructor',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .headline5,
                                                  ),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  Text(
                                                    instructor.name,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .headline6!
                                                        .copyWith(
                                                          color: const Color(
                                                            0xff2B65F6,
                                                          ),
                                                        ),
                                                  ),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  Row(
                                                    children: [
                                                      CircleAvatar(
                                                        backgroundImage:
                                                            NetworkImage(
                                                          instructor
                                                              .profilePhoto,
                                                        ),
                                                        radius: 40,
                                                      ),
                                                      const SizedBox(
                                                        width: 5,
                                                      ),
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            '${instructor.numberOfStudents} students',
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .headline6!
                                                                .copyWith(
                                                                    color: Colors
                                                                        .black),
                                                          ),
                                                          const SizedBox(
                                                            height: 5,
                                                          ),
                                                          Text(
                                                            'number of courses ${state.courses.length}',
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .headline6!
                                                                .copyWith(
                                                                  color: Colors
                                                                      .black,
                                                                ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  Text(
                                                    instructor.description,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .headline6!
                                                        .copyWith(
                                                          color: Colors.black,
                                                          fontSize: 12,
                                                        ),
                                                  ),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  Center(
                                                    child: ElevatedButton(
                                                      onPressed: () {
                                                        //TODO this will led to the instructor profile page which we'll pass
                                                        //the instructor data and courses as parameters
                                                        Navigator.of(context)
                                                            .pushNamed(
                                                          InstructorProfile
                                                              .pageRoute,
                                                          arguments: {
                                                            'courses':
                                                                state.courses,
                                                            'instructor': state
                                                                .instructor,
                                                          },
                                                        );
                                                      },
                                                      style: ButtonStyle(
                                                        shape:
                                                            MaterialStateProperty
                                                                .all(
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5)),
                                                        ),
                                                        side:
                                                            MaterialStateProperty
                                                                .all(
                                                          const BorderSide(
                                                            color: Colors.black,
                                                            width: 1,
                                                          ),
                                                        ),
                                                        fixedSize:
                                                            MaterialStateProperty
                                                                .all(
                                                          Size(
                                                            width * (74 / 83),
                                                            height * (8 / 147),
                                                          ),
                                                        ),
                                                        backgroundColor:
                                                            MaterialStateProperty
                                                                .all(
                                                          const Color(
                                                              0xffFEF8F4),
                                                        ),
                                                      ),
                                                      child: Text(
                                                        'show profile',
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .headline5,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              );
                                            } else if (state
                                                is GotInstructorDataErrorState) {
                                              return Text(
                                                state.error,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline6!
                                                    .copyWith(
                                                        color: Colors.black),
                                              );
                                            }
                                            return Container();
                                          },
                                        ),
                                        Column(
                                          children: const [
                                            RatingIndicator(
                                              numberOfRates: 4.3,
                                              numberOfStars: 5,
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            RatingIndicator(
                                              numberOfRates: 3,
                                              numberOfStars: 4,
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            RatingIndicator(
                                              numberOfRates: 2,
                                              numberOfStars: 3,
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            RatingIndicator(
                                              numberOfRates: 1,
                                              numberOfStars: 2,
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            RatingIndicator(
                                              numberOfRates: 5,
                                              numberOfStars: 1,
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                          ],
                                        ),

                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          'students rating',
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline6!
                                              .copyWith(color: Colors.black),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),

                                        Text(
                                          '${course.rating} course rating',
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline5,
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),

                                        BlocListener<UserDataBloc,
                                            UserDataState>(
                                          listener: (context, state) {
                                            // TODO: implement listener
                                            if (state
                                                is AddedToFavoritesState) {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                const SnackBar(
                                                  content: Text(
                                                    'added to favorites',
                                                  ),
                                                ),
                                              );
                                            } else if (state
                                                is AddedToUserLearningState) {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                const SnackBar(
                                                  content: Text(
                                                    'added to you learning',
                                                  ),
                                                ),
                                              );
                                            } else if (state
                                                is UserDataErrorState) {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                SnackBar(
                                                  content: Text(
                                                    state.error,
                                                  ),
                                                ),
                                              );
                                            } else {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                const SnackBar(
                                                  content: Text(
                                                    'adding the course...',
                                                  ),
                                                ),
                                              );
                                            }
                                          },
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              CustomElevatedButton(
                                                text: 'start',
                                                filled: true,
                                                width: 37,
                                                height: 8,
                                                onPressed: () {
                                                  //TODO it will call the event of add to user learing
                                                  context
                                                      .read<UserDataBloc>()
                                                      .add(
                                                        AddToUserLearningEvent(
                                                          courseName:
                                                              state.course.name,
                                                          learningMaterialType:
                                                              state.course
                                                                  .materialType,
                                                        ),
                                                      );
                                                },
                                              ),
                                              CustomElevatedButton(
                                                text: 'add to favorites',
                                                filled: false,
                                                width: 37,
                                                height: 8,
                                                onPressed: () {
                                                  //TODO it will call the event of add to user learing
                                                  context
                                                      .read<UserDataBloc>()
                                                      .add(
                                                        AddToFavoritesEvent(
                                                          courseName:
                                                              state.course.name,
                                                          learningMaterialType:
                                                              state.course
                                                                  .materialType,
                                                        ),
                                                      );
                                                },
                                              ),
                                            ],
                                          ),
                                        ),
                                      ]),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                } else if (state is GotLearningMaterialErrorState) {
                  return Scaffold(
                    body: Center(
                      child: Text(
                        state.error,
                      ),
                    ),
                  );
                } else if (state is GotBookDataState) {
                  return Scaffold(
                    body: Center(
                      child: Text(
                        state.book.name,
                      ),
                    ),
                  );
                }
                return const Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              },
            ),
          );
        } else if (state is GotBookDataState) {
          Scaffold(
            body: Center(
              child: Text(state.book.name),
            ),
          );
        } else if (state is GotLearningMaterialErrorState) {
          return Scaffold(
            body: Center(
              child: Text(
                state.error,
              ),
            ),
          );
        }
        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
