class PuzzleData {
  PuzzleData({
    required this.level,
    required this.difficulty,
    required this.points,
    required this.imageUrl,
  });

  final int level;
  final int difficulty;
  final int points;
  final String imageUrl;

  factory PuzzleData.fromJson(Map<String, dynamic> json) => PuzzleData(
        level: json["level"],
        difficulty: json["difficulty"],
        points: json["points"],
        imageUrl: json["imageUrl"],
      );
}
