import 'package:flutter/material.dart';
import 'package:guayaba_decode/providers/crypt_method_provider.dart';
import 'package:guayaba_decode/widgets/decode_widget.dart';

import '../services/guayaba_decode_package.dart' show GuayabaDecode;

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title, required this.provider});

  final String title;
  final CryptMethodProvider provider;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<dynamic> jsonData = [];
  List<String> charList = [];

  bool flagCrypt = false;
  String helperText = "WRITE THE TEXT";

  TextEditingController textController = TextEditingController();

  textCallback(String T, String helperText, bool flagCrypt) {
    setState(() {
      textController = TextEditingController(text: T);
      this.helperText = helperText;
      this.flagCrypt = flagCrypt;
    });
  }

  @override
  void initState() {
    super.initState();

    GuayabaDecode.load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title,
              style: const TextStyle(
                  fontSize: 20, color: Color.fromARGB(232, 186, 180, 180))),
        ),
        body: decode(textController, textCallback, helperText, flagCrypt,
            widget.provider, context));
  }
}
