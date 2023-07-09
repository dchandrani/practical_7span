part of 'top_rated_movies_controller.dart';

enum TopRatedMoviesStatus {
  initial,
  fetchingMoreTopRatedMovies,
  fetchMoreTopRatedMoviesSuccess,
  fetchMoreTopRatedMoviesFailure,
}

class TopRatedMoviesState extends Equatable {
  const TopRatedMoviesState({
    this.status = TopRatedMoviesStatus.initial,
    this.errorMessage = '',
    this.topRatedMovies = const [],
    this.page = 1,
    this.hasReachedMax = false,
  });

  final TopRatedMoviesStatus status;
  final String errorMessage;
  final List<Movie> topRatedMovies;
  final int page;
  final bool hasReachedMax;

  TopRatedMoviesState copyWith({
    TopRatedMoviesStatus? status,
    String? errorMessage,
    List<Movie>? topRatedMovies,
    int? page,
    bool? hasReachedMax,
  }) {
    return TopRatedMoviesState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      topRatedMovies: topRatedMovies ?? this.topRatedMovies,
      page: page ?? this.page,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object?> get props => [
        status,
        errorMessage,
        topRatedMovies,
        page,
        hasReachedMax,
      ];
}
