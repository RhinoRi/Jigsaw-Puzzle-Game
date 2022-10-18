import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:jigsaw_puzzle_game_app/utils/api_services/puzzle_data_service.dart';
import 'package:jigsaw_puzzle_game_app/utils/constants/color_constants.dart';

import '../../models/puzzle_data.dart';
import '../puzzles/puzzle_list_levels.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<PuzzleData>>(
        future: fetchPuzzleData(http.Client()),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text("Error: ${snapshot.error}");
          } else if (snapshot.hasData) {
            return PuzzleListLevels(data: snapshot.data!);
            // GameScreen(data: snapshot.data!);
          } else {
            return Center(
              child: CircularProgressIndicator(
                color: primaryBlue,
              ),
            );
          }
        },
      ),
    );
  }
}
