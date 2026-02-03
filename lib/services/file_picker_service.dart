import 'dart:io';

import 'package:file_picker/file_picker.dart';

class FilePickerService {
  static loadFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      dialogTitle: "OPEN FILE",
      lockParentWindow: true,
      allowedExtensions: ['docx', 'txt', 'doc'],
    );

    if (result != null) {
      File file = File(result.files.single.path!);
    } else {
      // User canceled the picker
    }
  }

  static saveFile() async {
    String? outputFile = await FilePicker.platform.saveFile(
      dialogTitle: 'Please select an output file:',
      fileName: 'output-file.pdf',
      allowedExtensions: ['docx', 'txt', 'doc'],
      lockParentWindow: true,
      type: FileType.custom,
    );

    if (outputFile == null) {
      // User canceled the picker
    }
  }
}
