import 'dart:convert';

import 'package:chirper_client/constants/api.dart';
import 'package:http/http.dart' as http;

import '../model/user.dart';

class AuthService {
  Future<User?> authorize(String username, String password) async {
    final response = await http.post(
      Uri.parse("${ApiConstants.BASE_URL}auth/login"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'username': username,
        'password': password,
      }),
    );

    if (200 <= response.statusCode && response.statusCode <= 201) {
      return User.fromJson(json.decode(response.body));
    } else {
      throw Exception("Auth Request Failed");
    }
  }

  Future<User?> register(String username, String password, String firstName,
      String lastName) async {
    final response = await http.post(
      Uri.parse("${ApiConstants.BASE_URL}auth/register"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'username': username,
        'password': password,
        'lastName': lastName,
        'firstName': firstName,
      }),
    );

    if (200 <= response.statusCode && response.statusCode <= 201) {
      return User.fromJson(json.decode(response.body));
    } else {
      throw Exception("Registration Request Failed");
    }
  }
}
