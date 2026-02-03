import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:guayaba_decode/providers/crypt_method_provider.dart';
import 'package:guayaba_decode/services/file_picker_service.dart';
import 'package:guayaba_decode/services/guayaba_decode_package.dart';
import 'package:provider/provider.dart';

import 'decode_widget.dart';
import 'popup_menu_item_list_widget.dart';

Widget overflowbarUp(
    TextEditingController textController,
    Function textCallback,
    bool flagCrypt,
    CryptMethodProvider prov,
    BuildContext context) {
  return Consumer<CryptMethodProvider>(builder: (context, prov, child) {
    return OverflowBar(
      alignment: MainAxisAlignment.center,
      children: [
        IconButton(
            onPressed: () => textEncoder(
                textController, textCallback, prov, flagCrypt, context),
            icon: const Icon(Icons.enhanced_encryption),
            color: Colors.black87,
            hoverColor: const Color.fromARGB(101, 111, 8, 8),
            tooltip: "ENCRYPT"),
        IconButton(
            onPressed: () => textDecoder(
                textController, textCallback, prov, flagCrypt, context),
            icon: const Icon(Icons.no_encryption),
            color: Colors.black87,
            hoverColor: const Color.fromARGB(101, 111, 8, 8),
            tooltip: "DE-ENCRYPT"),
        const SizedBox(width: 5),
        Text("METHOD ${prov.typeEncrypt}"),
        PopupMenuButton(
            tooltip: "SHOW MENU",
            style: ButtonStyle(
                overlayColor: WidgetStateColor.resolveWith(
                    (states) => const Color.fromARGB(99, 104, 58, 183))),
            itemBuilder: (context) {
              return popupMenuItemList(prov);
            },
            child: const Icon(Icons.keyboard_arrow_down_sharp)),
      ],
    );
  });
}

Widget overflowBarLeft(TextEditingController textController,
    Function textCallback, bool flagCrypt, BuildContext context) {
  return OverflowBar(
    alignment: MainAxisAlignment.center,
    overflowAlignment: OverflowBarAlignment.end,
    children: [
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

Widget overflowBarRight(TextEditingController textController,
    Function textCallback, bool flagCrypt, BuildContext context) {
  return OverflowBar(
    alignment: MainAxisAlignment.center,
    overflowAlignment: OverflowBarAlignment.start,
    children: [
      IconButton(
          onPressed: () => FilePickerService.loadFile(),
          icon: const Icon(Icons.file_open),
          color: Colors.black87,
          hoverColor: const Color.fromARGB(101, 111, 8, 8),
          tooltip: "LOAD FILE"),
      IconButton(
          onPressed: () => FilePickerService.saveFile(),
          icon: const Icon(Icons.save),
          color: Colors.black87,
          hoverColor: const Color.fromARGB(101, 111, 8, 8),
          tooltip: "SAVE FILE")
    ],
  );
}

void textEncoder(TextEditingController textController, Function textCallback,
    CryptMethodProvider prov, bool flagCrypt, context) {
  if (flagCrypt) {
    showError(context, "THE TEXT IS ALREADY ENCRYPTED");
  } else {
    String text = textController.text;
    if (text.isEmpty) {
      showError(context, "WRITE THE TEXT FIRST");
    } else {
      String encryptedText =
          GuayabaDecode.methodsMap[prov.typeEncrypt]!.T!.T!(text);
      textCallback(encryptedText, "TEXT ENCRYPTED", !flagCrypt);
    }
  }
}

void textDecoder(TextEditingController textController, Function textCallback,
    CryptMethodProvider prov, bool flagCrypt, context) {
  if (!flagCrypt) {
    showError(context, "THE TEXT HAS NOT BEEN ENCRYPTED YET");
  } else {
    String text = textController.text;
    String decryptedText =
        GuayabaDecode.methodsMap[prov.typeEncrypt]!.T!.K!(text);

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
