import 'package:flutter/material.dart';

Widget gradient(double width, double height) {
  return Container(
      constraints: BoxConstraints.tightFor(height: height, width: width),
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: FractionalOffset(0.0, 0.0),
              end: FractionalOffset(0.0, 1.0),
              colors: [
            Color.fromARGB(190, 255, 255, 255),
            Color.fromARGB(208, 78, 3, 3)
          ])));
}
