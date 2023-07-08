import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

const String baseUrl = 'https://api.themoviedb.org/3/';
const String apiKey = '19e1a413bc3bada46bef728f543a7e24';

Uri getUri(String path) {
  return Uri.parse('$baseUrl$path?api_key=$apiKey');
}

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

  Future<dynamic> getRequest(String path) async {
    final uri = getUri(path);
    final response = await _client.get(uri);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load data');
    }
  }
}
