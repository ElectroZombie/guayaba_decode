import 'dart:convert' show utf8;
import 'dart:io';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:txt_docx/txt_docx.dart';

class FilePickerService {
  static Future<String> loadFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      dialogTitle: "OPEN FILE",
      lockParentWindow: true,
      allowedExtensions: ['txt', 'docx', 'doc'],
    );

    if (result != null) {
      String? content = await loadFileContent(result.files.single.path!);
      return content!;
    } else {
      return "";
    }
  }

  static Future<String?> loadFileContent(String filePath) async {
    // Get the file extension to choose the right method
    String extension = filePath.split('.').last.toLowerCase();

    try {
      if (extension == 'txt') {
        // Read plain text files using dart:io [citation:5]
        File file = File(filePath);
        return await file.readAsString();
      } else if (extension == 'doc' || extension == 'docx') {
        // Extract text from Word documents using the doc_text plugin [citation:10]
        return await const DocxDecoder()
            .stream(filePath)
            .transform(utf8.encoder)
            .pipe(stdout);
      } else {
        return 'Unsupported file type.';
      }
    } catch (e) {
      return 'Error reading file: $e';
    }
  }

  static Future<bool> saveFile(String content) async {
    try {
      String? outputFilePath = await FilePicker.platform.saveFile(
          dialogTitle: 'Please select an output file:',
          fileName: 'output',
          allowedExtensions: ['docx', 'txt', 'doc'],
          lockParentWindow: true,
          type: FileType.custom,
          bytes: Uint8List.fromList(content.codeUnits));

      if (outputFilePath == null) {
        // User canceled the picker
      }
      return true;
    } catch (e) {
      return false;
    }
  }
}
