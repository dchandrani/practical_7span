import 'package:flutter/material.dart';

import 'routing/routing.dart';

class TheMovieDBApp extends StatelessWidget {
  const TheMovieDBApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'The Movie DB',
      debugShowCheckedModeBanner: false,
      darkTheme: ThemeData.dark().copyWith(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
        ),
        useMaterial3: true,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.deepPurple.shade500,
          centerTitle: true,
          titleTextStyle: Theme.of(context).textTheme.titleLarge?.copyWith(
            color: Colors.white,
            fontFamily: 'Nunito'
          ),
          iconTheme: const IconThemeData(
            color: Colors.white,
          ),
        ),
      ),
      themeMode: ThemeMode.dark,
      onGenerateRoute: Routing.onGenerateRoute,
    );
  }
}
