// ignore_for_file: depend_on_referenced_packages, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:panadol/data/constants/constant.dart';
import 'package:panadol/data/constants/enums.dart';
import 'package:panadol/data/firebase/models/learning_material.dart';

class LearningMaterialApi {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  //? this is the list which will contain all the materials from firebase
  static List<LearningMaterial> _materials = [];
  //!now when we add the user data we will add the name and
  //!the phone number of the email which he signed in with
  Future<String> addLearningMaterial({
    required LearningMaterial learningMaterial,
  }) async {
    try {
      await firestore
          .collection(learningMaterial.category)
          .doc(learningMaterial.name)
          .set(
            learningMaterial.toFirestoreObj(),
          );
      return 'done';
    } on FirebaseException catch (e) {
      return e.code;
    }
  }

//*we will use this method when user starts the app using his category which he already select before
//*and also when he press category button to get courses in this category
  Future<List<LearningMaterial>> getCategoryLearningMaterialData({
    required String category,
    required LearningMaterialType learningMaterialType,
  }) async {
    String collectionName = materialsTypes[learningMaterialType]!;
    print(collectionName);
    QuerySnapshot<Map<String, dynamic>> userDocumentSnapshot = await firestore
        .collection(collectionName)
        .doc(category)
        .collection(collectionName)
        .get();
    List<QueryDocumentSnapshot<Map<String, dynamic>>> categoryMaterials =
        userDocumentSnapshot.docs;

    List<LearningMaterial> materials = [];
    List<String> names = [
      'smart skills',
      'TFT AGENCY',
      'Nour ALhasan',
      'احمد سليمان',
      'Amir Berkani',
      'المسوق',
      'Eslam Salah - وزير الفيسبوك',
      'محترف ارباح الويب',
    ];
    List<String> ids = [
      'PLOEjzaqMT3fqzusarz8wDN6yFXbAjvyjR',
      'PLO0GfC_g13c-pDS_jCLSVPQCOEAsGppv1',
      'PLHPmz15l3HZDt2h-f5dQVA7jRV2tcRxu6',
      'PLVWAs3Bg8nFkfaN-kQlVzluu7mbtq-pWb',
      'PLuXP0yoPFXA5jg19MceehDTHn3Dhea9gG',
      'PLG4aG8yvgA--4_-2JW8Fw5r9U5RfFUJft',
      'PLG4aG8yvgA--4_-2JW8Fw5r9U5RfFUJft',
      'PLpxZrMfcwQ8HRL8u2nBULLfpuWW-P-azl',
      'PLDTQYUmBXhbl15II5xh6iZB6GwmPPOW6u',


    ];
    for (var material in categoryMaterials) {
      // await firestore
      //     .collection(collectionName)
      //     .doc(category)
      //     .collection(collectionName)
      //     .doc(material.id)
      //     .set(
      //   {
      //     'duration': 50,
      //     'instructor':names[categoryMaterials.indexOf(material)],
      //     'rate': 3.4,
      //     'numberOfRates': 201,
      //     'category': 'Ecommerce & Digital Marketing',
      //     'courseImageUrl':
      //         'https://media.istockphoto.com/id/607285526/de/foto/partner-marketing.jpg?b=1&s=170667a&w=0&k=20&c=veQVt3fuNa5GQ8M0PGvqvEoiak6CzJ3QPOoJLTZ09P0=',
      //     'materialType': 'courses',
      //     'playlistId': ids[categoryMaterials.indexOf(material)],
      //     'name': 'affiliate markiting with ${names[categoryMaterials.indexOf(material)]}',
      //     'description':'course description '
      //   },
      // );
      materials.add(LearningMaterial.fromFirebase(material.data()));
    }
    

    return materials;
  }

//TODO: we use this when user start typing in the text field
  List<LearningMaterial> searchInMaterials({
    required String searchKey,
  }) {
    List<LearningMaterial> searchedMaterialList = _materials.where((material) {
      return material.name.contains(searchKey);
    }).toList();
    return searchedMaterialList;
  }

//we must call this when the user press on the text field to start writing
  Future<void> getAllMaterials() async {
    //*this list will contain all the learning materials which can be
    //*courses or books or articles.
    List<LearningMaterial> courses = await getAllCourses();
    //*this list will contain the books
    List<LearningMaterial> books =
        await _getBooksOrArticlesList(collectionName: 'books');
    //*this list will contain the articles
    List<LearningMaterial> articles =
        await _getBooksOrArticlesList(collectionName: 'articles');
    _materials = [...courses, ...books, ...articles];
  }

  Future<List<LearningMaterial>> getAllCourses() async {
    List<LearningMaterial> myCourses = [];
    for (var category in mostFamousCategories) {
      QuerySnapshot<Map<String, dynamic>> categoryCourses = await firestore
          .collection('courses')
          .doc(category)
          .collection('courses')
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

  Future<List<LearningMaterial>> _getBooksOrArticlesList({
    required String collectionName,
  }) async {
    List<LearningMaterial> materials = [];
    QuerySnapshot<Map<String, dynamic>> firebaseMaterials =
        await firestore.collection(collectionName).get();
    List<QueryDocumentSnapshot<Map<String, dynamic>>> firebaseMaterialsList =
        firebaseMaterials.docs;
    for (var element in firebaseMaterialsList) {
      materials.add(
        LearningMaterial.fromFirebase(
          element.data(),
        ),
      );
    }

    return materials;
  }
}
