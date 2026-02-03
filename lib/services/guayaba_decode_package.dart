library guayaba_decode_package;

import 'dart:convert';
import 'dart:math';

import 'package:flutter/services.dart';

import '../models/icon_model.dart' show IconModel;
import '../structs/cryptmap.dart';
import '../models/data_model.dart';
import '../utils/tuple.dart' show Tuple;

class GuayabaDecode {
  static List<dynamic> _jsonData = [];
  static List<String> _charList = [];
  static CryptMap _cryptMap = CryptMap([]);

  static Map<int, Tuple<Tuple<Function, Function>, IconModel>> methodsMap = {
    1: Tuple(
        T: Tuple(
            T: GuayabaDecode.encryptMethod1, K: GuayabaDecode.decryptMethod1),
        K: IconModel(active: true)),
    2: Tuple(
        T: Tuple(
            T: GuayabaDecode.encryptMethod2, K: GuayabaDecode.decryptMethod2),
        K: IconModel(active: false)),
    3: Tuple(
        T: Tuple(
            T: GuayabaDecode.encryptMethod3, K: GuayabaDecode.decryptMethod3),
        K: IconModel(active: false)),
  };

  static void load() async {
    if (_charList.isEmpty) {
      _charList = await _loadCL();
      _cryptMap = CryptMap(_charList);
    }
  }

  static Future<String> _loadJson() async {
    return await rootBundle.loadString("assets/chars.json");
  }

  static Future<List<String>> _loadCL() async {
    String json = await _loadJson();
    _jsonData = await jsonDecode(json);
    return List.generate(_jsonData.length, (i) => _jsonData[i]['char']);
  }

  static String encryptMethod1(String text) {
    String textEncrypt = "";

    DataModel data = _cryptMap.generateMap();
    for (int i = 0; i < text.length; i++) {
      textEncrypt += data.mAsciiUni[text[i]]!;
    }
    textEncrypt = _cryptMap.charList[data.firstPivot] +
        textEncrypt +
        _cryptMap.charList[data.gap];

    return textEncrypt;
  }

  static String encryptMethod2(String text) {
    String textEncrypt =
        _cryptMap.charList[const AsciiEncoder().convert(text)[0]];

    for (int i = 1; i < text.length; i++) {
      int gap = 0;
      if (i >= text.length / 3 && i <= (text.length * 2) / 3) {
        gap = text.length % 20 + 1;
      } else if (i >= (text.length * 2) / 3 && i <= text.length) {
        gap = text.length % 50 + 1;
      }

      textEncrypt += _cryptMap.charList[const AsciiEncoder().convert(text)[0] +
          (text.length % 100 + 1) +
          gap +
          const AsciiEncoder().convert(text)[i] *
              const AsciiEncoder().convert(text)[i]];
    }

    return textEncrypt;
  }

  static String encryptMethod3(String text) {
    String textEncrypt = "";

    DataModel data = _cryptMap.generateSimpleMap();
    for (int i = 0; i < text.length; i++) {
      textEncrypt += data.mAsciiUni[text[i]]!;
    }

    textEncrypt = _cryptMap.charList[data.firstPivot] + textEncrypt;

    return textEncrypt;
  }

  static String decryptMethod1(String s) {
    int pivot = _cryptMap.charList.indexOf(s[0]);
    int gap = _cryptMap.charList.indexOf(s[s.length - 1]);

    try {
      DataModel data = _cryptMap.regenerateMap(pivot, gap);

      String decrypt = "";
      for (int i = 1; i < s.length - 1; i++) {
        decrypt += data.mUniAscii[s[i]]!;
      }

      return decrypt;
    } catch (e) {
      return s;
    }
  }

  static String decryptMethod2(String s) {
    try {
      String decrypt =
          const AsciiDecoder().convert([_cryptMap.charList.indexOf(s[0])])[0];

      for (int i = 1; i < s.length; i++) {
        int gap = 0;
        if (i >= s.length / 3 && i <= (s.length * 2) / 3) {
          gap = s.length % 20 + 1;
        } else if (i >= (s.length * 2) / 3 && i <= s.length) {
          gap = s.length % 50 + 1;
        }

        decrypt += const AsciiDecoder().convert([
          (sqrt(_cryptMap.charList.indexOf(s[i]) -
                  _cryptMap.charList.indexOf(s[0]) -
                  (s.length % 100 + 1) -
                  gap))
              .toInt()
        ]);
      }

      return decrypt;
    } catch (e) {
      return s;
    }
  }

  static String decryptMethod3(String s) {
    try {
      int pivot = _cryptMap.charList.indexOf(s[0]);
      DataModel data = _cryptMap.regenerateMap(pivot, 1);

      String decrypt = "";
      for (int i = 1; i < s.length; i++) {
        decrypt += data.mUniAscii[s[i]]!;
      }

      return decrypt;
    } catch (e) {
      return s;
    }
  }
}
