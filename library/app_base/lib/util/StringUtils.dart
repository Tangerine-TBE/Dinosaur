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

  // static String bytes
}