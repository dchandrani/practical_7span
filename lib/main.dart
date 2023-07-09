import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'src/app.dart' show TheMovieDBApp;
import 'src/models/models.dart' show Movie, MovieAdapter;

final favoritesBoxProvider = Provider<Box<Movie>>((ref) {
  throw UnimplementedError();
});

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
