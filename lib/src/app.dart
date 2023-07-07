import 'package:flutter/material.dart';

import 'features/home/home.dart';

class TheMovieDBApp extends StatelessWidget {
  const TheMovieDBApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'The Movie DB',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        fontFamily: 'Nunito',
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}
