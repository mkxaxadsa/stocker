import 'dart:math';

import 'package:flutter/material.dart';
import 'package:football/app/global_navigator/global_navigator.dart';
import 'package:football/core/constants/app_images.dart';
import 'package:football/core/extensions/expanded_ext_on_widget.dart';
import 'package:football/core/extensions/mediaquery_ext_on_context.dart';
import 'package:football/core/extensions/padding_extension_on_widget.dart';
import 'package:football/features/main/main_screen.dart';
import 'package:football/helpers/hive_helper.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final data = [
    {
      "title": "Welcome to the world of ",
      "special_word": "Football",
      "subtitle":
          "Here you can find all the information about news, games, scores.",
    },
    {
      "title": "Collect ",
      "special_word": "Puzzles",
      "subtitle":
          "Solve puzzles with ease thanks to smooth controls and user-friendly design",
    },
    {
      "image": AppImages.onboarding4,
      "title": "Play with a ",
      "special_word": "Friend",
      "subtitle": "Play tic tac toe and hang out",
    },
  ];

  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    final itemData = data[currentPage];
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              AppImages.onboardingBg,
              fit: BoxFit.cover,
            ),
          ),
          Positioned.fill(
            child: SafeArea(
              child: SizedBox(
                width: double.maxFinite,
                child: Column(
                  children: [
                    if (itemData["image"] == null)
                      const Spacer()
                    else
                      Image.asset(
                        itemData["image"]!,
                      ).paddingOnly(top: 40, left: 40, right: 55).expanded(),
                    Text.rich(
                      TextSpan(
                        text: itemData["title"],
                        style: const TextStyle(
                          fontSize: 33,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                        children: [
                          TextSpan(
                            text: itemData["special_word"],
                            style: const TextStyle(
                              color: Color(0xffCB1A1A),
                            ),
                          ),
                        ],
                      ),
                      textAlign: TextAlign.center,
                    ).paddingSymetric(horizontal: 16).paddingOnly(bottom: 20),
                    Text(
                      itemData["subtitle"]!,
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xffEBEBF5).withOpacity(.6),
                      ),
                      textAlign: TextAlign.center,
                    ).paddingOnly(bottom: 40).paddingSymetric(horizontal: 16),
                    GestureDetector(
                      onTap: () {
                        if (currentPage == data.length - 1) {
                          HiveHelper.setIsNotFirstTimeOpen();
                          GlobalNavigator.pushAndRemoveUntil(context,
                              page: const MainScreen());
                          return;
                        }
                        setState(() {
                          currentPage = min(currentPage + 1, data.length - 1);
                        });
                      },
                      child: Container(
                        width: double.maxFinite,
                        height: 56,
                        decoration: BoxDecoration(
                          color: const Color(0xff861010),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        alignment: Alignment.center,
                        child: const Text(
                          "Continue",
                          style: TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ).paddingOnly(bottom: 20).paddingSymetric(horizontal: 16),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: context.padding.top + 12,
            right: 16,
            child: GestureDetector(
              onTap: () {
                HiveHelper.setIsNotFirstTimeOpen();
                GlobalNavigator.pushAndRemoveUntil(context,
                    page: const MainScreen());
              },
              child: const Text(
                "Skip",
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
