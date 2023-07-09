import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../api/api.dart';
import '../../../models/models.dart';
import '../upcoming_movies.dart';

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
    if (notification.metrics.pixels == notification.metrics.maxScrollExtent) {
      ref.read(upcomingMoviesControllerProvider.notifier).fetchUpcomingMovies();
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(
      upcomingMoviesControllerProvider,
      (previous, next) {
        print('_UpcomingMoviesPageState.build -> ${next.status}');
      },
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

          return NotificationListener<UserScrollNotification>(
            onNotification: _onScrollNotification,
            child: ListView.separated(
              padding: const EdgeInsets.all(10),
              itemCount: upcomingMovies.length,
              itemBuilder: (context, index) {
                final movie = upcomingMovies[index];

                return Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: CachedNetworkImage(
                            imageUrl: '$baseImageUrl${movie.posterPath}',
                            fit: BoxFit.cover,
                            height: 140,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                movie.releaseDate.split('-').first,
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                movie.title,
                                style: Theme.of(context).textTheme.titleMedium,
                              ),

                              const SizedBox(height: 4),
                              Text(
                                movie.overview,
                                style: Theme.of(context).textTheme.bodySmall,
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 4),
                              Visibility(
                                visible: movie.voteAverage != null,
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.star_outlined,
                                      size: 16,
                                      color: Colors.yellow,
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      movie.voteAverage!.toStringAsFixed(2),
                                      style: Theme.of(context).textTheme.bodySmall,
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),

                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
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
