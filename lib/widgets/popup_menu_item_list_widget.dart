import 'package:flutter/material.dart';
import 'package:guayaba_decode/providers/crypt_method_provider.dart';
import 'package:guayaba_decode/services/guayaba_decode_package.dart';

List<PopupMenuItem> popupMenuItemList(CryptMethodProvider prov) {
  return List.generate(
    GuayabaDecode.methodsMap.length * 2 + 1,
    (i) => selectorMenuItem(i, prov),
  );
}

selectorMenuItem(int i, CryptMethodProvider prov) {
  if (i % 2 == 0) {
    if (i == GuayabaDecode.methodsMap.length * 2) {
      return const PopupMenuItem(
          enabled: false,
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text(
              "COMING SOON...",
              style: TextStyle(fontSize: 15),
              textAlign: TextAlign.end,
            ),
            Icon(Icons.watch_later_outlined)
          ]));
    } else {
      return PopupMenuItem(
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text("METHOD ${i ~/ 2 + 1}:", style: const TextStyle(fontSize: 15)),
            Icon(GuayabaDecode.methodsMap[i / 2 + 1]!.K!.getIcon(),
                color: GuayabaDecode.methodsMap[i / 2 + 1]!.K!.getColor())
          ]),
          onTap: () => {prov.activateTypeEncrypt(i ~/ 2 + 1)});
    }
  } else {
    return const PopupMenuItem(
      height: 10,
      enabled: false,
      child: PopupMenuDivider(),
    );
  }
}
