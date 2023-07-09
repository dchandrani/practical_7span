import 'package:flutter/material.dart';

import '../../../models/models.dart' show Movie;
import '../../../routing/routing.dart';
import '../../../widgets/widgets.dart' show MovieListItem;
import '../home.dart' show MoviesTitle;

class MoviesListWithTitle extends StatelessWidget {
  const MoviesListWithTitle({
    super.key,
    required this.title,
    required this.movies,
    required this.onViewAllTap,
  });

  final String title;
  final List<Movie> movies;
  final VoidCallback onViewAllTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MoviesTitle(
          title: title,
          onViewAllTap: onViewAllTap
        ),
        const SizedBox(height: 2.0),
        SizedBox(
          height: 220,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              final trendingMovie = movies[index];

              return MovieListItem(movie: trendingMovie);
            },
            separatorBuilder: (context, index) => const SizedBox(width: 10),
            itemCount: movies.length,
          ),
        ),
      ],
    );
  }
}
