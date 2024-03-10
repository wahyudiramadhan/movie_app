import 'dart:convert';
import 'package:http/http.dart' as http;

import '../data/const.dart';

Future<Map<String, dynamic>> fetchDataFromAPI(
    String endpoint, String token) async {
  try {
    final apiUrl = Uri.parse(baseUrl + endpoint);
    final response = await http.get(
      apiUrl,
      headers: {
        'Authorization': 'Bearer $token',
        'accept': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load data from API: ${response.statusCode}');
    }
  } catch (e) {
    throw Exception('Error fetching data: $e');
  }
}
