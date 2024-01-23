import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:screen_brightness/screen_brightness.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

class UiUtils {
  static void showSnackbar(BuildContext context, {required String message}) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static String convertDateTimeToReadableFormat(String inputDate) {
    // Parse the original date string
    DateTime dateTime = DateTime.parse(inputDate).toUtc();

    // Convert to Indian Standard Time (UTC +5:30)
    DateTime istDateTime = dateTime.add(const Duration(hours: 5, minutes: 30));

    // Format the DateTime object
    DateFormat formatter = DateFormat('d MMM, yyyy \'at\' h:mm a');
    String formattedDate = formatter.format(istDateTime);

    return formattedDate;
  }

  static Future<void> setMaxBrightnessAndWakeLock() async {
    try {
      await WakelockPlus.enable();
      await ScreenBrightness().setScreenBrightness(1.0);
    } catch (e) {
      debugPrint('Failed to set max brightness: $e');
    }
  }
}
