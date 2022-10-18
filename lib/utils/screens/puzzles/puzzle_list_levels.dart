import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jigsaw_puzzle_game_app/utils/constants/color_constants.dart';
import 'package:jigsaw_puzzle_game_app/utils/models/puzzle_data.dart';
import 'package:jigsaw_puzzle_game_app/utils/screens/puzzles/game_screen.dart';

class PuzzleListLevels extends StatelessWidget {
  const PuzzleListLevels({Key? key, required this.data}) : super(key: key);
  final List<PuzzleData> data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        centerTitle: true,
        title: Text(
          "SELECT LEVEL",
          style: GoogleFonts.varelaRound(
            textStyle: const TextStyle(
              fontSize: 22.0,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.5,
            ),
          ),
        ),
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
        ),
        itemCount: data.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(
                top: 15.0, left: 10.0, right: 10.0, bottom: 15.0),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => GameScreen(
                      data: data[index],
                    ),
                  ),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(
                      color: primaryBlue,
                      width: 5.0,
                    ),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(15.0),
                    ),
                    image: DecorationImage(
                      image: NetworkImage(data[index].imageUrl),
                      colorFilter: ColorFilter.mode(
                          Colors.black.withOpacity(0.2), BlendMode.dstATop),
                    )),
                child: Center(
                  child: Text(
                    "Level: ${data[index].level.toString()}",
                    style: TextStyle(
                      color: primaryBlue,
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
