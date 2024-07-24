class Movie {
  final String id;
  final String name;
  final String director;
  final String posterUrl;

  Movie({
    required this.id,
    required this.name,
    required this.director,
    required this.posterUrl,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'director': director,
        'posterUrl': posterUrl,
      };

  static Movie fromJson(Map<String, dynamic> json) => Movie(
        id: json['id'] ?? '', // Default value if null
        name: json['name'] ?? '',
        director: json['director'] ?? '',
        posterUrl: json['posterUrl'] ?? '',
      );
}
