import 'dart:convert';
import 'package:assetcomply_notifier/constants/strings.dart';
import 'package:http/http.dart' as http;

class ApiService {
  Future<List<Map<String, dynamic>>> fetchSerialNumbers() async {
    List<Map<String, dynamic>> allData = [];
    var currentPage = 1;
    var totalPages = 1; // Initially unknown
    
    String apiUrl = AppStrings.API_URL;
    String queryParameter = '?page=$currentPage';
    String fullUrl = apiUrl + queryParameter;

    //TODO: Change below count

    while (currentPage <= 1) {
      print("Current Page = $currentPage, Total Page = $totalPages");
      var url = Uri.parse(fullUrl);
      var response = await http.get(url);
      var data = json.decode(response.body);

      if (data['status'] == 1) {
        totalPages = data['data']['last_page'];
        List<dynamic> pageData = data['data']['data'];
        allData.addAll(pageData
            .map((e) => {'serial_no': e['serial_no'], 'epc': e['epc']}));
      }

      currentPage++;
    }

    return allData;
  }
}
