import 'package:flutter/material.dart';
import 'package:jigsaw_puzzle_game_app/utils/constants/color_constants.dart';
import 'package:jigsaw_puzzle_game_app/utils/providers/points_provider.dart';
import 'package:jigsaw_puzzle_game_app/utils/screens/home/home_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => GamePoints()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Jigsaw Puzzle Game',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          appBarTheme: AppBarTheme(
            backgroundColor: primaryOrange,
          ),
          scaffoldBackgroundColor: backgroundWhite),
      home: const HomeScreen(),
    );
  }
}
