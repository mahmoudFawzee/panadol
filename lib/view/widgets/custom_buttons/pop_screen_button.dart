import 'package:flutter/material.dart';

class PopScreenButton extends StatelessWidget {
  const PopScreenButton({
    Key? key,
    required this.textDirection,
    required this.onPressed,
  }) : super(key: key);
  final TextDirection textDirection;
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.only(left: 7),
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.3),
              spreadRadius: 1,
              offset: const Offset(0, 1),
              blurRadius: 2,
            ),
          ],
          color: const Color(0xffE5E6F9),
          borderRadius: BorderRadius.circular(
            6,
          ),
        ),
        child: Center(
          child: Directionality(
            textDirection: textDirection,
            child: const Icon(
              Icons.arrow_back_ios,
              size: 15,
              color: Color(0xff2B65F6),
            ),
          ),
        ),
      ),
    );
  }
}
