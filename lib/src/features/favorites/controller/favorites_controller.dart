import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:practical_7span/main.dart';

import '../../../models/models.dart';

part 'favorites_state.dart';

final favoritesControllerProvider =
    StateNotifierProvider.autoDispose<FavoritesController, FavoritesState>(
  (ref) => FavoritesController(
    favoritesBox: ref.read(favoritesBoxProvider),
  )..init(),
);

class FavoritesController extends StateNotifier<FavoritesState> {
  FavoritesController({
    required Box<Movie> favoritesBox,
  })  : _favoritesBox = favoritesBox,
        super(const FavoritesState());

  final Box<Movie> _favoritesBox;

  void init() {
    final favoriteMovies = _favoritesBox.values.toList();

    state = state.copyWith(
      status: FavoritesStatus.initial,
      favoriteMovies: favoriteMovies,
    );
  }

  bool isFavorite(Movie movie) {
    return state.favoriteMovies.any((e) => e.id == movie.id);
  }

  Future<void> addFavorite(Movie movie) async {
    await _favoritesBox.add(movie);

    state = state.copyWith(
      status: FavoritesStatus.addToFavoriteSuccess,
      favoriteMovies: [...state.favoriteMovies, movie],
    );
  }

  Future<void> removeFavorite(Movie movie) async {
    final Movie favoriteMovie =
        _favoritesBox.values.firstWhere((element) => element.id == movie.id);

    await favoriteMovie.delete();

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
