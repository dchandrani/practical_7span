part of 'trending_movies_controller.dart';

enum TrendingMoviesStatus {
  initial,
  fetchingMoreTrendingMovies,
  fetchMoreTrendingMoviesSuccess,
  fetchMoreTrendingMoviesFailure,
}

class TrendingMoviesState extends Equatable {
  const TrendingMoviesState({
    this.status = TrendingMoviesStatus.initial,
    this.errorMessage = '',
    this.trendingMovies = const [],
    this.page = 1,
    this.hasReachedMax = false,
  });

  final TrendingMoviesStatus status;
  final String errorMessage;
  final List<Movie> trendingMovies;
  final int page;
  final bool hasReachedMax;

  TrendingMoviesState copyWith({
    TrendingMoviesStatus? status,
    String? errorMessage,
    List<Movie>? trendingMovies,
    int? page,
    bool? hasReachedMax,
  }) {
    return TrendingMoviesState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      trendingMovies: trendingMovies ?? this.trendingMovies,
      page: page ?? this.page,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object?> get props => [
        status,
        errorMessage,
        trendingMovies,
        page,
        hasReachedMax,
      ];
}
