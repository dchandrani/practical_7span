import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../../routing/routing.dart';
import '../../../api/api.dart' show baseImageUrl;
import '../../../models/models.dart' show Movie;

class MovieListItem extends StatelessWidget {
  const MovieListItem({
    super.key,
    required this.movie,
  });

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          Routing.movieDetailPage,
          arguments: movie,
        );
      },
      behavior: HitTestBehavior.opaque,
      child: Column(
        children: [
          SizedBox(
            height: 180,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Stack(
                children: [
                  CachedNetworkImage(
                    imageUrl: '$baseImageUrl${movie.posterPath}',
                    fit: BoxFit.cover,
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                  AverageVoteCount(
                    voteAverage: movie.voteAverage,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 4),
          SizedBox(
            width: 120,
            child: Text(
              movie.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }
}

class AverageVoteCount extends StatelessWidget {
  const AverageVoteCount({
    super.key,
    this.voteAverage,
  });

  final num? voteAverage;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: voteAverage != null && voteAverage! > 0,
      child: Positioned(
        right: 4,
        top: 4,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.5),
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 6,
            vertical: 2,
          ),
          child: Text(
            '${voteAverage?.toStringAsFixed(1)}',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontSize: 10,
                ),
          ),
        ),
      ),
    );
  }
}
