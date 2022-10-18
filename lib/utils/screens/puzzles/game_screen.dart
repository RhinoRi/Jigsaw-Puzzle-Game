import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jigsaw_puzzle_game_app/utils/constants/color_constants.dart';
import 'package:jigsaw_puzzle_game_app/utils/jigsaw_puzzle_logic.dart';
import 'package:jigsaw_puzzle_game_app/utils/models/puzzle_data.dart';
import 'package:jigsaw_puzzle_game_app/utils/providers/points_provider.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../../providers/points_count.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({Key? key, required this.data}) : super(key: key);
  final PuzzleData data;

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  GlobalKey<JigsawWidgetState> puzzleKey = GlobalKey<JigsawWidgetState>();
  final PageController _pageController = PageController();
  bool isFinished = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Text(
              'Jigsaw Puzzle Game',
              style: GoogleFonts.varelaRound(
                textStyle: const TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5,
                ),
              ),
            ),
            elevation: 0,
            actions: [
              Padding(
                padding: const EdgeInsets.only(
                  right: 8.0,
                  top: 5.0,
                  bottom: 5.0,
                ),
                child: currentLevelPoints(const PointsCount(), backgroundWhite),
              ),
            ],
          ),
          body: PageView(
            controller: _pageController,
            physics: const NeverScrollableScrollPhysics(),
            pageSnapping: true,
            children: [
              SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(top: 5.0),
                        child: CircleAvatar(
                          backgroundColor: primaryBlue,
                          foregroundColor: backgroundWhite,
                          radius: 35.0,
                          child: Text(
                            widget.data.level.toString(),
                            style: GoogleFonts.varelaRound(
                              textStyle: const TextStyle(
                                fontSize: 35.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    !isFinished
                        ? headerText("SOLVE THE PUZZLE")
                        : headerText("WELL DONE!!!"),

                    Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: JigsawPuzzleLogic(
                        gridSize: widget.data.difficulty,
                        image: NetworkImage(widget.data.imageUrl),
                        puzzleKey: puzzleKey,
                        onFinished: () {
                          Future.delayed(const Duration(seconds: 2), () {
                            setState(() {
                              isFinished = true;
                            });
                            context
                                .read<GamePoints>()
                                .pointsAdd(widget.data.points);
                          });
                        },
                      ),
                    ),

                    // if puzzle is completed continue button will be displayed else shuffle button.
                    !isFinished
                        ? shuffleButton()
                        : Column(
                            children: [
                              SizedBox(
                                height: 45,
                                width: 80,
                                child: currentLevelPoints(
                                    Text(
                                      widget.data.points.toString(),
                                      style: GoogleFonts.varelaRound(
                                        textStyle: TextStyle(
                                          color: primaryBlue,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 22.0,
                                        ),
                                      ),
                                    ),
                                    primaryBlue),
                              ),
                              const SizedBox(
                                height: 8.0,
                              ),
                              continueButton(),
                            ],
                          ),
                  ],
                ),
              )
            ],
          ),
        ),
        isFinished
            ? Positioned(
                bottom: 690,
                left: 280,
                top: 0,
                right: 0,
                child: Lottie.network(
                  "https://assets10.lottiefiles.com/packages/lf20_7z1gt2bj/Coin2/Coin.json",
                  animate: true,
                  repeat: false,
                ),
              )
            : Container(),
      ],
    );
  }

  Text headerText(String greet) => Text(
        greet,
        style: GoogleFonts.varelaRound(
          textStyle: TextStyle(
            color: primaryBlue,
            fontSize: 25.0,
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
          ),
        ),
      );

  ElevatedButton shuffleButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: secondaryBlue,
        elevation: 10,
        padding: const EdgeInsets.all(18.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      onPressed: () async {
        await puzzleKey.currentState!.generate();
      },
      child: Icon(
        Icons.shuffle,
        color: backgroundWhite,
        size: 32.0,
      ),
    );
  }

  ElevatedButton continueButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: secondaryBlue,
        elevation: 10,
        padding: const EdgeInsets.all(18.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
      ),
      onPressed: () {
        setState(() {
          isFinished = false;
        });
        Navigator.pop(context);
      },
      child: Text(
        "CONTINUE",
        style: GoogleFonts.varelaRound(
          textStyle: TextStyle(
            color: backgroundWhite,
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Container currentLevelPoints(Widget totalPoints, Color color) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: color,
          width: 3.0,
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(15.0),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.monetization_on_rounded,
              size: 25.0,
              color: Color(0xFFFFD700),
            ),
            const SizedBox(
              width: 5.0,
            ),
            totalPoints,
          ],
        ),
      ),
    );
  }
}
