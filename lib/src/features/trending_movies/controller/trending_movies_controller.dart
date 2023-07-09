import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:equatable/equatable.dart';

import '../../../models/models.dart';
import '../../../repositories/movie_db_repository.dart';

part 'trending_movies_state.dart';

final trendingMoviesControllerProvider = StateNotifierProvider.autoDispose<
    TrendingMoviesController, TrendingMoviesState>(
  (ref) => TrendingMoviesController(
    movieDBRepository: ref.read(movieDBRepositoryProvider),
  ),
);

class TrendingMoviesController extends StateNotifier<TrendingMoviesState> {
  TrendingMoviesController({required MovieDBRepository movieDBRepository})
      : _movieDBRepository = movieDBRepository,
        super(const TrendingMoviesState());

  final MovieDBRepository _movieDBRepository;

  void init(List<Movie> trendingMovies) {
    state = state.copyWith(
      status: TrendingMoviesStatus.initial,
      trendingMovies: trendingMovies,
      page: state.page + 1,
    );
  }

  Future<void> fetchTrendingMovies() async {
    try {
      state = state.copyWith(
        status: TrendingMoviesStatus.fetchingMoreTrendingMovies,
        errorMessage: '',
      );

      final int page = state.page;
      final response = await _movieDBRepository.fetchTrendingMovies(
        page: page,
      );
      state = state.copyWith(
        status: TrendingMoviesStatus.fetchMoreTrendingMoviesSuccess,
        trendingMovies: [...state.trendingMovies, ...response.results],
        page: page + 1,
      );
    } catch (e) {
      state = state.copyWith(
        status: TrendingMoviesStatus.fetchMoreTrendingMoviesFailure,
        errorMessage: e.toString(),
      );
    }
  }
}
