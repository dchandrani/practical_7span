import 'package:hive_flutter/hive_flutter.dart';

part 'movie.g.dart';

@HiveType(typeId: 0)
class Movie extends HiveObject {
  Movie({
    required this.adult,
    required this.backdropPath,
    required this.id,
    required this.title,
    required this.overview,
    required this.posterPath,
    required this.releaseDate,
    required this.voteAverage,
    required this.releaseYear,
  });

  @HiveField(0)
  final int id;
  @HiveField(2, defaultValue: false)
  final bool adult;
  @HiveField(3)
  final String? backdropPath;
  @HiveField(4)
  final String title;
  @HiveField(5)
  final String overview;
  @HiveField(6)
  final String? posterPath;
  @HiveField(7)
  final String releaseDate;
  @HiveField(8)
  final num? voteAverage;
  @HiveField(9)
  final int releaseYear;

  factory Movie.fromJson(Map<String, dynamic> json) {
    final releaseDate = json['release_date'] as String;
    final releaseYear = int.tryParse(releaseDate.split('-').first) ?? 2000;

    return Movie(
      adult: json['adult'] as bool,
      backdropPath: json['backdrop_path'] as String?,
      id: json['id'] as int,
      title: json['title'] as String,
      overview: json['overview'] as String,
      posterPath: json['poster_path'] as String?,
      releaseDate: releaseDate,
      voteAverage: json['vote_average'] as num?,
      releaseYear: releaseYear,
    );
  }

  @override
  String toString() {
    return 'Movie { adult: $adult, backdropPath: $backdropPath, id: $id, '
        'title: $title, overview: $overview, posterPath: $posterPath, '
        'releaseDate: $releaseDate, voteAverage: $voteAverage}';
  }
}
