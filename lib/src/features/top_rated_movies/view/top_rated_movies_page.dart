import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/models.dart' show Movie;
import '../../../widgets/widgets.dart' show MovieListTile;
import '../top_rated_movies.dart' show topRatedMoviesControllerProvider;

class TopRatedMoviesPage extends ConsumerStatefulWidget {
  const TopRatedMoviesPage({
    super.key,
    required this.topRatedMovies,
  });

  final List<Movie> topRatedMovies;

  @override
  ConsumerState<TopRatedMoviesPage> createState() => _TopRatedMoviesPageState();
}

class _TopRatedMoviesPageState extends ConsumerState<TopRatedMoviesPage> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(topRatedMoviesControllerProvider.notifier).init(
            widget.topRatedMovies,
          );
    });
  }

  bool _onScrollNotification(notification) {
    final bool hasReachedEnd = notification.metrics.pixels >
        (notification.metrics.maxScrollExtent - 280);

    if (hasReachedEnd) {
      ref.read(topRatedMoviesControllerProvider.notifier).fetchTopRatedMovies();
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(
      topRatedMoviesControllerProvider,
      (previous, next) {},
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Top Rated Movies'),
      ),
      body: Consumer(
        builder: (context, ref, child) {
          final topRatedMoviesState =
              ref.watch(topRatedMoviesControllerProvider);

          final topRatedMovies = topRatedMoviesState.topRatedMovies;

          final bool hasReachedMax = topRatedMoviesState.hasReachedMax;

          final itemCount =
              hasReachedMax ? topRatedMovies.length : topRatedMovies.length + 1;

          return NotificationListener<UserScrollNotification>(
            onNotification: _onScrollNotification,
            child: ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: itemCount,
              itemBuilder: (context, index) {
                if (index == topRatedMovies.length) {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 18.0),
                      child: CircularProgressIndicator(),
                    ),
                  );
                }

                final movie = topRatedMovies[index];

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
