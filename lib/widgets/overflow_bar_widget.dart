import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../models/icon_model.dart';
import '../utils/tuple.dart';
import 'decode_widget.dart';

Widget overflowbarUp(
    textController, textCallback, M, typeEncrypt, flagCrypt, context) {
  return OverflowBar(
    alignment: MainAxisAlignment.center,
    children: [
      IconButton(
          onPressed: () => textEncoder(
              textController, textCallback, M, typeEncrypt, flagCrypt, context),
          icon: const Icon(Icons.enhanced_encryption),
          color: Colors.black87,
          hoverColor: const Color.fromARGB(101, 111, 8, 8),
          tooltip: "ENCRYPT"),
      IconButton(
          onPressed: () => textDecoder(
              textController, textCallback, M, typeEncrypt, flagCrypt, context),
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
  );
}

Widget overflowBarLeft(
    textController, textCallback, M, typeEncrypt, flagCrypt, context) {
  return OverflowBar(
    alignment: MainAxisAlignment.center,
    overflowAlignment: OverflowBarAlignment.end,
    children: [
      IconButton(
          onPressed: () => textEncoder(
              textController, textCallback, M, typeEncrypt, flagCrypt, context),
          icon: const Icon(Icons.enhanced_encryption),
          color: Colors.black87,
          hoverColor: const Color.fromARGB(101, 111, 8, 8),
          tooltip: "ENCRYPT"),
      IconButton(
          onPressed: () => textDecoder(
              textController, textCallback, M, typeEncrypt, flagCrypt, context),
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
  );
}

Widget overflowBarRight(
    textController, textCallback, M, typeEncrypt, flagCrypt, context) {
  return OverflowBar(
    alignment: MainAxisAlignment.center,
    overflowAlignment: OverflowBarAlignment.start,
    children: [
      IconButton(
          onPressed: () => textEncoder(
              textController, textCallback, M, typeEncrypt, flagCrypt, context),
          icon: const Icon(Icons.enhanced_encryption),
          color: Colors.black87,
          hoverColor: const Color.fromARGB(101, 111, 8, 8),
          tooltip: "ENCRYPT"),
      IconButton(
          onPressed: () => textDecoder(
              textController, textCallback, M, typeEncrypt, flagCrypt, context),
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
