import 'dart:convert';

class TextAddin {
  static String _spaceDef = "   ";

  static String addSpacing(int spacing) {
    String result = "";

    for (var i = 0; i < spacing; i++) {
      result += _spaceDef;
    }

    return result;
  }

  static String basicAuthenticationHeader(String username, String password) {
    return 'Basic ' + base64Encode(utf8.encode('$username:$password'));
  }
}