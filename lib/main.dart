import 'package:flutter/material.dart';
import 'package:football/app/app.dart';
import 'package:football/helpers/hive_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveHelper.init();
  runApp(const FootballApp());
}
