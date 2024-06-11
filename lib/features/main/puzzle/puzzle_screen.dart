import 'package:flutter/material.dart';
import 'package:football/app/global_navigator/global_navigator.dart';
import 'package:football/core/constants/app_puzzles.dart';
import 'package:football/core/extensions/align_ext_on_widget.dart';
import 'package:football/core/extensions/expanded_ext_on_widget.dart';
import 'package:football/core/extensions/padding_extension_on_widget.dart';
import 'package:football/features/main/puzzle/detail_puzzle/detail_puzzle_screen.dart';

class PuzzleScreen extends StatefulWidget {
  const PuzzleScreen({super.key});

  @override
  State<PuzzleScreen> createState() => _PuzzleScreenState();
}

class _PuzzleScreenState extends State<PuzzleScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.maxFinite,
          height: 44,
          child: const Text(
            "Puzzle Game",
            style: TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ).align(),
        ).paddingOnly(bottom: 16),
        GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
          ),
          itemCount: AppPuzzles.puzzles.length,
          itemBuilder: (context, index) {
            final puzzle = AppPuzzles.puzzles[index];
            return GestureDetector(
              onTap: () {
                GlobalNavigator.push(context, page: DetailPuzzleScreen(puzzle: puzzle));
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  puzzle.image,
                  fit: BoxFit.cover,
                ),
              ),
            );
          },
        ).expanded(),
      ],
    ).paddingSymetric(horizontal: 16);
  }
}
