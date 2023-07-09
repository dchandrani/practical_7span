import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../api/api.dart';
import '../../../models/models.dart';
import '../top_rated_movies.dart';

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
    if (notification.metrics.pixels == notification.metrics.maxScrollExtent) {
      ref.read(topRatedMoviesControllerProvider.notifier).fetchTopRatedMovies();
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(
      topRatedMoviesControllerProvider,
      (previous, next) {
        print('_TopRatedMoviesPageState.build -> ${next.status}');
      },
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Top Rated Movies'),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: Consumer(
        builder: (context, ref, child) {
          final topRatedMoviesState =
              ref.watch(topRatedMoviesControllerProvider);

          final topRatedMovies = topRatedMoviesState.topRatedMovies;

          return NotificationListener<UserScrollNotification>(
            onNotification: _onScrollNotification,
            child: ListView.separated(
              padding: const EdgeInsets.all(10),
              itemCount: topRatedMovies.length,
              itemBuilder: (context, index) {
                final movie = topRatedMovies[index];

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
