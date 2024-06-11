import 'package:hive_flutter/hive_flutter.dart';

class HiveHelper {
  static Future<void> init() async {
    await Hive.initFlutter();
    _box = await Hive.openBox("APP_BOX");
  }

  static late final Box _box;

  static Future<void> setIsNotFirstTimeOpen() async {
    await _box.put("is_first_time_open", false);
  }

  static bool get isFirstTimeOpen {
    return _box.get("is_first_time_open") ?? true;
  }
}
