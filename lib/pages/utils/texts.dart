import 'package:flutter/material.dart';
import 'package:sky_city_quiz/pages/utils/colors.dart';

Widget buildtext(BuildContext context, String text, Color color) {
  return Align(
    child: Text(
      text,
      textAlign: TextAlign.left,
      maxLines: 4,
      style: TextStyle(
          fontFamily: "Inter",
          fontSize: 20,
          fontWeight: FontWeight.w400,
          color: color),
    ),
  );
}

Widget buildApbartext(BuildContext context, String text) {
  return Text(
    text,
    style: TextStyle(
        fontFamily: "Inria",
        fontSize: 18,
        fontWeight: FontWeight.w400,
        color: kGold),
  );
}
