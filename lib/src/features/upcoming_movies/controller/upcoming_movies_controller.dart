import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:equatable/equatable.dart';

import '../../../models/models.dart';
import '../../../repositories/movie_db_repository.dart';

part 'upcoming_movies_state.dart';

final upcomingMoviesControllerProvider = StateNotifierProvider.autoDispose<
    UpcomingMoviesController, UpcomingMoviesState>(
  (ref) => UpcomingMoviesController(
    movieDBRepository: ref.read(movieDBRepositoryProvider),
  ),
);

class UpcomingMoviesController extends StateNotifier<UpcomingMoviesState> {
  UpcomingMoviesController({required MovieDBRepository movieDBRepository})
      : _movieDBRepository = movieDBRepository,
        super(const UpcomingMoviesState());

  final MovieDBRepository _movieDBRepository;

  void init(List<Movie> upcomingMovies) {
    state = state.copyWith(
      status: UpcomingMoviesStatus.initial,
      upcomingMovies: upcomingMovies,
      page: state.page + 1,
    );
  }

  Future<void> fetchUpcomingMovies() async {
    try {
      if (state.status == UpcomingMoviesStatus.fetchingMoreUpcomingMovies) {
        return;
      }

      state = state.copyWith(
        status: UpcomingMoviesStatus.fetchingMoreUpcomingMovies,
        errorMessage: '',
      );

      final int page = state.page;
      final response = await _movieDBRepository.fetchUpcomingMovies(
        page: page,
      );

      state = state.copyWith(
        status: UpcomingMoviesStatus.fetchMoreUpcomingMoviesSuccess,
        upcomingMovies: [...state.upcomingMovies, ...response.results],
        page: page + 1,
        hasReachedMax: page == response.totalPages,
      );
    } catch (e) {
      state = state.copyWith(
        status: UpcomingMoviesStatus.fetchMoreUpcomingMoviesFailure,
        errorMessage: e.toString(),
      );
    }
  }
}
