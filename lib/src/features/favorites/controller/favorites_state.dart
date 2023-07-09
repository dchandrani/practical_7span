part of 'favorites_controller.dart';

enum FavoritesStatus {
  initial,
  fetchFavoritesSuccess,
  addToFavoriteSuccess,
  removeFromFavoriteSuccess,
}

class FavoritesState extends Equatable {
  const FavoritesState({
    this.status = FavoritesStatus.initial,
    this.favoriteMovies = const [],
    this.message = '',
  });

  final List<Movie> favoriteMovies;
  final FavoritesStatus status;
  final String message;

  FavoritesState copyWith({
    List<Movie>? favoriteMovies,
    FavoritesStatus? status,
    String? message,
  }) {
    return FavoritesState(
      favoriteMovies: favoriteMovies ?? this.favoriteMovies,
      status: status ?? this.status,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [favoriteMovies, status, message];
}
