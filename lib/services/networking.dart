import 'package:climaa/services/networking.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class NetworkHelpher{
  late final String url;

  NetworkHelpher(this.url);

  Future getData() async {
    http.Response response=await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      String data = response.body;
      return data;
    }
    else {
      print(response.statusCode);
    }
  }
}