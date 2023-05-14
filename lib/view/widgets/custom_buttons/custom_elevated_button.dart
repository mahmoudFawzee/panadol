import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    Key? key,
    required this.text,
    required this.filled,
    required this.height,
    required this.width,
    required this.onPressed,
  }) : super(key: key);
  final String text;
  final bool filled;
  final int width;
  final int height;
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        elevation: MaterialStateProperty.all(0),
        backgroundColor: MaterialStateProperty.all(
          filled
              ? const Color(
                  0xff2B65F6,
                )
              : const Color(
                  0xffE8E9F4,
                ),
        ),
        fixedSize: MaterialStateProperty.all(
          Size(
            screenWidth * (width / 83),
            screenHeight * (height / 147),
          ),
        ),
      ),
      child: Text(
        text,
        style: Theme.of(context).textTheme.headline6!.copyWith(
              color: filled ? Colors.white : Colors.black,
            ),
      ),
    );
  }
}
