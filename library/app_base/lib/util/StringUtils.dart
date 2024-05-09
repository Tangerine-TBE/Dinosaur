import 'dart:typed_data';
import 'dart:convert';
class StringUtils{
  static String bytesToHex(Uint8List bytes) {
    return bytes.map((byte) => byte.toRadixString(16).padLeft(2, '0')).join('');
  }
  static String bytesToDecimalString(Uint8List bytes){
    String result = '';
    for (int i = 0; i < bytes.length; i++) {
      result += bytes[i].toString();
      if (i < bytes.length - 1) {
        result += '.';
      }
    }
    return result;
  }
  static Uint8List stringToByteList(String text){
   return  Uint8List.fromList(utf8.encode(text));
  }
  static String decodeString(Uint8List bytes){
    return utf8.decode(bytes);
  }
  static String decimalStringListToUtf8String(List<String> data){
    return data.map((decimalString) => String.fromCharCode(int.parse(decimalString))).join();
  }
  static bool isEmail(String input) {
    String regexEmail =
        "^([a-z0-9A-Z]+[-|\\.]?)+[a-z0-9A-Z]@([a-z0-9A-Z]+(-[a-z0-9A-Z]+)?\\.)+[a-zA-Z]{2,}\$";
    if (input.isEmpty) return false;
    return RegExp(regexEmail).hasMatch(input);
  }



  // static String bytes
}