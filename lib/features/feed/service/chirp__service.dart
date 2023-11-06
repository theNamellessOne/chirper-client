import 'dart:convert';

import 'package:chirper_client/constants/api.dart';
import 'package:chirper_client/storage/storage.dart';
import 'package:http/http.dart' as http;

import '../model/chirp.dart';

class ChirpService {
  Future<List<Chirp>> getChirps(int page) async {
    final response =
        await http.get(Uri.parse("${ApiConstants.BASE_URL}chirp/page/$page"));

    if (200 <= response.statusCode && response.statusCode <= 201) {
      List<Chirp> chirps = [];

      for (dynamic chirp in json.decode(response.body)) {
        chirps.add(Chirp.fromJson(chirp));
      }
      return chirps;
    } else {
      throw Exception("Get Chirps Request Failed");
    }
  }

  Future<Chirp?> postChirp(String content) async {
    final username = await Storage.read("username");
    final password = await Storage.read("password");

    final response = await http.put(
      Uri.parse("${ApiConstants.BASE_URL}chirp"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'username': username,
        'password': password,
        'content': content,
      }),
    );

    if (200 <= response.statusCode && response.statusCode <= 201) {
      return Chirp.fromJson(json.decode(response.body));
    } else {
      throw Exception("Chirp Request Failed");
    }
  }
}
