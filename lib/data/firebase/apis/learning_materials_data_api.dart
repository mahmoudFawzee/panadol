// ignore_for_file: depend_on_referenced_packages

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:panadol/data/constants/enums.dart';
import 'package:panadol/data/firebase/models/book.dart';
import 'package:panadol/data/firebase/models/course.dart';
import 'package:panadol/data/models/video.dart';
import 'package:panadol/data/providers/course_videos_api.dart';

class LearningMaterialsDataApi {
  final firestore = FirebaseFirestore.instance;
  //?course id will be the instructor name and the course name like => courseNameByCourseInstructor
  Future<Course> getCourse({
    required String courseName,
    required String courseCategory,
  }) async {
    print('get course start');
    QuerySnapshot<Map<String, dynamic>> course = await firestore
        .collection('courses')
        .doc(courseCategory)
        .collection('courses')
        .where('name', isEqualTo: courseName)
        .limit(1)
        .get();
    Course firebaseCourse = Course.fromFirebase(
      firebaseObj: course.docs.first.data(),
    );
    List<Video> courseVideos = await _getCourseVideos(
      playlistId: firebaseCourse.playlistId,
    );
    firebaseCourse.videos = courseVideos;
    return firebaseCourse;
  }

  Future<List<Video>> _getCourseVideos({
    required String playlistId,
  }) async {
    final courseVideosApi = CourseVideosApi();
    List<Video> videos = await courseVideosApi.getPlaylistVideos(
      playlistId: playlistId,
    );
    return videos;
  }

  Future<Book> getBook({
    required String bookId,
    required LearningMaterialType learningMaterialType,
  }) async {
    String collectionName = materialsTypes[learningMaterialType]!;
    DocumentSnapshot<Map<String, dynamic>> book =
        await firestore.collection(collectionName).doc(bookId).get();
    return Book.fromFirebase(
      firebaseObj: book.data(),
    );
  }
}
