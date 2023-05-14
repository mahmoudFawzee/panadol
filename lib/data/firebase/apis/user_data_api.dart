// ignore_for_file: depend_on_referenced_packages

import 'package:panadol/data/constants/constant.dart';

import 'package:panadol/data/firebase/models/learning_material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:panadol/data/constants/enums.dart';
import 'package:panadol/data/firebase/models/user.dart';
import 'package:panadol/data/local_data/user_data_preferences.dart';

class UserDataApi {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  static String? userId;

  //!now when we add the user data we will add the name and
  //!the phone number of the email which he signed in with
  //!here we will set the user id if the user exists
  //!if the user is already exists in the firestore we will set
  //!the id and category in the
  //!if the user id new user we will set the id and category in the
  //!addUserData method
  Future<void> addUserDate({
    required MyUser user,
  }) async {
    await firestore.collection('users').doc(user.userId).set(
          user.toFirestoreObj(),
        );

    //TODO we will set the user id in shared_prefs to easy get it any time.
    await UserDataPreferences.setUserId(user.userId);

    //?this is the job user learning for
    //*which will be the category for the initial
    //* learning courses category appear when open the app.
    await UserDataPreferences.setUserCategory(user.studyingCategory);
  }

  Future<bool> isUserExists({required String id}) async {
    List<MyUser> myUsers = [];
    bool isExists = false;
    QuerySnapshot<Map<String, dynamic>> userDocumentSnapshot =
        await firestore.collection("users").get();
    List<QueryDocumentSnapshot<Map<String, dynamic>>> users =
        userDocumentSnapshot.docs;

    for (var user in users) {
      myUsers.add(MyUser.fromFirebase(
        user.data(),
      ));
    }
    // myUsers.forEach((user) async {
    //   if (user.userId == id) {
    //     isExists = true;
    //     await UserDataPreferences.setUserId(user.userId);
    //     await UserDataPreferences.setUserCategory(user.job);
    //   }
    // });

    for (var i = 0; i < myUsers.length; i++) {
      if (myUsers[i].userId == id) {
        isExists = true;
        await UserDataPreferences.setUserId(myUsers[i].userId);
        await UserDataPreferences.setUserCategory(myUsers[i].studyingCategory);
        break;
      }
    }

    return isExists;
  }

  List<String> names = [
    'TFT AGENCY',
    'Nour ALhasan',
    'احمد سليمان',
    'Amir Berkani',
    'المسوق',
    'Eslam Salah - وزير الفيسبوك',
    'محترف ارباح الويب',
  ];
  List<String> images = [
    'https://images.unsplash.com/photo-1503443207922-dff7d543fd0e?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8bWVufGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=500&q=60',
    'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8M3x8bWVufGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=500&q=60',
    'https://images.unsplash.com/photo-1508341591423-4347099e1f19?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NHx8bWVufGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=500&q=60',
    'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Nnx8bWVufGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=500&q=60',
    'https://images.unsplash.com/photo-1492446845049-9c50cc313f00?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8OXx8bWVufGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=500&q=60',
    'https://images.unsplash.com/photo-1499714608240-22fc6ad53fb2?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTB8fG1lbnxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=500&q=60',
    'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTF8fG1lbnxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=500&q=60',
  ];
  Future addInstructors() async {
    for (int i = 0; i < images.length; i++) {
      await firestore.collection('instructors').doc(names[i]).set({
        'description':
            '${names[i]} is a talented person he is graduated from cairo university and have a youtube channel called ${names[i]}',
        'name': names[i],
        'numberOfStudents': i * 90,
        'rate': 1 / (i + 1),
        'profile photo': images[i],
      });
    }
  }

  Future<MyUser?> getUserData({
    required String id,
  }) async {
    DocumentSnapshot<Map<String, dynamic>> userDocumentSnapshot =
        await firestore.collection("users").doc(id).get();
    Map<String, dynamic>? userData = userDocumentSnapshot.data();

    MyUser myUser = MyUser.fromFirebase(
      userData,
    );
    userId = myUser.userId;   
    return myUser;
  }

  Future<void> updateProgress({
    //*progress must be the last video watched
    //*and the last book or article read too
    //*it will be the material name and current position user reach
    //*map<String for the course name or book_name , int for the number of the video or the book sheet number>.
    required String courseName,
    required int currentProgress,
    required LearningMaterialType learningMaterialType,
  }) async {
    await firestore
        .collection('users learning')
        .doc(userId)
        .collection(materialsTypes[learningMaterialType]!)
        .doc(courseName)
        .set({
      'name': courseName,
      'learningType': materialsTypes[learningMaterialType],
      'progress': currentProgress,
    });
  }

  Future<void> addToUserLearningOrFavorites({
    required String courseName,
    required LearningMaterialType learningMaterialType,
    required String collectionName,
  }) async {
    await firestore
        .collection(
          collectionName,
        )
        .doc(userId)
        .collection(materialsTypes[learningMaterialType]!)
        .doc(courseName)
        .set(
      {
        'name': courseName,
        'learningType': materialsTypes[learningMaterialType],
      },
    );
  }

  Future removeFromFavoritesOrUserLearning({
    required String collectionName,
    required LearningMaterialType materialType,
    required String courseName,
  }) async {
    await firestore
        .collection(collectionName)
        .doc(userId)
        .collection(materialsTypes[materialType]!)
        .doc(courseName)
        .delete();
  }

  Future<List<LearningMaterial>> getUserLearningOrFavorites({
    required String collectionName,
  }) async {
    List<LearningMaterial> courses = await _getAllMaterials(
      learningMaterialType: LearningMaterialType.course,
      collectionName: collectionName,
    );
    List<LearningMaterial> books = await _getAllMaterials(
      learningMaterialType: LearningMaterialType.book,
      collectionName: collectionName,
    );
    List<LearningMaterial> articles = await _getAllMaterials(
      learningMaterialType: LearningMaterialType.article,
      collectionName: collectionName,
    );
    return [...courses, ...books, ...articles];
  }

  Future<List<LearningMaterial>> _getAllMaterials({
    required LearningMaterialType learningMaterialType,
    required String collectionName,
  }) async {
    List<LearningMaterial> materialsList = [];
    //?this from the collection user learning
    QuerySnapshot<Map<String, dynamic>> namesAndTypes = await firestore
        .collection(collectionName)
        .doc(userId)
        .collection(materialsTypes[learningMaterialType]!)
        .get();
    List<QueryDocumentSnapshot<Map<String, dynamic>>> data = namesAndTypes.docs;

    //for now we just get the name and type  of the user learning courses.
    for (var item in data) {
      LearningMaterialType learningMaterialType =
          materialsTypes.keys.firstWhere(
        (key) => materialsTypes[key] == item['learningType'],
      );
      LearningMaterial learningMaterial = await _getMaterialWithName(
        name: item['name'],
        learningMaterialType: learningMaterialType,
      );
      materialsList.add(learningMaterial);
    }
    print('materials$materialsList');
    return materialsList;
  }

  Future<LearningMaterial> _getMaterialWithName({
    required String name,
    required LearningMaterialType learningMaterialType,
  }) async {
    LearningMaterial? myLearningMaterial;
    for (var category in mostFamousCategories) {
      QuerySnapshot<Map<String, dynamic>> learningMaterial = await firestore
          .collection(materialsTypes[learningMaterialType]!)
          .doc(category)
          .collection(materialsTypes[learningMaterialType]!)
          .where(
            'name',
            isEqualTo: name,
          )
          .limit(1)
          .get();
      return LearningMaterial.fromFirebase(
        learningMaterial.docs.first.data(),
      );
    }

    return myLearningMaterial!;
  }

  Future<List<String>> getUserLearningCoursesNames({
    required LearningMaterialType learningMaterialType,
  }) async {
    List<String> userLearning = [];
    QuerySnapshot<Map<String, dynamic>> firebaseDocs = await firestore
        .collection(userLearningCollectionName)
        .doc(userId)
        .collection(materialsTypes[learningMaterialType]!)
        .get();
    List<QueryDocumentSnapshot<Map<String, dynamic>>> namesList =
        firebaseDocs.docs;
    for (var element in namesList) {
      userLearning.add(element.data()['name']);
    }
    return userLearning;
  }
}
