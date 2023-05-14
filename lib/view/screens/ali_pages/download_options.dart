import 'package:flutter/material.dart';
import 'package:panadol/view/widgets/custom_buttons/pop_screen_button.dart';

class DownloadOptions extends StatefulWidget {
  const DownloadOptions({super.key});
  static const pageRoute = 'download_options';

  @override
  State<DownloadOptions> createState() => _DownloadOptionsState();
}

class _DownloadOptionsState extends State<DownloadOptions> {
  bool switchValue = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        titleSpacing: 0.0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        title: Transform(
          transform: Matrix4.translationValues(170.0, 0.0, 0.0),
          child: const Text(
            'خيارات التحميل',
            style: TextStyle(
              fontFamily: "Tajawal",
              fontSize: 13,
              height: 3 / 2,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
        leading: PopScreenButton(
          textDirection: TextDirection.ltr,
          onPressed: () {},
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(children: [
          const ListTile(
            leading: Icon(Icons.arrow_back_ios, color: Colors.black),
            title: Align(
              alignment: Alignment.topRight,
              child: Text(
                'جودة تحميل الفيديو',
                style: TextStyle(
                  fontFamily: "Tajawal",
                  fontSize: 13,
                  height: 3 / 2,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            contentPadding: EdgeInsets.only(
              left: 18.0,
            ),
          ),
          Column(
            children: [
              ListTile(
                leading: Switch(
                  value: switchValue,
                  onChanged: (bool value) {
                    setState(() {
                      switchValue = value;
                    });
                  },
                ),
                title: const Align(
                  alignment: Alignment.topRight,
                  child: Text(
                    'WI-FI التنزيل عن طريق ال',
                    style: TextStyle(
                      fontFamily: "Tajawal",
                      fontSize: 13,
                      height: 3 / 2,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                contentPadding: const EdgeInsets.only(
                  left: 5.0,
                ),
              ),
            ],
          ),
        ]),
      ),
    );
  }
}
