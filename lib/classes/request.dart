import 'dart:convert';

import 'package:http/http.dart';

class RequestHttp {
  final url;

  RequestHttp({required this.url});

  Future<dynamic> getBook(String name) async {
    String _bookEndpoint = url + name;
    try {
      dynamic _response = await get(Uri.parse(_bookEndpoint));
      if (_response.statusCode == 200) {
        return jsonDecode(_response.body);
      }
    } catch (e) {
      print(e.toString());
      return;
    }
  }
}
