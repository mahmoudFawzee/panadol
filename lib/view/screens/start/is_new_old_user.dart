import 'package:flutter/material.dart';
import 'package:panadol/view/widgets/custom_buttons/custom_elevated_button.dart';

class IsNewOrOldUser extends StatelessWidget {
  const IsNewOrOldUser({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Align(
              alignment: Alignment.center,
              child: Column(
                children: [
                  Image.asset(
                    'assets/images/splash_image.png',
                  ),
                  const Text(
                    'Panadol',
                    style: TextStyle(
                      fontFamily: 'Tajawal',
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff2B65F6),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    'Dear Me One Day I will Make\nYou Proud',
                    style: TextStyle(
                      fontFamily: 'Tajawal',
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff0E0D11),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Column(
                children: [
                  CustomElevatedButton(
                    text: 'انشاء حساب',
                    filled: true,
                    width: 74,
                    height: 8,
                    onPressed: () {},
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomElevatedButton(
                    text: 'لدي حساب بالفعل',
                    filled: false,
                    width: 74,
                    height: 8,
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
