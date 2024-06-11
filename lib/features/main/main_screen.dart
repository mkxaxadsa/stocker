import 'package:flutter/material.dart';
import 'package:football/core/extensions/expanded_ext_on_widget.dart';
import 'package:football/features/main/components/bottom_bar.dart';
import 'package:football/features/main/matches/matches_screen.dart';
import 'package:football/features/main/news/news_screen.dart';
import 'package:football/features/main/puzzle/puzzle_screen.dart';
import 'package:football/features/main/settings/settings_screen.dart';
import 'package:football/features/main/tic_tac_toe/tic_tac_toe_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentPage = 0;
  final pages = [
    const NewsScreen(),
    const TicTacToeScreen(),
    const PuzzleScreen(),
    const MatchesScreen(),
    const SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SafeArea(
          child: Column(
            children: [
              pages[currentPage].expanded(),
              BottomBar(
                currentPage: currentPage,
                onPageChanged: (p0) {
                  setState(() {
                    currentPage = p0;
                  });
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
