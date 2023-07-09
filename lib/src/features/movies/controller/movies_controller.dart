import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/models.dart';
import '../../../repositories/movie_db_repository.dart';

part 'movies_state.dart';

final moviesControllerProvider =
    StateNotifierProvider.autoDispose<MoviesController, MoviesState>(
  (ref) => MoviesController(
    movieDBRepository: ref.read(movieDBRepositoryProvider),
  )..fetchMovies(),
);

class MoviesController extends StateNotifier<MoviesState> {
  MoviesController({
    required MovieDBRepository movieDBRepository,
  })  : _movieDBRepository = movieDBRepository,
        super(const MoviesState());

  final MovieDBRepository _movieDBRepository;

  Future<void> fetchMovies() async {
    try {
      state = state.copyWith(
        status: MoviesStatus.fetchingMovies,
        errorMessage: '',
      );

      final List<MoviesResponseModel> response = await Future.wait(
        [
          _movieDBRepository.fetchTrendingMovies(),
          _movieDBRepository.fetchPopularMovies(),
          _movieDBRepository.fetchTopRatedMovies(),
          _movieDBRepository.fetchUpcomingMovies(),
        ],
      );

      state = state.copyWith(
        status: MoviesStatus.fetchMoviesSuccess,
        errorMessage: '',
        trendingMovies: response.elementAt(0).results,
        popularMovies: response.elementAt(1).results,
        topRatedMovies: response.elementAt(2).results,
        upcomingMovies: response.elementAt(3).results,
      );
    } catch (e) {
      state = state.copyWith(
        status: MoviesStatus.fetchMoviesFailure,
        errorMessage: e.toString(),
      );
    }
  }
}
