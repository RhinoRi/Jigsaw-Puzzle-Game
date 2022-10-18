import 'dart:convert';
import 'package:jigsaw_puzzle_game_app/utils/models/puzzle_data.dart';
import 'package:http/http.dart' as http;

var url = "https://app.appio.me/rnd/grablor_puzzle/getlevels/0.json";

List<PuzzleData> parseData(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
  return parsed.map<PuzzleData>((json) => PuzzleData.fromJson(json)).toList();
}

Future<List<PuzzleData>> fetchPuzzleData(http.Client client) async {
  final response = await client.get(
    Uri.parse(url),
  );
  return parseData(response.body);
}
