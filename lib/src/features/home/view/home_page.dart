import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practical_7span/src/features/favorites/controller/favorites_controller.dart';

import '../../search_movies/search_movies.dart' show SearchMoviesPage;
import '../../favorites/favorites.dart' show FavoritesPage, favoritesControllerProvider;
import '../../movies/movies.dart' show MoviesPage;

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  int _currentIndex = 0;

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(message),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.grey.shade800,
          duration: const Duration(
            seconds: 1,
          ),
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(
      favoritesControllerProvider,
      (previous, next) {
        if (next.status == FavoritesStatus.addToFavoriteSuccess) {
          _showSnackBar('Added to favorites');
        } else if (next.status == FavoritesStatus.removeFromFavoriteSuccess) {
          _showSnackBar('Removed from favorites');
        }
      },
    );

    return Scaffold(
        body: Column(
          children: [
            Expanded(
              child: IndexedStack(
                index: _currentIndex,
                children: const [
                  MoviesPage(),
                  SearchMoviesPage(),
                  FavoritesPage(),
                ],
              ),
            ),
            Divider(
              height: 1,
              thickness: 1,
              color: Colors.grey.shade800,
            ),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
            FocusScope.of(context).unfocus();
          },
          selectedItemColor: Theme.of(context).colorScheme.inversePrimary,
          unselectedItemColor: Colors.grey.shade500,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.movie),
              label: 'Movies',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search_rounded),
              label: 'Search',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.bookmark),
              label: 'Favorites',
            ),
          ],
        ));
  }
}
