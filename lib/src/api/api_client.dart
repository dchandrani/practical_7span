import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

const String baseUrl = 'https://api.themoviedb.org/3/';
const String baseImageUrl = 'https://image.tmdb.org/t/p/w500';
const String accessToken =
    'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIxOWUxYTQxM2JjM2JhZGE0NmJlZjcyOGY1NDNhN2UyNCIsInN1YiI6IjVhODE3MGUxOTI1MTQxNDBmZTAyZDM3ZCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.6MSuYwTJEXcmqcyGGq0WNYddoWREFtPXWdbOiyPrArU';

final httpClientProvider = Provider(
  (ref) => http.Client(),
);

final apiClientProvider = Provider<ApiClient>(
  (ref) => ApiClient(
    client: ref.read(httpClientProvider),
  ),
);

class ApiClient {
  const ApiClient({
    required http.Client client,
  }) : _client = client;

  final http.Client _client;

  Map<String, String> get _headers {
    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $accessToken',
    };

    return headers;
  }

  Future<dynamic> getRequest(String path) async {
    final uri = Uri.parse('$baseUrl$path');
    final response = await _client.get(uri, headers: _headers);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load data');
    }
  }
}
