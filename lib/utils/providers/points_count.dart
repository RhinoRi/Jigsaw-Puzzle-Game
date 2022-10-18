import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jigsaw_puzzle_game_app/utils/providers/points_provider.dart';
import 'package:provider/provider.dart';

import '../constants/color_constants.dart';

class PointsCount extends StatelessWidget {
  const PointsCount({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      context.watch<GamePoints>().points.toString(),
      key: const Key('counterState'),
      style: GoogleFonts.varelaRound(
        textStyle: TextStyle(
          color: backgroundWhite,
          fontWeight: FontWeight.bold,
          fontSize: 22.0,
        ),
      ),
    );
  }
}
