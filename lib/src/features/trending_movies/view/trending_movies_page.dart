import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/models.dart' show Movie;
import '../../../widgets/widgets.dart' show MovieListTile;
import '../trending_movies.dart'
    show TrendingMoviesStatus, trendingMoviesControllerProvider;

class TrendingMoviesPage extends ConsumerStatefulWidget {
  const TrendingMoviesPage({
    super.key,
    required this.trendingMovies,
  });

  final List<Movie> trendingMovies;

  @override
  ConsumerState<TrendingMoviesPage> createState() => _TrendingMoviesPageState();
}

class _TrendingMoviesPageState extends ConsumerState<TrendingMoviesPage> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(trendingMoviesControllerProvider.notifier).init(
            widget.trendingMovies,
          );
    });
  }

  bool _onScrollNotification(notification) {
    final bool hasReachedEnd = notification.metrics.pixels >
        (notification.metrics.maxScrollExtent - 280);

    if (hasReachedEnd) {
      ref.read(trendingMoviesControllerProvider.notifier).fetchTrendingMovies();
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(
      trendingMoviesControllerProvider,
      (previous, next) {},
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Trending Movies'),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: Consumer(
        builder: (context, ref, child) {
          final trendingMoviesState =
              ref.watch(trendingMoviesControllerProvider);

          final trendingMovies = trendingMoviesState.trendingMovies;

          final bool hasReachedMax = trendingMoviesState.hasReachedMax;

          final itemCount =
              hasReachedMax ? trendingMovies.length : trendingMovies.length + 1;

          return NotificationListener<UserScrollNotification>(
            onNotification: _onScrollNotification,
            child: ListView.separated(
              padding: const EdgeInsets.all(10),
              itemCount: itemCount,
              itemBuilder: (context, index) {
                if (index == trendingMovies.length) {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 18.0),
                      child: CircularProgressIndicator(),
                    ),
                  );
                }

                final movie = trendingMovies[index];

                return MovieListTile(
                  movie: movie,
                );
              },
              separatorBuilder: (context, index) => const SizedBox(height: 16),
            ),
          );
        },
      ),
    );
  }
}
