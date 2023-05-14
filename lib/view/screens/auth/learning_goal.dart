// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:panadol/view/screens/auth/learning_field.dart';
import 'package:panadol/view/widgets/custom_buttons/custom_elevated_button.dart';

class SelectLearningGoal extends StatefulWidget {
  const SelectLearningGoal({
    Key? key,
  }) : super(key: key);
  static const pageRoute = 'selected_learning_goal_page';

  @override
  State<SelectLearningGoal> createState() => _SelectLearningGoalState();
}

class _SelectLearningGoalState extends State<SelectLearningGoal> {
  //todo: create a method to call the user data event
  //todo : also this will get the email or
  //todo we can get it form the previous page in the constructor
  String selectedLearningGoal = "";

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final localizationObj = AppLocalizations.of(context);
    final List<String> learningGoal = [
      localizationObj!.newJob,
      localizationObj.evoluteInJob,
      localizationObj.becomeAManger,
      localizationObj.gainExperience,
    ];
    final routeArgus =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    //*this id will be the email or the phone number.
    final id = routeArgus['id'];
    final imageUrl = routeArgus['imagePath'];
    final firstName = routeArgus['firstName'];
    final lastName = routeArgus['lastName'];
    return Scaffold(
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        height: double.infinity,
        margin: EdgeInsets.only(
          top: height * (20 / 147),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              localizationObj.learningReason,
              style: const TextStyle(
                fontFamily: "Tajawal",
                fontSize: 15,
                height: (4 / 3),
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              localizationObj.towQuestionsForHelp,
              style: const TextStyle(
                fontFamily: "Tajawal",
                fontSize: 11,
                fontWeight: FontWeight.bold,
                height: (4 / 3),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Text(
              localizationObj.jobGoal,
              style: const TextStyle(
                fontFamily: "Tajawal",
                fontSize: 13,
                height: (4 / 3),
                fontWeight: FontWeight.w800,
              ),
            ),
            myRadio(learningGoal[0]),
            myRadio(learningGoal[1]),
            myRadio(learningGoal[2]),
            myRadio(learningGoal[3]),
          ],
        ),
      ),
      floatingActionButton: CustomElevatedButton(
        text: localizationObj.next,
        filled: true,
        width: 74,
                    height: 8,
        onPressed: () {
          if (selectedLearningGoal != '') {
            Navigator.of(context)
                .pushNamed(SelectedLearningField.pageRoute, arguments: {
              'id': id,
              'imagePath': imageUrl,
              'firstName': firstName,
              'lastName': lastName,
              'learningGoal': selectedLearningGoal,
            });
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('please choose one item'),
              ),
            );
          }
        },
      ),
    );
  }

  Container myRadio(String learningGoal) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 3),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(3),
        border: Border.all(
          width: .5,
        ),
        shape: BoxShape.rectangle,
      ),
      child: RadioListTile<String>(
        value: learningGoal,
        groupValue: selectedLearningGoal,
        onChanged: (value) {
          setState(() {
            selectedLearningGoal = value!;
          });
          print(value);
        },
        title: Text(
          learningGoal,
          style: const TextStyle(
            fontFamily: "Tajawal",
            fontSize: 13,
            height: (4 / 3),
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
    );
  }
}
