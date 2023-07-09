import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/models.dart' show Movie;
import '../../../widgets/widgets.dart' show MovieListTile;
import '../popular_movies.dart' show popularMoviesControllerProvider;

class PopularMoviesPage extends ConsumerStatefulWidget {
  const PopularMoviesPage({
    super.key,
    required this.popularMovies,
  });

  final List<Movie> popularMovies;

  @override
  ConsumerState<PopularMoviesPage> createState() => _PopularMoviesPageState();
}

class _PopularMoviesPageState extends ConsumerState<PopularMoviesPage> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(popularMoviesControllerProvider.notifier).init(
            widget.popularMovies,
          );
    });
  }

  bool _onScrollNotification(notification) {
    final bool hasReachedEnd = notification.metrics.pixels >
        (notification.metrics.maxScrollExtent - 280);

    if (hasReachedEnd) {
      ref.read(popularMoviesControllerProvider.notifier).fetchPopularMovies();
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(
      popularMoviesControllerProvider,
      (previous, next) {},
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Popular Movies'),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: Consumer(
        builder: (context, ref, child) {
          final popularMoviesState = ref.watch(popularMoviesControllerProvider);

          final popularMovies = popularMoviesState.popularMovies;

          final bool hasReachedMax = popularMoviesState.hasReachedMax;

          final itemCount =
              hasReachedMax ? popularMovies.length : popularMovies.length + 1;

          return NotificationListener<UserScrollNotification>(
            onNotification: _onScrollNotification,
            child: ListView.separated(
              padding: const EdgeInsets.all(10),
              itemCount: itemCount,
              itemBuilder: (context, index) {
                if (index == popularMovies.length) {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 18.0),
                      child: CircularProgressIndicator(),
                    ),
                  );
                }

                final movie = popularMovies[index];

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
