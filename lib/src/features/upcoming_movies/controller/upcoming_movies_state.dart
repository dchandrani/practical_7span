part of 'upcoming_movies_controller.dart';

enum UpcomingMoviesStatus {
  initial,
  fetchingMoreUpcomingMovies,
  fetchMoreUpcomingMoviesSuccess,
  fetchMoreUpcomingMoviesFailure,
}

class UpcomingMoviesState extends Equatable {
  const UpcomingMoviesState({
    this.status = UpcomingMoviesStatus.initial,
    this.errorMessage = '',
    this.upcomingMovies = const [],
    this.page = 1,
    this.hasReachedMax = false,
  });

  final UpcomingMoviesStatus status;
  final String errorMessage;
  final List<Movie> upcomingMovies;
  final int page;
  final bool hasReachedMax;

  UpcomingMoviesState copyWith({
    UpcomingMoviesStatus? status,
    String? errorMessage,
    List<Movie>? upcomingMovies,
    int? page,
    bool? hasReachedMax,
  }) {
    return UpcomingMoviesState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      upcomingMovies: upcomingMovies ?? this.upcomingMovies,
      page: page ?? this.page,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object?> get props => [
        status,
        errorMessage,
        upcomingMovies,
        page,
        hasReachedMax,
      ];
}
