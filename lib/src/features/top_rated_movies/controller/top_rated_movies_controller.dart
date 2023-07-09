import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:equatable/equatable.dart';

import '../../../models/models.dart';
import '../../../repositories/movie_db_repository.dart';

part 'top_rated_movies_state.dart';

final topRatedMoviesControllerProvider = StateNotifierProvider.autoDispose<
    TopRatedMoviesController, TopRatedMoviesState>(
  (ref) => TopRatedMoviesController(
    movieDBRepository: ref.read(movieDBRepositoryProvider),
  ),
);

class TopRatedMoviesController extends StateNotifier<TopRatedMoviesState> {
  TopRatedMoviesController({required MovieDBRepository movieDBRepository})
      : _movieDBRepository = movieDBRepository,
        super(const TopRatedMoviesState());

  final MovieDBRepository _movieDBRepository;

  void init(List<Movie> topRatedMovies) {
    state = state.copyWith(
      status: TopRatedMoviesStatus.initial,
      topRatedMovies: topRatedMovies,
      page: state.page + 1,
    );
  }

  Future<void> fetchTopRatedMovies() async {
    try {
      state = state.copyWith(
        status: TopRatedMoviesStatus.fetchingMoreTopRatedMovies,
        errorMessage: '',
      );

      final int page = state.page;
      final response = await _movieDBRepository.fetchTopRatedMovies(
        page: page,
      );
      state = state.copyWith(
        status: TopRatedMoviesStatus.fetchMoreTopRatedMoviesSuccess,
        topRatedMovies: [...state.topRatedMovies, ...response.results],
        page: page + 1,
      );
    } catch (e) {
      state = state.copyWith(
        status: TopRatedMoviesStatus.fetchMoreTopRatedMoviesFailure,
        errorMessage: e.toString(),
      );
    }
  }
}
