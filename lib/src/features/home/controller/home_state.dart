part of 'home_controller.dart';

enum HomeStatus {
  initial,
  fetchingMovies,
  fetchMoviesSuccess,
  fetchMoviesFailure,
}

class HomeState extends Equatable {
  const HomeState({
    this.status = HomeStatus.initial,
    this.errorMessage = '',
    this.trendingMovies = const [],
    this.popularMovies = const [],
    this.topRatedMovies = const [],
    this.upcomingMovies = const [],
  });

  factory HomeState.initial() => const HomeState();

  factory HomeState.fetchingMovies() => const HomeState(
        status: HomeStatus.fetchingMovies,
        errorMessage: '',
      );

  factory HomeState.fetchMoviesSuccess({
    required List<Movie> trendingMovies,
    required List<Movie> popularMovies,
    required List<Movie> topRatedMovies,
    required List<Movie> upcomingMovies,
  }) =>
      HomeState(
        status: HomeStatus.fetchMoviesSuccess,
        errorMessage: '',
        trendingMovies: trendingMovies,
      );

  factory HomeState.fetchMoviesFailure(String message) => HomeState(
        status: HomeStatus.fetchMoviesFailure,
        errorMessage: message,
      );

  final HomeStatus status;
  final String errorMessage;
  final List<Movie> trendingMovies;
  final List<Movie> popularMovies;
  final List<Movie> topRatedMovies;
  final List<Movie> upcomingMovies;

  HomeState copyWith({
    HomeStatus? status,
    String? errorMessage,
    List<Movie>? trendingMovies,
    List<Movie>? popularMovies,
    List<Movie>? topRatedMovies,
    List<Movie>? upcomingMovies,
  }) {
    return HomeState(
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
