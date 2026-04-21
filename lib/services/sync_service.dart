import 'dart:developer';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:uuid/uuid.dart';
import '../models/sync_item.dart';
import 'hive_service.dart';
import 'firebase_service.dart';

class SyncService {
  final FirebaseService _firebase = FirebaseService();

  Future<bool> isOnline() async {
    var result = await Connectivity().checkConnectivity();
    return result != ConnectivityResult.none;
  }

  Future<void> processQueue() async {
    if (!await isOnline()) return;

    final box = HiveService.queueBox;

    for (var key in box.keys) {
      final item = SyncItem.fromJson(Map.from(box.get(key)));

      try {
        await _firebase.addOrUpdateNote(item.payload);

        await box.delete(key);

        log("✅ SYNC SUCCESS: ${item.id}");
      } catch (e) {
        if (item.retryCount < 1) {
          item.retryCount++;

          await box.put(key, item.toJson());

          await Future.delayed(const Duration(seconds: 2));

          log("🔁 RETRYING: ${item.id}");
        } else {
          log("❌ SYNC FAILED: ${item.id}");
        }
      }
    }

    log("📊 QUEUE SIZE: ${box.length}");
  }
}