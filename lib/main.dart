import 'dart:io';

import 'package:flutter/material.dart';

import 'views/my_home_page.dart';

void main() {
  bool hasImage = true;
  if (Platform.isLinux) {
    hasImage = false;
  }

  runApp(MyApp(hasImage));
}

// ignore: must_be_immutable
class MyApp extends StatelessWidget {
  bool hasImage;
  MyApp(this.hasImage, {super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //Guayaba G = Guayaba();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
              seedColor: const Color.fromARGB(255, 89, 1, 1)),
          useMaterial3: true,
          appBarTheme: const AppBarTheme(
              backgroundColor: Color.fromARGB(215, 89, 1, 1),
              shadowColor: Colors.black12),
          fontFamily: "Times new roman"),
      home: const MyHomePage(title: 'Guayaba Decode'),
    );
  }
}
