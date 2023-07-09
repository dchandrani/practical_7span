import 'package:flutter/material.dart' show MaterialPageRoute, Route, RouteSettings;

import '../features/home/home.dart' show HomePage;
import '../features/movie_detail/movie_detail.dart';
import '../features/popular_movies/popular_movies.dart' show PopularMoviesPage;
import '../features/top_rated_movies/top_rated_movies.dart' show TopRatedMoviesPage;
import '../features/trending_movies/trending_movies.dart' show TrendingMoviesPage;
import '../features/upcoming_movies/upcoming_movies.dart' show UpcomingMoviesPage;
import '../models/models.dart' show Movie;

class Routing {
  static const String homePage = '/';
  static const String trendingMoviesPage = '/trending-movies';
  static const String popularMoviesPage = '/popular-movies';
  static const String topRatedMoviesPage = '/top-rated-movies';
  static const String upcomingMoviesPage = '/upcoming-movies';
  static const String movieDetailPage = '/movie-detail';

  static Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case homePage:
        return MaterialPageRoute(
          builder: (context) => const HomePage(),
        );
      case trendingMoviesPage:
        return MaterialPageRoute(
          builder: (context) => TrendingMoviesPage(
            trendingMovies: settings.arguments as List<Movie>,
          ),
        );
      case popularMoviesPage:
        return MaterialPageRoute(
          builder: (context) => PopularMoviesPage(
            popularMovies: settings.arguments as List<Movie>,
          ),
        );
      case topRatedMoviesPage:
        return MaterialPageRoute(
          builder: (context) => TopRatedMoviesPage(
            topRatedMovies: settings.arguments as List<Movie>,
          ),
        );
      case upcomingMoviesPage:
        return MaterialPageRoute(
          builder: (context) => UpcomingMoviesPage(
            upcomingMovies: settings.arguments as List<Movie>,
          ),
        );
        case movieDetailPage:
        return MaterialPageRoute(
          builder: (context) => MovieDetailPage(
            movie: settings.arguments as Movie,
          ),
        );
      default:
        throw Exception('Route not found');
    }
  }
}
