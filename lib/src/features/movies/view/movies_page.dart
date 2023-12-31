import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../routing/routing.dart';
import '../../home/home.dart' show MoviesListWithTitle;
import '../movies.dart' show MoviesStatus, moviesControllerProvider;

class MoviesPage extends StatelessWidget {
  const MoviesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TMDb App'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // const HomeAppBar(),
          Expanded(
            child: Consumer(
              builder: (context, ref, child) {
                final homeState = ref.watch(moviesControllerProvider);

                final status = homeState.status;

                switch (status) {
                  case MoviesStatus.fetchingMovies:
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  case MoviesStatus.fetchMoviesFailure:
                    return const Center(
                      child: Text('Something went wrong!'),
                    );
                  default:
                    final trendingMovies = homeState.trendingMovies;
                    final popularMovies = homeState.popularMovies;
                    final upcomingMovies = homeState.upcomingMovies;
                    final topRatedMovies = homeState.topRatedMovies;

                    return ListView(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12.0,
                        vertical: 8.0,
                      ),
                      children: [
                        MoviesListWithTitle(
                          title: 'Trending Movies',
                          movies: trendingMovies,
                          onViewAllTap: () {
                            Navigator.pushNamed(
                              context,
                              Routing.trendingMoviesPage,
                              arguments: trendingMovies,
                            );
                          },
                        ),
                        const SizedBox(height: 16.0),
                        MoviesListWithTitle(
                            title: 'Popular Movies',
                            movies: popularMovies,
                            onViewAllTap: () {
                              Navigator.pushNamed(
                                context,
                                Routing.popularMoviesPage,
                                arguments: popularMovies,
                              );
                            }),
                        const SizedBox(height: 16.0),
                        MoviesListWithTitle(
                          title: 'Upcoming Movies',
                          movies: upcomingMovies,
                          onViewAllTap: () {
                            Navigator.pushNamed(
                              context,
                              Routing.upcomingMoviesPage,
                              arguments: upcomingMovies,
                            );
                          },
                        ),
                        const SizedBox(height: 16.0),
                        MoviesListWithTitle(
                          title: 'Top Rated Movies',
                          movies: topRatedMovies,
                          onViewAllTap: () {
                            Navigator.pushNamed(
                              context,
                              Routing.topRatedMoviesPage,
                              arguments: topRatedMovies,
                            );
                          },
                        ),
                      ],
                    );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
