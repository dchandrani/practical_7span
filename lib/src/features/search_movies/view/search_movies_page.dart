import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../widgets/movie_list_tile.dart' show MovieListTile;
import '../search_movies.dart';

class SearchMoviesPage extends ConsumerStatefulWidget {
  const SearchMoviesPage({super.key});

  @override
  ConsumerState<SearchMoviesPage> createState() => _SearchMoviesPageState();
}

class _SearchMoviesPageState extends ConsumerState<SearchMoviesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SearchAppBar(),
          Expanded(
            child: Consumer(
              builder: (context, ref, child) {
                final searchState = ref.watch(searchMoviesControllerProvider);

                final movies = searchState.movies;
                final itemCount = movies.length;

                if (itemCount == 0) {
                  if (searchState.status == SearchStatus.searching) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  if (searchState.status == SearchStatus.searchFailure) {
                    return const Center(
                      child: Text('Something went wrong!'),
                    );
                  }

                  return const Center(
                    child: Text('No movies found!'),
                  );
                }

                return ListView.separated(
                  padding: const EdgeInsets.all(10),
                  itemBuilder: (context, index) {
                    final movie = movies[index];

                    return MovieListTile(movie: movie);
                  },
                  separatorBuilder: (context, index) => const SizedBox(height: 16),
                  itemCount: itemCount,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
