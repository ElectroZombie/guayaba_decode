import 'dart:math';

import '../models/data_model.dart';

class CryptMap {
  final List<int> _charsASCCI = List.generate(256, (i) => i);
  final List<String> _chars = [];
  List<String> charList = [];

  CryptMap(this.charList) {
    for (int i = 0; i < _charsASCCI.length; i++) {
      _chars.add(String.fromCharCode(_charsASCCI[i]));
    }
  }

  DataModel generateMap() {
    Random ran = Random();
    int pivot = ran.nextInt(255);
    int gap = ran.nextInt(255) + 1;
    while (_areCoprimes(256, gap)) {
      gap = ran.nextInt(255) + 1;
    }

    Map<String, String> mau = {};
    Map<String, String> mua = {};

    int firstPivot = pivot;

    int sum = pivot;
    for (int i = 0; i < _chars.length; i++) {
      mau[_chars[pivot]] = charList[sum];
      mua[charList[sum]] = _chars[pivot];

      pivot += gap;
      pivot %= 256;
      sum += pivot;
    }
    return DataModel(mua, mau, firstPivot, gap);
  }

  DataModel generateSimpleMap() {
    Map<String, String> mau = {};
    Map<String, String> mua = {};

    Random ran = Random();
    int pivot = ran.nextInt(255);

    int firstPivot = pivot;

    int sum = pivot;
    for (int i = 0; i < _chars.length; i++) {
      mau[_chars[pivot]] = charList[sum];
      mua[charList[sum]] = _chars[pivot];

      pivot++;
      pivot %= 256;
      sum += pivot;
    }
    return DataModel(mua, mau, firstPivot, 1);
  }

  DataModel regenerateMap(int fP, int gap) {
    Map<String, String> mau = {};
    Map<String, String> mua = {};

    int pivot = fP;

    int sum = fP;
    for (int i = 0; i < _chars.length; i++) {
      mau[_chars[pivot]] = charList[sum];
      mua[charList[sum]] = _chars[pivot];

      pivot += gap;
      pivot %= 256;
      sum += pivot;
    }
    return DataModel(mua, mau, fP, gap);
  }

  static bool _areCoprimes(int x, int y) {
    if (x <= 1 || y <= 1) {
      return false;
    }
    int higher = max(x, y);
    int lesser = min(x, y);
    if (higher % lesser == 0) {
      return true;
    } else {
      return _areCoprimes(lesser, higher - lesser);
    }
  }

  /* static _createJson(List<String> L) async {
    final directory = await getDownloadsDirectory();
    final File file;
    if (Platform.isAndroid || Platform.isWindows) {
      file = File('${directory?.path}/chars.json');
    } else {
      file = File(
          '${Directory('${(await getApplicationCacheDirectory()).path}/../..').uri.path}sha_words.json');
    }
    final List<Map<String, dynamic>> x = List.generate(
        L.length,
        (i) => {
              'sha_word': L[i],
            });
    final jsonString = jsonEncode(x);
    await file.writeAsString(jsonString);
  }*/

  /*createList() {
    List<String> L = [];
    for (int i = 12353; i <= 12436; i++) {
      String s = String.fromCharCode(i);
      L.add(s);
    }
    for (int i = 12441; i <= 12446; i++) {
      String s = String.fromCharCode(i);
      L.add(s);
    }
    for (int i = 12449; i <= 12542; i++) {
      String s = String.fromCharCode(i);
      L.add(s);
    }
    for (int i = 12549; i <= 12588; i++) {
      String s = String.fromCharCode(i);
      L.add(s);
    }
    for (int i = 12593; i <= 12703; i++) {
      String s = String.fromCharCode(i);
      L.add(s);
    }
    for (int i = 12800; i <= 12867; i++) {
      String s = String.fromCharCode(i);
      L.add(s);
    }
    for (int i = 12896; i <= 12923; i++) {
      String s = String.fromCharCode(i);
      L.add(s);
    }
    for (int i = 12927; i <= 12976; i++) {
      String s = String.fromCharCode(i);
      L.add(s);
    }
    for (int i = 12992; i <= 13003; i++) {
      String s = String.fromCharCode(i);
      L.add(s);
    }
    for (int i = 13008; i <= 13054; i++) {
      String s = String.fromCharCode(i);
      L.add(s);
    }
    for (int i = 13056; i <= 13168; i++) {
      String s = String.fromCharCode(i);
      L.add(s);
    }
    for (int i = 19968; i <= 40869; i++) {
      String s = String.fromCharCode(i);
      L.add(s);
    }
    for (int i = 44032; i <= 55203; i++) {
      String s = String.fromCharCode(i);
      L.add(s);
    }
    for (int i = 63744; i <= 64045; i++) {
      String s = String.fromCharCode(i);
      L.add(s);
    }

     _createJson(L);
  }*/

  /*
  static makeList(Precalc prec) async {
    String json = await _loadJsonWords();
    List<dynamic> jsonData = await jsonDecode(json);
    List<String> wordList = List.generate(jsonData.length, (i) => jsonData[i]);

    Map<int, Function> M = {
      0: Encrypt.encryptMethod1,
      1: Encrypt.encryptMethod2
    };

    List<String> encryptedWords = [];
    Random r = Random();
    for (int i = 0; i < wordList.length; i++) {
      if (i >= 54 && i <= 96) {
        encryptedWords.add(M[0]!(wordList[i], prec));
      } else {
        encryptedWords.add(M[r.nextInt(2)]!(wordList[i], prec));
      }
    }

    await _createJson(List.generate(wordList.length,
        (i) => sha256.convert(utf8.encode(wordList[i])).toString()));
  }*/

  /*static Future<String> _loadJsonWords() async {
    return await rootBundle.loadString("assets/words.json");
  }*/
}
