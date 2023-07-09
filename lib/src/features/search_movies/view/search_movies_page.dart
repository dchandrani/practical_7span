import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practical_7span/src/routing/routing.dart';
import 'package:practical_7span/src/widgets/movie_list_tile.dart';

import '../search_movies.dart';

class SearchMoviesPage extends ConsumerStatefulWidget {
  const SearchMoviesPage({super.key});

  @override
  ConsumerState<SearchMoviesPage> createState() => _SearchMoviesPageState();
}

class _SearchMoviesPageState extends ConsumerState<SearchMoviesPage> {
  @override
  Widget build(BuildContext context) {
    ref.listen(searchMoviesControllerProvider, (previous, next) {
      print('_SearchMoviesPageState.build -> next: ${next.status})');
    });

    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            const SearchAppBar(),
            const SizedBox(height: 8.0),
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
      ),
    );
  }
}
