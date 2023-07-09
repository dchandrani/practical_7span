import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../widgets/widgets.dart';
import '../favorites.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites Page'),
      ),
      body: Consumer(
        builder: (context, ref, child) {
          final favorites = ref.watch(favoritesControllerProvider);

          final movies = favorites.favoriteMovies;

          if (movies.isEmpty) {
            return Center(
              child: Text(
                'You have no favorite movies yet!',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            );
          }

          final itemCount = movies.length;

          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemBuilder: (context, index) {
              final movie = movies[index];

              return MovieListTile(movie: movie);
            },
            separatorBuilder: (context, index) => const SizedBox(height: 16),
            itemCount: itemCount,
          );
        },
      ),
    );
  }
}
