import 'package:flutter/material.dart';
import 'package:panadol/data/constants/constant.dart';
import 'package:panadol/view/widgets/ali_widgets/design_cources.dart';
import 'package:panadol/view/widgets/custom_buttons/pop_screen_button.dart';

class CategoryCoursesScreen extends StatefulWidget {
  const CategoryCoursesScreen({super.key});
  static const pageRoute = 'category_courses';

  @override
  State<CategoryCoursesScreen> createState() => _CategoryCoursesScreenState();
}

class _CategoryCoursesScreenState extends State<CategoryCoursesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: PopScreenButton(
          textDirection: TextDirection.ltr,
          onPressed: () {},
        ),
        title: const Text(
          'Design',
          style: TextStyle(
            fontFamily: "Tajawal",
            fontSize: 25,
            height: 3 / 2,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: const [
                  Text(
                    'كورسات التصميم',
                    style: TextStyle(
                      fontFamily: "Tajawal",
                      fontSize: 16,
                      height: 3 / 2,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  )
                ],
              ),
            ),
            const DesignWidget(),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: const [
                  Text(
                    'أكثر المواضيع الشائعه',
                    style: TextStyle(
                      fontFamily: "Tajawal",
                      fontSize: 16,
                      height: 3 / 2,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  )
                ],
              ),
            ),
            Wrap(
              children: mostFamousCategories
                  .map(
                    (category) => InkWell(
                      onTap: () {},
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
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: const [
                  Text(
                    'أشهر المحاضرين',
                    style: TextStyle(
                      fontFamily: "Tajawal",
                      fontSize: 16,
                      height: 3 / 2,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  )
                ],
              ),
            ),
            GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 6,
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 11 / 11,
                mainAxisSpacing: 0,
                crossAxisSpacing: 32,
              ),
              itemBuilder: (BuildContext context, int index) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Expanded(
                      child: CircleAvatar(
                        radius: 40,
                        backgroundImage: AssetImage(
                          'assets/images/pages/image.jpeg',
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          RichText(
                            text: const TextSpan(
                                text: 'DR Talat Shaltot \n',
                                style: TextStyle(
                                    fontFamily: "Tajawal",
                                    fontSize: 9,
                                    fontWeight: FontWeight.bold,
                                    height: 1.4,
                                    color: Colors.blue),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: 'User Experience Design, User\n',
                                    style: TextStyle(
                                        fontFamily: "Tajawal",
                                        fontSize: 9,
                                        fontWeight: FontWeight.bold,
                                        height: 1.4,
                                        color: Colors.black),
                                  ),
                                  TextSpan(
                                    text: 'Interface\n',
                                    style: TextStyle(
                                        fontFamily: "Tajawal",
                                        fontSize: 9,
                                        fontWeight: FontWeight.bold,
                                        height: 1.4,
                                        color: Colors.black),
                                  ),
                                  TextSpan(
                                    text: ' عدد الكورسات:9\n ',
                                    style: TextStyle(
                                        fontFamily: "Tajawal",
                                        fontSize: 9,
                                        fontWeight: FontWeight.bold,
                                        height: 1.4,
                                        color: Colors.black),
                                  ),
                                  TextSpan(
                                    text: 'طالب 2,290',
                                    style: TextStyle(
                                        fontFamily: "Tajawal",
                                        fontSize: 9,
                                        fontWeight: FontWeight.bold,
                                        height: 1.4,
                                        color: Colors.black),
                                  ),
                                ]),
                          )
                        ],
                      ),
                    ),
                  ],
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
