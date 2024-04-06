

import 'dart:convert';
import 'dart:io';

Future<String> file2Base64(String path) async{
  File file = File(path);
  List<int> fileBytes = await file.readAsBytes();
  return base64Encode(fileBytes);
}