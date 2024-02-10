import 'dart:convert';
import 'dart:async'; // Import for Future.delayed
import 'package:assetcomply_notifier/constants/strings.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

// Define the callback type.
typedef ProgressCallback = void Function(int currentPage, int totalPages);

class ApiService {
  Future<List<Map<String, dynamic>>> fetchSerialNumbers({ProgressCallback? onProgress}) async {
    List<Map<String, dynamic>> allData = [];
    var currentPage = 1;
    var totalPages = 1; // Initially unknown

    String apiUrl = AppStrings.API_URL;

    while (currentPage <= totalPages) {
      try {
        // Call the callback with current page and total pages.
        if (onProgress != null) onProgress(currentPage, totalPages);

        if (kDebugMode) {
          print("Current Page = $currentPage, Total Pages = $totalPages");
        }

        String queryParameter = '?page=$currentPage';
        String fullUrl = apiUrl + queryParameter;
        var url = Uri.parse(fullUrl);
        var response = await http.get(url);
        var data = json.decode(response.body);

        if (data['status'] == 1) {
          totalPages = data['data']['last_page'];
          List<dynamic> pageData = data['data']['data'];
          allData.addAll(pageData.map((e) => {'serial_no': e['serial_no'], 'epc': e['epc']}));
        }

        currentPage++;
      } catch (e) {
        // If an exception occurs, wait for 1-2 seconds before retrying
        await Future.delayed(const Duration(seconds: 2));
        print("Exception Occoured: $e.\n Restarting in 2 Seconds...");
      }
    }

    return allData;
  }
}
