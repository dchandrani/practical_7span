import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../../api/api.dart' show baseImageUrl;
import '../../../models/models.dart' show Movie;
import '../../../widgets/widgets.dart';

class MovieDetailPage extends StatefulWidget {
  const MovieDetailPage({
    super.key,
    required this.movie,
  });

  final Movie movie;

  @override
  State<MovieDetailPage> createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  bool isBookmarked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.movie.title),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              AspectRatio(
                aspectRatio: 1.5,
                child: CachedNetworkImage(
                  imageUrl: '$baseImageUrl${widget.movie.backdropPath}',
                  fit: BoxFit.cover,
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            '${widget.movie.title} (${widget.movie.releaseYear})',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                        ),
                        const SizedBox(width: 8),
                        BookmarkToggle(
                          isBookmarked: isBookmarked,
                          onBookmarkToggle: (isBookmarked) {
                            setState(() {
                              this.isBookmarked = isBookmarked;
                            });
                            ScaffoldMessenger.of(context)..removeCurrentSnackBar()..showSnackBar(
                              SnackBar(
                                content: Text(isBookmarked
                                    ? 'Saved to bookmarks'
                                    : 'Removed from bookmarks'),
                                behavior: SnackBarBehavior.fixed,
                                backgroundColor: Colors.grey.shade800,
                                duration: const Duration(
                                  seconds: 1,
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Overview',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      widget.movie.overview,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            wordSpacing: 1.4,
                          ),
                    ),
                    const SizedBox(height: 14),
                    Text(
                      'Release Date',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      widget.movie.releaseDate,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    const SizedBox(height: 14),
                    if (widget.movie.voteAverage != null &&
                        widget.movie.voteAverage! > 0) ...[
                      Text(
                        'Rating',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Icon(
                            Icons.star,
                            color: Colors.yellow,
                            size: 22,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '${widget.movie.voteAverage?.toStringAsFixed(1)}',
                            style:
                                Theme.of(context).textTheme.bodyLarge?.copyWith(
                                      fontSize: 16,
                                    ),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
