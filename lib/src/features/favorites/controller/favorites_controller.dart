import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:practical_7span/src/repositories/movie_db_repository.dart';

import '../../../models/models.dart';

part 'favorites_state.dart';

final favoritesBoxProvider = Provider<Box<Movie>>((ref) {
  throw UnimplementedError();
});

final favoritesControllerProvider =
    StateNotifierProvider.autoDispose<FavoritesController, FavoritesState>(
  (ref) => FavoritesController(
    movieDBRepository: ref.read(movieDBRepositoryProvider),
  )..init(),
);

class FavoritesController extends StateNotifier<FavoritesState> {
  FavoritesController({
    required MovieDBRepository movieDBRepository,
  })  : _movieDBRepository = movieDBRepository,
        super(const FavoritesState());

  final MovieDBRepository _movieDBRepository;

  void init() {
    final List<Movie> favoriteMovies = _movieDBRepository.favoriteMovies;

    state = state.copyWith(
      status: FavoritesStatus.initial,
      favoriteMovies: favoriteMovies,
    );
  }

  bool isFavorite(Movie movie) {
    return state.favoriteMovies.any((e) => e.id == movie.id);
  }

  void addFavorite(Movie movie) {
    _movieDBRepository.addFavorite(movie);

    state = state.copyWith(
      status: FavoritesStatus.addToFavoriteSuccess,
      favoriteMovies: [...state.favoriteMovies, movie],
    );
  }

  void removeFavorite(Movie movie) {
    _movieDBRepository.removeFavorite(movie);

    state = state.copyWith(
      status: FavoritesStatus.removeFromFavoriteSuccess,
      favoriteMovies: state.favoriteMovies
          .where(
            (e) => e.id != movie.id,
          )
          .toList(),
    );
  }
}
