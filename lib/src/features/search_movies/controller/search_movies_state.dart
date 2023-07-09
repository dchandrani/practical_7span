part of 'search_movies_controller.dart';

enum SearchStatus {
  initial,
  searching,
  searchSuccess,
  searchFailure,
}

class SearchMoviesState extends Equatable {
  const SearchMoviesState({
    this.status = SearchStatus.initial,
    this.movies = const <Movie>[],
    this.errorMessage = '',
    this.hasReachedMax = false,
  });

  final SearchStatus status;
  final String errorMessage;
  final List<Movie> movies;
  final bool hasReachedMax;

  SearchMoviesState copyWith({
    SearchStatus? status,
    List<Movie>? movies,
    String? errorMessage,
    bool? hasReachedMax,
  }) {
    return SearchMoviesState(
      status: status ?? this.status,
      movies: movies ?? this.movies,
      errorMessage: errorMessage ?? this.errorMessage,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object> get props => [
        status,
        movies,
        errorMessage,
        hasReachedMax,
      ];
}
