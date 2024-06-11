import 'package:flutter/material.dart';
import 'package:football/core/constants/app_icons.dart';
import 'package:football/core/constants/app_images.dart';
import 'package:football/core/extensions/align_ext_on_widget.dart';
import 'package:football/core/extensions/mediaquery_ext_on_context.dart';
import 'package:football/core/extensions/padding_extension_on_widget.dart';

class TicTacToeScreen extends StatefulWidget {
  const TicTacToeScreen({super.key});

  @override
  State<TicTacToeScreen> createState() => _TicTacToeScreenState();
}

class _TicTacToeScreenState extends State<TicTacToeScreen> {
  static const int BOARD_SIZE = 9;
  List<String> _board = [];
  bool _isXTurn = true;
  String _winner = '';

  @override
  void initState() {
    _initializeGame();
    super.initState();
  }

  void _initializeGame() {
    _board = List<String>.filled(BOARD_SIZE, '');
    _isXTurn = true;
    _winner = '';
  }

  void _handleTap(int index) {
    if (_board[index] != '' || _winner != '') {
      return;
    }

    setState(() {
      _board[index] = _isXTurn ? 'X' : 'O';
      _isXTurn = !_isXTurn;
      _winner = _checkWinner();
    });
  }

  String _checkWinner() {
    const List<List<int>> winningCombinations = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [2, 4, 6],
    ];

    for (var combination in winningCombinations) {
      String a = _board[combination[0]];
      String b = _board[combination[1]];
      String c = _board[combination[2]];

      if (a == b && b == c && a != '') {
        return a;
      }
    }

    if (_board.every((element) => element != '')) {
      return 'Draw';
    }

    return '';
  }

  Widget _buildWinnerRedLine() {
    final blockSize = (context.screenW - 40) / 3;
    const List<List<int>> winningCombinations1 = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
    ];

    for (int i = 0; i < winningCombinations1.length; i++) {
      final combination = winningCombinations1[i];
      String a = _board[combination[0]];
      String b = _board[combination[1]];
      String c = _board[combination[2]];

      if (a == b && b == c && a != '') {
        return Container(
          width: double.maxFinite,
          height: 8,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: const Color(0xff861010),
          ),
        ).paddingOnly(top: (blockSize / 2) + i * blockSize + 20).align(Alignment.topCenter);
      }
    }

    const List<List<int>> winningCombinations2 = [
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
    ];

    for (int i = 0; i < winningCombinations2.length; i++) {
      final combination = winningCombinations2[i];
      String a = _board[combination[0]];
      String b = _board[combination[1]];
      String c = _board[combination[2]];

      if (a == b && b == c && a != '') {
        return Container(
          width: 8,
          height: double.maxFinite,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: const Color(0xff861010),
          ),
        ).paddingOnly(left: (blockSize / 2) + i * blockSize + 20).align(Alignment.centerLeft);
      }
    }
    const List<List<int>> winningCombinations3 = [
      [0, 4, 8],
      [2, 4, 6],
    ];

    for (int i = 0; i < winningCombinations3.length; i++) {
      final combination = winningCombinations3[i];
      String a = _board[combination[0]];
      String b = _board[combination[1]];
      String c = _board[combination[2]];

      if (a == b && b == c && a != '') {
        return Transform.rotate(
          angle: (i == 0 ? 315 : 45) * (3.1415927 / 180),
          child: Container(
            width: 8,
            height: double.maxFinite,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: const Color(0xff861010),
            ),
          ),
        ).align();
      }
    }

    return const SizedBox();
  }

  Widget _buildBoard() {
    return Stack(
      children: [
        Positioned.fill(
          child: Row(
            children: [
              const Spacer(),
              Container(
                width: 8,
                height: double.maxFinite,
                decoration: BoxDecoration(
                  color: const Color(0xffD9D9D9),
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              const Spacer(),
              Container(
                width: 8,
                height: double.maxFinite,
                decoration: BoxDecoration(
                  color: const Color(0xffD9D9D9),
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              const Spacer(),
            ],
          ).paddingAll(20),
        ),
        Positioned.fill(
          child: Column(
            children: [
              const Spacer(),
              Container(
                width: double.maxFinite,
                height: 8,
                decoration: BoxDecoration(
                  color: const Color(0xffD9D9D9),
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              const Spacer(),
              Container(
                width: double.maxFinite,
                height: 8,
                decoration: BoxDecoration(
                  color: const Color(0xffD9D9D9),
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              const Spacer(),
            ],
          ).paddingAll(20),
        ),
        GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 1,
          ),
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            final isX = _board[index] == "X";
            return GestureDetector(
              onTap: () => _handleTap(index),
              child: Container(
                color: Colors.transparent,
                child: _board[index].isEmpty
                    ? null
                    : Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Image.asset(
                          isX ? AppIcons.x : AppIcons.o,
                          fit: BoxFit.fitWidth,
                        ),
                      ),
              ),
            );
          },
          itemCount: BOARD_SIZE,
          shrinkWrap: true,
          primary: false,
        ).paddingAll(20),
        Positioned.fill(child: _buildWinnerRedLine()),
      ],
    );
  }

  Widget _buildWinLayer() {
    return Positioned.fill(
      child: Container(
        color: const Color(0xffD9D9D9).withOpacity(.3),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const FittedBox(
              child: Text(
                "You Win!",
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: Color(0xffCB1A1A),
                    fontSize: 80,
                    height: 1),
              ),
            ).paddingSymetric(horizontal: 20).paddingOnly(bottom: 20),
            GestureDetector(
              onTap: () {
                _initializeGame();
                setState(() {});
              },
              child: const Text(
                "play again",
                style: TextStyle(
                  fontSize: 42,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                  height: 1,
                ),
              ),
            ).paddingOnly(bottom: 20),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.maxFinite,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppImages.ticTacToeBg),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            Positioned.fill(
              child: Column(
                children: <Widget>[
                  const Text(
                    'Tic tac toe',
                    style: TextStyle(fontSize: 19, color: Colors.white),
                  ).paddingOnly(top: 15, bottom: 10),
                  const Text(
                    'Two-player game',
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                  const SizedBox(height: 20),
                  const Spacer(),
                  _buildBoard(),
                  const Spacer(
                    flex: 4,
                  ),
                ],
              ),
            ),
            if (_winner.isNotEmpty) _buildWinLayer(),
          ],
        ),
      ),
    );
  }
}
