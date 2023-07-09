import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'src/features/favorites/favorites.dart' show favoritesBoxProvider;
import 'src/app.dart' show TheMovieDBApp;
import 'src/models/models.dart' show Movie, MovieAdapter;

void main() async {
  await Hive.initFlutter();

  Hive.registerAdapter<Movie>(MovieAdapter());

  final Box<Movie> favoritesBox = await Hive.openBox<Movie>('favorites');

  runApp(
    ProviderScope(
      overrides: [
        favoritesBoxProvider.overrideWithValue(favoritesBox),
      ],
      child: const TheMovieDBApp(),
    ),
  );
}
