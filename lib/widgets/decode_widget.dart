import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:guayaba_decode/providers/crypt_method_provider.dart';
import 'package:provider/provider.dart';
import 'package:guayaba_decode/widgets/overflow_bar_widget.dart';

Widget decode(
    TextEditingController textController,
    Function textCallback,
    String textHelper,
    bool flagCrypt,
    CryptMethodProvider prov,
    BuildContext context) {
  return ChangeNotifierProvider<CryptMethodProvider>(
      create: (context) => prov,
      builder: (context, child) => Column(children: [
            Container(
                color: const Color.fromARGB(195, 255, 255, 255),
                child: overflowbarUp(
                    textController, textCallback, flagCrypt, prov, context)),
            Stack(children: [
              // gradient(MediaQuery.of(context).size.width,
              //     MediaQuery.of(context).size.height * 8 / 10),
              Center(
                  child: Row(
                      spacing: 0.0,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                    SizedBox(
                        width: MediaQuery.of(context).size.width * 10 / 100,
                        child: overflowBarLeft(
                            textController, textCallback, flagCrypt, context)),
                    SizedBox(
                        child: SingleChildScrollView(
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
                        filled: true,
                        fillColor: const Color.fromARGB(61, 133, 111, 111),
                        constraints: BoxConstraints.tightFor(
                            width:
                                (MediaQuery.of(context).size.width * 75) / 100,
                            height: (MediaQuery.of(context).size.height * 80) /
                                100),
                        helper: Text(
                          textHelper,
                          style: const TextStyle(
                              fontSize: 16,
                              color: Color.fromARGB(255, 0, 0, 0)),
                        ),
                      ),
                      controller: textController,
                      keyboardType: TextInputType.multiline,
                      enabled: !flagCrypt,
                      maxLines: null,
                      style: const TextStyle(
                          color: Color.fromARGB(255, 0, 0, 0), fontSize: 20),
                    ))),
                    SizedBox(
                        width: MediaQuery.of(context).size.width * 10 / 100,
                        child: overflowBarRight(
                            textController, textCallback, flagCrypt, context)),
                  ]))
            ])
          ]));
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
