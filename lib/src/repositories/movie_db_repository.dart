import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../api/api.dart';
import '../models/models.dart';

final movieDBRepositoryProvider = Provider<MovieDBRepository>(
  (ref) => MovieDBRepository(
    apiClient: ref.read(apiClientProvider),
  ),
);

class MovieDBRepository {
  MovieDBRepository({
    required ApiClient apiClient,
  }) : _apiClient = apiClient;

  final ApiClient _apiClient;

  Future<MoviesResponseModel> fetchTrendingMovies({
    int page = 1,
  }) async {
    final response =
        await _apiClient.getRequest('trending/movie/day?page=$page');

    return MoviesResponseModel.fromJson(response);
  }

  Future<MoviesResponseModel> fetchPopularMovies({
    int page = 1,
  }) async {
    final response = await _apiClient.getRequest('movie/popular?page=$page');

    return MoviesResponseModel.fromJson(response);
  }

  Future<MoviesResponseModel> fetchUpcomingMovies({
    int page = 1,
  }) async {
    final response = await _apiClient.getRequest('movie/upcoming?page=$page');

    return MoviesResponseModel.fromJson(response);
  }

  Future<MoviesResponseModel> fetchTopRatedMovies({
    int page = 1,
  }) async {
    final response = await _apiClient.getRequest('movie/top_rated?page=$page');

    return MoviesResponseModel.fromJson(response);
  }

  Future<MoviesResponseModel> searchMovies(String query) async {
    try {
      final response = await _apiClient.getRequest(
        'search/movie?query=$query',
      );

      return MoviesResponseModel.fromJson(response);
    } catch (e) {
      debugPrint('MovieDBRepository.searchMovies - $e');
      throw Exception('Failed to load data');
    }
  }
}
