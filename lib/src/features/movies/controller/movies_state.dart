part of 'movies_controller.dart';

enum MoviesStatus {
  initial,
  fetchingMovies,
  fetchMoviesSuccess,
  fetchMoviesFailure,
}

class MoviesState extends Equatable {
  const MoviesState({
    this.status = MoviesStatus.initial,
    this.errorMessage = '',
    this.trendingMovies = const [],
    this.popularMovies = const [],
    this.topRatedMovies = const [],
    this.upcomingMovies = const [],
  });

  factory MoviesState.initial() => const MoviesState();

  factory MoviesState.fetchingMovies() => const MoviesState(
        status: MoviesStatus.fetchingMovies,
        errorMessage: '',
      );

  factory MoviesState.fetchMoviesSuccess({
    required List<Movie> trendingMovies,
    required List<Movie> popularMovies,
    required List<Movie> topRatedMovies,
    required List<Movie> upcomingMovies,
  }) =>
      MoviesState(
        status: MoviesStatus.fetchMoviesSuccess,
        errorMessage: '',
        trendingMovies: trendingMovies,
      );

  factory MoviesState.fetchMoviesFailure(String message) => MoviesState(
        status: MoviesStatus.fetchMoviesFailure,
        errorMessage: message,
      );

  final MoviesStatus status;
  final String errorMessage;
  final List<Movie> trendingMovies;
  final List<Movie> popularMovies;
  final List<Movie> topRatedMovies;
  final List<Movie> upcomingMovies;

  MoviesState copyWith({
    MoviesStatus? status,
    String? errorMessage,
    List<Movie>? trendingMovies,
    List<Movie>? popularMovies,
    List<Movie>? topRatedMovies,
    List<Movie>? upcomingMovies,
  }) {
    return MoviesState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      trendingMovies: trendingMovies ?? this.trendingMovies,
      popularMovies: popularMovies ?? this.popularMovies,
      topRatedMovies: topRatedMovies ?? this.topRatedMovies,
      upcomingMovies: upcomingMovies ?? this.upcomingMovies,
    );
  }

  @override
  List<Object?> get props => [
        status,
        errorMessage,
        trendingMovies,
        popularMovies,
        topRatedMovies,
        upcomingMovies,
      ];
}
