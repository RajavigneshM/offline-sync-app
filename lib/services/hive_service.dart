import 'package:hive_flutter/hive_flutter.dart';

class HiveService {
  static late Box notesBox;
  static late Box queueBox;

  static Future<void> init() async {
    await Hive.initFlutter();

    notesBox = await Hive.openBox('notesBox');
    queueBox = await Hive.openBox('queueBox');
  }
}