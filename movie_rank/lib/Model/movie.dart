class Movie {
  final int id;
  final double? voteAverage;
  final String title;
  final String posterUrl;
  final List<dynamic> genres;
  final String releaseDate; 
  late String? tagLine;
  late String? overview;

  Movie({
    required this.id,
    required this.voteAverage,
    required this.title,
    required this.posterUrl,
    required this.genres,
    required this.releaseDate,
    this.tagLine,
    this.overview,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'],
      voteAverage: json['vote_avarege'],
      title: json['title'],
      posterUrl: json['poster_url'],
      genres: json['genres'],
      releaseDate: json['release_date'],
      tagLine: json['tagline'],
      overview: json['overview'],
    );
  }
 
  Map<String, dynamic> toJson() => {
    'id': id,
    'vote_avarege': voteAverage,
    'title': title,
    'poster_url': posterUrl,
    'genres': genres,
    'release_date': releaseDate,
    'tagline': tagLine,
    'overview': overview,
  };
}