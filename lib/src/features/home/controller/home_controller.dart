import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/models.dart';
import '../../../repositories/movie_db_repository.dart';

part 'home_state.dart';

final homeControllerProvider =
    StateNotifierProvider.autoDispose<HomeController, HomeState>(
  (ref) => HomeController(
    movieDBRepository: ref.read(movieDBRepositoryProvider),
  )..fetchTrendingMovies(),
);

class HomeController extends StateNotifier<HomeState> {
  HomeController({
    required MovieDBRepository movieDBRepository,
  })  : _movieDBRepository = movieDBRepository,
        super(const HomeState());

  final MovieDBRepository _movieDBRepository;

  Future<void> fetchTrendingMovies() async {
    try {
      state = state.copyWith(
        status: HomeStatus.fetchingMovies,
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
        status: HomeStatus.fetchMoviesSuccess,
        errorMessage: '',
        trendingMovies: response.elementAt(0).results,
        popularMovies: response.elementAt(1).results,
        topRatedMovies: response.elementAt(2).results,
        upcomingMovies: response.elementAt(3).results,
      );
    } catch (e) {
      state = state.copyWith(
        status: HomeStatus.fetchMoviesFailure,
        errorMessage: e.toString(),
      );
    }
  }
}
