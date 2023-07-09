import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/models.dart' show Movie;
import '../../../widgets/widgets.dart' show MovieListTile;
import '../upcoming_movies.dart' show upcomingMoviesControllerProvider;

class UpcomingMoviesPage extends ConsumerStatefulWidget {
  const UpcomingMoviesPage({
    super.key,
    required this.upcomingMovies,
  });

  final List<Movie> upcomingMovies;

  @override
  ConsumerState<UpcomingMoviesPage> createState() => _UpcomingMoviesPageState();
}

class _UpcomingMoviesPageState extends ConsumerState<UpcomingMoviesPage> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(upcomingMoviesControllerProvider.notifier).init(
            widget.upcomingMovies,
          );
    });
  }

  bool _onScrollNotification(notification) {
    final bool hasReachedEnd = notification.metrics.pixels >
        (notification.metrics.maxScrollExtent - 280);

    if (hasReachedEnd) {
      ref.read(upcomingMoviesControllerProvider.notifier).fetchUpcomingMovies();
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(
      upcomingMoviesControllerProvider,
      (previous, next) {},
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Upcoming Movies'),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: Consumer(
        builder: (context, ref, child) {
          final upcomingMoviesState =
              ref.watch(upcomingMoviesControllerProvider);

          final upcomingMovies = upcomingMoviesState.upcomingMovies;
          final bool hasReachedMax = upcomingMoviesState.hasReachedMax;

          final itemCount =
              hasReachedMax ? upcomingMovies.length : upcomingMovies.length + 1;

          return NotificationListener<UserScrollNotification>(
            onNotification: _onScrollNotification,
            child: ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: itemCount,
              itemBuilder: (context, index) {
                if (index == upcomingMovies.length) {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 18.0),
                      child: CircularProgressIndicator(),
                    ),
                  );
                }

                final movie = upcomingMovies[index];

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
