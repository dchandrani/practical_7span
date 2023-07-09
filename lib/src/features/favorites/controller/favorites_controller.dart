import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:equatable/equatable.dart';

import '../../../models/models.dart';

part 'favorites_state.dart';

final favoritesControllerProvider =
    StateNotifierProvider.autoDispose<FavoritesController, FavoritesState>(
  (ref) => FavoritesController(),
);

class FavoritesController extends StateNotifier<FavoritesState> {
  FavoritesController() : super(const FavoritesState());

  bool isFavorite(Movie movie) {
    return state.favoriteMovies.any((e) => e.id == movie.id);
  }

  void addFavorite(Movie movie) {
    state = state.copyWith(
      status: FavoritesStatus.addToFavoriteSuccess,
      favoriteMovies: [...state.favoriteMovies, movie],
    );
  }

  void removeFavorite(Movie movie) {
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
