import 'package:path_provider/path_provider.dart';
import 'dart:convert';
import 'dart:io';

_crearJson(List<String> L) async {
  final directory = await getDownloadsDirectory();
  final File file;
  if (Platform.isAndroid || Platform.isWindows) {
    file = File('${directory?.path}/chars.json');
  } else {
    file = File(
        '${Directory('${(await getApplicationCacheDirectory()).path}/../..').uri.path}chars.json');
  }
  final List<Map<String, dynamic>> x = List.generate(
      L.length,
      (i) => {
            'char': L[i],
          });
  final jsonString = jsonEncode(x);
  await file.writeAsString(jsonString);
}

createList() {
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

  _crearJson(L);
}

  /*Metodo 1
  Desorganizar los caracteres, poner un inicio y un salto.
  x=ini; (ini<=255)
  v(x) = ascci[x]
  x+=gap; (gap<=42)
  v(x)= ascci(x) + v[x-1]
  Requiere construir mapa de valores
  Pasar valores de inicio y el salto en el encriptado
  -------------------------------------------
  Metodo 2
  S[0] = ascci[S[0]]
  S[i] = ascci(S[0]*((length%100)+1)+factorGap+(ascci(S[i]^2)))
    factorGap:
     X <= S.length/3 -> 0
     X >= (S.length)/3 && X <= (S.length*2)/3 -> (S.length%20)+1
     X >= (S.length*2)/3 && X <= S.length -> (S.length%50)+1
  */