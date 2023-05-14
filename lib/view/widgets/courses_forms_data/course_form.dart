import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:panadol/view/widgets/custom_rating_bar.dart';

class CourseForm extends StatelessWidget {
  const CourseForm({
    Key? key,
    required this.courseName,
    required this.instructorName,
    required this.rating,
    required this.numberOfRates,
    required this.courseImagePath,
    required this.onTap,
  }) : super(key: key);
  final String courseName;
  final String instructorName;
  final double rating;
  final int numberOfRates;
  final String courseImagePath;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: InkWell(
        onTap: onTap,
        child: SizedBox(
          //120
          height: height * .2,
          //200
          width: width * .4,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 75,
                width: double.infinity,
                child: Image.network(
                  courseImagePath,
                  fit: BoxFit.fitWidth,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5.0,),
                child: Column(
                  children: [
                    Text(
                      courseName,
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                        fontFamily: "Tajawal",
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        height: 1.4,
                      ),
                    ),
                    Text(
                      instructorName,
                      style: const TextStyle(
                        fontFamily: "Tajawal",
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        height: 1.4,
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          '($numberOfRates)',
                          style: const TextStyle(
                            fontFamily: "Tajawal",
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            height: 1.4,
                          ),
                        ),
                        CustomRatingBar(
                          initialRating: rating,
                          numberOfStars: 5,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
