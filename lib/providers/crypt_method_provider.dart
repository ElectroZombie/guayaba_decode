import 'package:flutter/material.dart';
import '../services/guayaba_decode_package.dart';

class CryptMethodProvider with ChangeNotifier {
  int typeEncrypt = 1;

  activateTypeEncrypt(int opt) {
    typeEncrypt = opt;
    for (var i in GuayabaDecode.methodsMap.keys) {
      if (i == opt) {
        GuayabaDecode.methodsMap[i]!.K!.activate();
      } else {
        GuayabaDecode.methodsMap[i]!.K!.deactivate();
      }
    }
    notifyListeners();
  }
}
