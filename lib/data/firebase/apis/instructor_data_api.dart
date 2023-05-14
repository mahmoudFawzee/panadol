// ignore_for_file: depend_on_referenced_packages

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:panadol/data/constants/constant.dart';
import 'package:panadol/data/firebase/models/instructor.dart';
import 'package:panadol/data/firebase/models/learning_material.dart';

class InstructorDataApi {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  Future<Instructor> getInstructorData({
    required instructorName,
  }) async {
    DocumentSnapshot<Map<String, dynamic>> firebaseInstructors = await firestore
        .collection('instructors')
        .doc(
          instructorName,
        )
        .get();
    return Instructor.fromFirebase(
      firebaseObj: firebaseInstructors.data()!,
    );
  }

  Future<List<LearningMaterial>> getInstructorCourses({
    required String instructorName,
  }) async {
    List<LearningMaterial> myCourses = [];
    print('instructor name : $instructorName');
    for (var category in mostFamousCategories) {
      print(category);
      QuerySnapshot<Map<String, dynamic>> categoryCourses = await firestore
          .collection('courses')
          .doc(category)
          .collection('courses')
          .where(
            'instructor',
            isEqualTo: instructorName,
          )
          .get();
      List<QueryDocumentSnapshot<Map<String, dynamic>>> firebaseCourses =
          categoryCourses.docs;
      for (var element in firebaseCourses) {
        myCourses.add(
          LearningMaterial.fromFirebase(
            element.data(),
          ),
        );
      }
    }
    return myCourses;
  }
}
