class Movie {
  const Movie({
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

  final bool adult;
  final String? backdropPath;
  final int id;
  final String title;
  final String overview;
  final String? posterPath;
  final String releaseDate;
  final num? voteAverage;
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
