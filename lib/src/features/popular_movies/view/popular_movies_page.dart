import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../api/api.dart';
import '../../../models/models.dart';
import '../popular_movies.dart';

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
    if (notification.metrics.pixels == notification.metrics.maxScrollExtent) {
      ref.read(popularMoviesControllerProvider.notifier).fetchPopularMovies();
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(
      popularMoviesControllerProvider,
      (previous, next) {
        print('_PopularMoviesPageState.build -> ${next.status}');
      },
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Popular Movies'),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: Consumer(
        builder: (context, ref, child) {
          final popularMoviesState =
              ref.watch(popularMoviesControllerProvider);

          final popularMovies = popularMoviesState.popularMovies;

          return NotificationListener<UserScrollNotification>(
            onNotification: _onScrollNotification,
            child: ListView.separated(
              padding: const EdgeInsets.all(10),
              itemCount: popularMovies.length,
              itemBuilder: (context, index) {
                final movie = popularMovies[index];

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
