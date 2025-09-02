import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:guayaba_decode/models/icon_model.dart';
import 'package:guayaba_decode/utils/tuple.dart';
import 'package:guayaba_decode/widgets/gradient.dart';

Widget decode(
    TextEditingController controllerTexto,
    Function callbackTexto,
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
                onPressed: () => codificar(controllerTexto, callbackTexto, M,
                    typeEncrypt, flagCrypt, context),
                icon: const Icon(Icons.enhanced_encryption),
                color: Colors.black87,
                hoverColor: const Color.fromARGB(101, 111, 8, 8),
                tooltip: "ENCRYPT"),
            IconButton(
                onPressed: () => decodificar(controllerTexto, callbackTexto, M,
                    typeEncrypt, flagCrypt, context),
                icon: const Icon(Icons.no_encryption),
                color: Colors.black87,
                hoverColor: const Color.fromARGB(101, 111, 8, 8),
                tooltip: "DE-ENCRYPT"),
            IconButton(
                onPressed: () => portapapeles(controllerTexto, context),
                icon: const Icon(Icons.file_present_sharp),
                color: Colors.black87,
                hoverColor: const Color.fromARGB(101, 111, 8, 8),
                tooltip: "COPY TO CLIPBOARD"),
            IconButton(
                onPressed: () => borrar(callbackTexto),
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
                      callbackTexto("", "WRITE THE TEXT", false);
                    } else if (!flagCrypt) {
                      if (watchFirstChar(value)) {
                        callbackTexto(value, "TEXT ENCRYPTED", !flagCrypt);
                      }
                    } else {
                      if (!watchFirstChar(value)) {
                        callbackTexto(value, "WRITE THE TEXT", !flagCrypt);
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
                  controller: controllerTexto,
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

void codificar(
    TextEditingController controllerTexto,
    Function callbackTexto,
    Map<int, Tuple<Tuple<Function, Function>, IconModel>> M,
    int typeEncrypt,
    bool flagCrypt,
    context) {
  if (flagCrypt) {
    showError(context, "THE TEXT IS ALREADY ENCRYPTED");
  } else {
    String text = controllerTexto.text;
    if (text.isEmpty) {
      showError(context, "WRITE THE TEXT FIRST");
    } else {
      String textEncrypted = M[typeEncrypt]!.T!.T!(text);
      callbackTexto(textEncrypted, "TEXT ENCRYPTED", !flagCrypt);
    }
  }
}

void decodificar(
    TextEditingController controllerTexto,
    Function callbackTexto,
    Map<int, Tuple<Tuple<Function, Function>, IconModel>> M,
    int typeEncrypt,
    bool flagCrypt,
    context) {
  if (!flagCrypt) {
    showError(context, "THE TEXT HAS NOT BEEN ENCRYPTED YET");
  } else {
    String text = controllerTexto.text;
    String textDecrypted = M[typeEncrypt]!.T!.K!(text);

    if (textDecrypted == text) {
      showError(context, "THE DE-ENCRYPT HAS FAILED");
    } else {
      callbackTexto(textDecrypted, "WRITE THE TEXT", !flagCrypt);
    }
  }
}

void portapapeles(TextEditingController controllerTexto, context) async {
  Clipboard.setData(ClipboardData(text: controllerTexto.text));
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
                Navigator.pop(
                    context); // Cerrar el diálogo sin agregar la unidad
              },
              child: const Text('OK'),
            ),
          ],
        );
      });
}

void borrar(Function callbackTexto) {
  callbackTexto("", "WRITE THE TEXT", false);
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
