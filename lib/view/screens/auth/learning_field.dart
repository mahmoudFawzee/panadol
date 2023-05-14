import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:panadol/data/constants/constant.dart';
import 'package:panadol/view/screens/auth/confirm_data.dart';
// ignore: depend_on_referenced_packages

// ignore: must_be_immutable
class SelectedLearningField extends StatelessWidget {
  const SelectedLearningField({Key? key}) : super(key: key);
  static const pageRoute = 'selected_learning_field_page';

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final localizationObj = AppLocalizations.of(context);
    final routeArgus =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    //*this id will be the email or the phone number.
    final id = routeArgus['id'];
    final imagePath = routeArgus['imagePath'];
    final firstName = routeArgus['firstName'];
    final lastName = routeArgus['lastName'];
    final learningGoal = routeArgus['learningGoal'];
    return Scaffold(
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        height: double.infinity,
        margin: EdgeInsets.only(
          top: height * (10 / 147),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                localizationObj!.jobGoal,
                style: const TextStyle(
                  fontSize: 15,
                  fontFamily: 'Tajawal',
                  fontWeight: FontWeight.w800,
                  height: 4 / 3,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                onChanged: (value) {
                  print(value);
                },
                decoration: InputDecoration(
                  focusColor: null,
                  constraints: const BoxConstraints(
                    maxHeight: 30,
                  ),
                  contentPadding: const EdgeInsets.only(
                    top: 4,
                  ),
                  fillColor: const Color(0xffE5E6F9),
                  hintText: localizationObj.jobSearch,
                  prefixIcon: const Icon(
                    Icons.search,
                    color: Colors.black,
                  ),
                  filled: true,
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                  border: const OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              Text(
                localizationObj.mostFamous,
                style: const TextStyle(
                  fontSize: 15,
                  fontFamily: 'Tajawal',
                  fontWeight: FontWeight.w800,
                  height: 4 / 3,
                ),
              ),
              ListView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: mostFamousCategories
                    .map(
                      (item) => jobItem(
                        context: context,
                        jobFieldName: item,
                        userId: id,
                        firstName: firstName,
                        lastName: lastName,
                        learningGoal: learningGoal,
                        imagePath: imagePath,
                      ),
                    )
                    .toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  ListTile jobItem({
    required BuildContext context,
    required String jobFieldName,
    required String userId,
    required String firstName,
    required String lastName,
    required String? imagePath,
    required String learningGoal,
  }) {
    return ListTile(
      onTap: () {
        print('learning field page image path :$imagePath');
        Navigator.of(context).pushNamed(ConfirmUserData.pageRoute, arguments: {
          'id': userId,
          'imagePath': imagePath,
          'firstName': firstName,
          'lastName': lastName,
          'learningGoal': learningGoal,
          'jobField': jobFieldName,
        });
      },
      leading: Text(
        jobFieldName,
        style: const TextStyle(
          fontSize: 12.5,
          fontFamily: "Tajawal",
          fontWeight: FontWeight.bold,
          color: Colors.black,
          height: 1.4,
        ),
      ),
      trailing: const Icon(
        Icons.arrow_forward_ios,
        size: 15,
        color: Colors.black,
      ),
    );
  }
}
