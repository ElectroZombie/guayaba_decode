import 'dart:convert';
import 'dart:math';

class Encrypt {
  bool _areCoprimes(int x, int y) {
    if (x <= 1 || y <= 1) {
      return false;
    }
    int mayor = max(x, y);
    int menor = min(x, y);
    if (mayor % menor == 0) {
      return true;
    } else {
      return _areCoprimes(menor, mayor - menor);
    }
  }

  String encryptMethod1(String text, List<String> charList) {
    List<int> charsASCCI = List.generate(256, (i) => i);
    List<String> chars = [];

    for (int i = 0; i < charsASCCI.length; i++) {
      chars.add(String.fromCharCode(charsASCCI[i]));
    }

    Random ran = Random();
    int pivot = ran.nextInt(255);
    int gap = ran.nextInt(255);
    while (_areCoprimes(256, gap)) {
      gap = ran.nextInt(255);
    }

    int firstPivot = pivot;

    Map<String, String> M = {};
    int sum = pivot;
    for (int i = 0; i < chars.length; i++) {
      M[chars[pivot]] = charList[sum];

      pivot += gap;
      pivot %= 256;
      sum += pivot;
    }

    String textEncrypt = "";

    for (int i = 0; i < text.length; i++) {
      textEncrypt += M[text[i]]!;
    }
    textEncrypt = charList[firstPivot] + textEncrypt + charList[gap];

    return textEncrypt;
  }

  String encryptMethod2(String text, List<String> charList) {
    String textEncrypt = charList[const AsciiEncoder().convert(text)[0]];

    for (int i = 1; i < text.length; i++) {
      int gap = 0;
      if (i >= text.length / 3 && i <= (text.length * 2) / 3) {
        gap = text.length % 20 + 1;
      } else if (i >= (text.length * 2) / 3 && i <= text.length) {
        gap = text.length % 50 + 1;
      }

      textEncrypt += charList[const AsciiEncoder().convert(text)[0] +
          (text.length % 100 + 1) +
          gap +
          const AsciiEncoder().convert(text)[i] *
              const AsciiEncoder().convert(text)[i]];
    }

    return textEncrypt;
  }
}
