import 'package:flutter/material.dart';
import 'package:guayaba_decode/models/icon_model.dart';
import 'package:guayaba_decode/utils/tuple.dart';

List<PopupMenuItem> popupMenuItemList(
    Map<int, Tuple<Tuple<Function, Function>, IconModel>> M,
    callBackTypeEncrypt) {
  return List.generate(
    M.length * 2 + 1,
    (i) => selectorMenuItem(i, M, callBackTypeEncrypt),
  );
}

selectorMenuItem(int i, M, callBackTypeEncrypt) {
  if (i % 2 == 0) {
    if (i == M.length * 2) {
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
            Icon(M[i / 2 + 1]!.K!.getIcon(), color: M[i / 2 + 1]!.K!.getColor())
          ]),
          onTap: () => {callBackTypeEncrypt(i ~/ 2 + 1)});
    }
  } else {
    return const PopupMenuItem(
      height: 10,
      enabled: false,
      child: PopupMenuDivider(),
    );
  }
}
