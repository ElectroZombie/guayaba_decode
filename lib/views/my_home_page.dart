import 'package:flutter/material.dart';
import 'package:guayaba_decode/models/icon_model.dart';
import 'package:guayaba_decode/services/guayaba_decode_package.dart';
import 'package:guayaba_decode/widgets/decode_widget.dart';
import 'package:guayaba_decode/utils/tuple.dart';
import 'package:guayaba_decode/widgets/popup_menu_item_list_widget.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<dynamic> jsonData = [];
  List<String> charList = [];
  GuayabaDecode guayabaDecode = GuayabaDecode();

  bool flagCrypt = false;
  String helperText = "WRITE THE TEXT";
  Map<int, Tuple<Tuple<Function, Function>, IconModel>> M = {};

  int typeEncrypt = 1;

  TextEditingController textController = TextEditingController();

  textCallback(String T, String helperText, bool flagCrypt) {
    setState(() {
      textController = TextEditingController(text: T);
      this.helperText = helperText;
      this.flagCrypt = flagCrypt;
    });
  }

  callBackTypeEncrypt(int opt) {
    setState(() {
      typeEncrypt = opt;
      for (var i in M.keys) {
        if (i == opt) {
          M[i]!.K!.activate();
        } else {
          M[i]!.K!.deactivate();
        }
      }
    });
  }

  @override
  void initState() {
    super.initState();

    M = {
      1: Tuple(
          T: Tuple(
              T: guayabaDecode.encryptMethod1, K: guayabaDecode.decryptMethod1),
          K: IconModel(active: true)),
      2: Tuple(
          T: Tuple(
              T: guayabaDecode.encryptMethod2, K: guayabaDecode.decryptMethod2),
          K: IconModel(active: false))
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            PopupMenuButton(
              tooltip: "SHOW MENU",
              iconColor: Colors.white60,
              iconSize: 25,
              style: ButtonStyle(
                  overlayColor: WidgetStateColor.resolveWith(
                      (states) => const Color.fromARGB(99, 104, 58, 183))),
              itemBuilder: (context) {
                return popupMenuItemList(M, callBackTypeEncrypt);
              },
            ),
          ],
          title: Text(widget.title,
              style: const TextStyle(
                  fontSize: 20, color: Color.fromARGB(232, 186, 180, 180))),
        ),
        body: Stack(children: [
          decode(textController, textCallback, helperText, M, typeEncrypt,
              flagCrypt, context)
        ]));
  }
}
