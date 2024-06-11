// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:football/core/constants/app_icons.dart';

import 'package:football/core/constants/app_puzzles.dart';
import 'package:football/core/extensions/padding_extension_on_widget.dart';
import 'package:reorderable_grid_view/reorderable_grid_view.dart';

class DetailPuzzleScreen extends StatefulWidget {
  const DetailPuzzleScreen({
    super.key,
    required this.puzzle,
  });
  final PuzzleData puzzle;
  @override
  State<DetailPuzzleScreen> createState() => _DetailPuzzleScreenState();
}

class _DetailPuzzleScreenState extends State<DetailPuzzleScreen> {
  int totalSeconds = 0;
  Timer? timer;

  late final List<String> initialData;
  List<String> data = [];
  @override
  void initState() {
    initialData = List<String>.from(widget.puzzle.parts);
    data = List<String>.from(widget.puzzle.parts)..shuffle();

    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        timer = Timer.periodic(
          const Duration(seconds: 1),
          (timer) {
            totalSeconds++;
            setState(() {});
          },
        );
      },
    );
    super.initState();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  void checkStatus() {
    for (int i = 0; i < data.length; i++) {
      if(data[i] != initialData[i]){
        return;
      }
      if(i == data.length - 1 ){
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("You Win!")));
        Future.delayed(const Duration(seconds: 1),(){
          Navigator.pop(context);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              widget.puzzle.image,
              fit: BoxFit.cover,
            ),
          ),
          Positioned.fill(
            child: Container(
              color: Colors.black.withOpacity(.8),
            ),
          ),
          Positioned.fill(
            child: SizedBox(
              width: double.maxFinite,
              child: SafeArea(
                child: Column(
                  children: [
                    SizedBox(
                      width: double.maxFinite,
                      height: 44,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Container(
                              width: 28,
                              color: Colors.transparent,
                              height: 44,
                              alignment: Alignment.center,
                              child: Image.asset(
                                AppIcons.chevronLeft,
                                height: 22,
                              ),
                            ),
                          ),
                          Builder(
                            builder: (context) {
                              int minutes =
                                  totalSeconds == 0 ? 0 : totalSeconds ~/ 60;
                              int seconds = totalSeconds % 60;
                              return Text(
                                "$minutes:${seconds.toString().padLeft(2, "0")}",
                                style: const TextStyle(
                                  fontSize: 23,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              );
                            },
                          ),
                          Image.asset(
                            AppIcons.eye,
                            width: 28,
                          )
                        ],
                      ).paddingSymetric(horizontal: 10),
                    ),
                    const Spacer(),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: const Color(0xff861010),
                          width: 2,
                        ),
                      ),
                      child: ReorderableGridView.count(
                        crossAxisSpacing: 2,
                        mainAxisSpacing: 2,
                        crossAxisCount: 4,
                        shrinkWrap: true,
                        primary: false,
                        physics: const NeverScrollableScrollPhysics(),
                        onReorder: (oldIndex, newIndex) {
                          setState(() {
                            final element = data.removeAt(oldIndex);
                            data.insert(newIndex, element);
                          });
                          checkStatus();
                        },
                        footer: const [],
                        children: data
                            .map(
                              (e) => Image.asset(
                                e,
                                key: ValueKey(e),
                                fit: BoxFit.cover,
                              ),
                            )
                            .toList(),
                      ),
                    ),
                    const Spacer(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
