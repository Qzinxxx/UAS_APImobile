class Anime {
  final int id;
  final String indo;
  final String character;
  final String anime;

  Anime({required this.id, required this.indo, required this.character, required this.anime});

  factory Anime.fromJson(Map<String, dynamic> json) {
    return Anime(
      id: json['id'] ?? 0,
      indo: json['indo'] ?? '',
      character: json['character'] ?? '',
      anime: json['anime'] ?? '',
    );
  }
}
