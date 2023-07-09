import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:equatable/equatable.dart';
import 'package:practical_7span/src/repositories/movie_db_repository.dart';

import '../../../models/models.dart' show Movie;

part 'search_movies_state.dart';

final searchMoviesControllerProvider =
    StateNotifierProvider.autoDispose<SearchMoviesController, SearchMoviesState>(
  (ref) => SearchMoviesController(
    movieDBRepository: ref.read(movieDBRepositoryProvider),
  ),
);

class SearchMoviesController extends StateNotifier<SearchMoviesState> {
  SearchMoviesController({
    required MovieDBRepository movieDBRepository,
  })  : _movieDBRepository = movieDBRepository,
        super(const SearchMoviesState());

  final MovieDBRepository _movieDBRepository;

  Future<void> searchMovies(String query) async {
    if (state.status == SearchStatus.searching) {
      return;
    }

    try {
      state = state.copyWith(status: SearchStatus.searching);

      final response = await _movieDBRepository.searchMovies(query);

      state = state.copyWith(
        status: SearchStatus.searchSuccess,
        movies: response.results,
        hasReachedMax: response.page == response.totalPages,
      );
    } catch (e) {
      state = state.copyWith(
        status: SearchStatus.searchFailure,
        errorMessage: e.toString(),
      );
    }
  }

  void reset() {
    state = const SearchMoviesState();
  }
}
