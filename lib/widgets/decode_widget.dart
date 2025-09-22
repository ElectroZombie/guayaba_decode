import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:guayaba_decode/models/icon_model.dart';
import 'package:guayaba_decode/utils/tuple.dart';
import 'package:guayaba_decode/widgets/gradient.dart';

Widget decode(
    TextEditingController textController,
    Function textCallback,
    String textHelper,
    Map<int, Tuple<Tuple<Function, Function>, IconModel>> M,
    int typeEncrypt,
    bool flagCrypt,
    context) {
  return SingleChildScrollView(
    child: Column(children: [
      Container(
        color: const Color.fromARGB(195, 255, 255, 255),
        child: ButtonBar(
          alignment: MainAxisAlignment.center,
          children: [
            IconButton(
                onPressed: () => textEncoder(textController, textCallback, M,
                    typeEncrypt, flagCrypt, context),
                icon: const Icon(Icons.enhanced_encryption),
                color: Colors.black87,
                hoverColor: const Color.fromARGB(101, 111, 8, 8),
                tooltip: "ENCRYPT"),
            IconButton(
                onPressed: () => textDecoder(textController, textCallback, M,
                    typeEncrypt, flagCrypt, context),
                icon: const Icon(Icons.no_encryption),
                color: Colors.black87,
                hoverColor: const Color.fromARGB(101, 111, 8, 8),
                tooltip: "DE-ENCRYPT"),
            IconButton(
                onPressed: () => clipboard(textController, context),
                icon: const Icon(Icons.file_present_sharp),
                color: Colors.black87,
                hoverColor: const Color.fromARGB(101, 111, 8, 8),
                tooltip: "COPY TO CLIPBOARD"),
            IconButton(
                onPressed: () => erase(textCallback),
                icon: const Icon(Icons.delete),
                color: Colors.black87,
                hoverColor: const Color.fromARGB(101, 111, 8, 8),
                tooltip: "ERASE ALL")
          ],
        ),
      ),
      Stack(children: [
        gradient(MediaQuery.of(context).size.width,
            (MediaQuery.of(context).size.height * 95) / 100),
        Center(
            child: SizedBox(
                width: (MediaQuery.of(context).size.width * 75) / 100,
                height: (MediaQuery.of(context).size.height * 95) / 100,
                child: TextFormField(
                  onChanged: (value) {
                    if (value.isEmpty) {
                      textCallback("", "WRITE THE TEXT", false);
                    } else if (!flagCrypt) {
                      if (watchFirstChar(value)) {
                        textCallback(value, "TEXT ENCRYPTED", !flagCrypt);
                      }
                    } else {
                      if (!watchFirstChar(value)) {
                        textCallback(value, "WRITE THE TEXT", !flagCrypt);
                      }
                    }
                  },
                  decoration: InputDecoration(
                    iconColor: Colors.black87,
                    icon: const Icon(Icons.text_fields),
                    helper: Text(
                      textHelper,
                      style: const TextStyle(
                          fontSize: 16, color: Color.fromARGB(255, 0, 0, 0)),
                    ),
                  ),
                  controller: textController,
                  keyboardType: TextInputType.multiline,
                  enabled: !flagCrypt,
                  maxLines: null,
                  style: const TextStyle(
                      color: Color.fromARGB(255, 0, 0, 0), fontSize: 20),
                )))
      ])
    ]),
  );
}

void textEncoder(
    TextEditingController textController,
    Function textCallback,
    Map<int, Tuple<Tuple<Function, Function>, IconModel>> M,
    int typeEncrypt,
    bool flagCrypt,
    context) {
  if (flagCrypt) {
    showError(context, "THE TEXT IS ALREADY ENCRYPTED");
  } else {
    String text = textController.text;
    if (text.isEmpty) {
      showError(context, "WRITE THE TEXT FIRST");
    } else {
      String encryptedText = M[typeEncrypt]!.T!.T!(text);
      textCallback(encryptedText, "TEXT ENCRYPTED", !flagCrypt);
    }
  }
}

void textDecoder(
    TextEditingController textController,
    Function textCallback,
    Map<int, Tuple<Tuple<Function, Function>, IconModel>> M,
    int typeEncrypt,
    bool flagCrypt,
    context) {
  if (!flagCrypt) {
    showError(context, "THE TEXT HAS NOT BEEN ENCRYPTED YET");
  } else {
    String text = textController.text;
    String decryptedText = M[typeEncrypt]!.T!.K!(text);

    if (decryptedText == text) {
      showError(context, "THE DE-ENCRYPT HAS FAILED");
    } else {
      textCallback(decryptedText, "WRITE THE TEXT", !flagCrypt);
    }
  }
}

void clipboard(
    TextEditingController textController, BuildContext context) async {
  if (textController.text.isEmpty) {
    showError(context, "WRITE THE TEXT FIRST");
    return;
  }
  Clipboard.setData(ClipboardData(text: textController.text));
  await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('ADVICE'),
          backgroundColor: const Color.fromARGB(255, 69, 74, 81),
          content: const Text(
            "COPIED TO CLIPBOARD",
            style: TextStyle(color: Colors.black87, fontSize: 18),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('OK'),
            ),
          ],
        );
      });
}

void erase(Function textCallback) {
  textCallback("", "WRITE THE TEXT", false);
}

showError(context, String errorText) async {
  await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('ERROR'),
          backgroundColor: const Color.fromARGB(255, 69, 74, 81),
          content: Text(
            errorText,
            style: const TextStyle(color: Colors.black87, fontSize: 18),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('OK'),
            ),
          ],
        );
      });
}

bool watchFirstChar(String S) {
  try {
    ascii.encode(S[0]);
  } catch (e) {
    return true;
  }
  return false;
}
