import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:equatable/equatable.dart';

import '../../../models/models.dart';
import '../../../repositories/movie_db_repository.dart';

part 'popular_movies_state.dart';

final popularMoviesControllerProvider = StateNotifierProvider.autoDispose<
    PopularMoviesController, PopularMoviesState>(
  (ref) => PopularMoviesController(
    movieDBRepository: ref.read(movieDBRepositoryProvider),
  ),
);

class PopularMoviesController extends StateNotifier<PopularMoviesState> {
  PopularMoviesController({required MovieDBRepository movieDBRepository})
      : _movieDBRepository = movieDBRepository,
        super(const PopularMoviesState());

  final MovieDBRepository _movieDBRepository;

  void init(List<Movie> popularMovies) {
    state = state.copyWith(
      status: PopularMoviesStatus.initial,
      popularMovies: popularMovies,
      page: state.page + 1,
    );
  }

  Future<void> fetchPopularMovies() async {
    try {
      if (state.status == PopularMoviesStatus.fetchingMorePopularMovies) {
        return;
      }

      state = state.copyWith(
        status: PopularMoviesStatus.fetchingMorePopularMovies,
        errorMessage: '',
      );

      final int page = state.page;
      final response = await _movieDBRepository.fetchPopularMovies(
        page: page,
      );

      state = state.copyWith(
        status: PopularMoviesStatus.fetchMorePopularMoviesSuccess,
        popularMovies: [...state.popularMovies, ...response.results],
        page: page + 1,
        hasReachedMax: page == response.totalPages,
      );
    } catch (e) {
      state = state.copyWith(
        status: PopularMoviesStatus.fetchMorePopularMoviesFailure,
        errorMessage: e.toString(),
      );
    }
  }
}
