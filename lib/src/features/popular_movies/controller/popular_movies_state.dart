part of 'popular_movies_controller.dart';

enum PopularMoviesStatus {
  initial,
  fetchingMorePopularMovies,
  fetchMorePopularMoviesSuccess,
  fetchMorePopularMoviesFailure,
}

class PopularMoviesState extends Equatable {
  const PopularMoviesState({
    this.status = PopularMoviesStatus.initial,
    this.errorMessage = '',
    this.popularMovies = const [],
    this.page = 1,
    this.hasReachedMax = false,
  });

  final PopularMoviesStatus status;
  final String errorMessage;
  final List<Movie> popularMovies;
  final int page;
  final bool hasReachedMax;

  PopularMoviesState copyWith({
    PopularMoviesStatus? status,
    String? errorMessage,
    List<Movie>? popularMovies,
    int? page,
    bool? hasReachedMax,
  }) {
    return PopularMoviesState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      popularMovies: popularMovies ?? this.popularMovies,
      page: page ?? this.page,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object?> get props => [
        status,
        errorMessage,
        popularMovies,
        page,
        hasReachedMax,
      ];
}
