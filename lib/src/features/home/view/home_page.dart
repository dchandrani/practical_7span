import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../routing/routing.dart';
import '../home.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const HomeAppBar(),
          Expanded(
            child: Consumer(
              builder: (context, ref, child) {
                final homeState = ref.watch(homeControllerProvider);

                final status = homeState.status;

                switch (status) {
                  case HomeStatus.fetchingMovies:
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  case HomeStatus.fetchMoviesFailure:
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
                          }
                        ),
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
