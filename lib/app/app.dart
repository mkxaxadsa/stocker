import 'package:flutter/material.dart';
import 'package:football/features/splash/splash_screen.dart';

class FootballApp extends StatefulWidget {
  const FootballApp({super.key});

  @override
  State<FootballApp> createState() => _FootballAppState();
}

class _FootballAppState extends State<FootballApp> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}