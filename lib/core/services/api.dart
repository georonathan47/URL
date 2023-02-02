// ignore_for_file: constant_identifier_names

import 'dart:convert';

import 'package:http/http.dart' as http;

const String api_key = "LSMufeuYohAku8Nzgfevu53sxA8bAkrV";
const String api_url = "https://ipqualityscore.com/api/json/url/$api_key";

class Api {
 scan(String url) async {
    final response = await http.get(Uri.parse('$api_url/$url'));
    if (response.statusCode == 200) {
      print('Api Url: $api_url/$url');
      print('Response body: ${response.body}');
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load data');
    }
  }
}