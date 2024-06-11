import 'package:flutter/material.dart';
import 'package:football/app/global_navigator/global_navigator.dart';
import 'package:football/features/main/main_screen.dart';
import 'package:football/features/onboarding/onboarding_screen.dart';
import 'package:football/helpers/hive_helper.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        if (HiveHelper.isFirstTimeOpen) {
          GlobalNavigator.pushAndRemoveUntil(context,
              page: const OnboardingScreen());
        } else {
          GlobalNavigator.pushAndRemoveUntil(context, page: const MainScreen());
        }
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.black,
    );
  }
}
