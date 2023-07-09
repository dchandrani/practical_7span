import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../features/favorites/favorites.dart' show favoritesBoxProvider;
import '../api/api.dart' show ApiClient, apiClientProvider;
import '../models/models.dart' show Movie, MoviesResponseModel;

final movieDBRepositoryProvider = Provider<MovieDBRepository>(
  (ref) => MovieDBRepository(
    apiClient: ref.read(apiClientProvider),
    favoriteMoviesBox: ref.read(favoritesBoxProvider),
  ),
);

class MovieDBRepository {
  MovieDBRepository({
    required ApiClient apiClient,
    required Box<Movie> favoriteMoviesBox,
  })  : _apiClient = apiClient,
        _favoriteMoviesBox = favoriteMoviesBox;

  final ApiClient _apiClient;
  final Box<Movie> _favoriteMoviesBox;

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
    final response = await _apiClient.getRequest(
      'search/movie?query=$query',
    );

    return MoviesResponseModel.fromJson(response);
  }

  List<Movie> get favoriteMovies => _favoriteMoviesBox.values.toList();

  void addFavorite(Movie movie) {
    _favoriteMoviesBox.put(movie.id, movie);
  }

  void removeFavorite(Movie movie) {
    _favoriteMoviesBox.delete(movie.id);
  }
}
