import 'package:flutter/material.dart';
import 'package:guayaba_decode/providers/crypt_method_provider.dart';

import 'views/my_home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    CryptMethodProvider provider = CryptMethodProvider();

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
      home: MyHomePage(title: 'Guayaba Decode', provider: provider),
    );
  }
}
