import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

Future<void> simpanDataKeJSON({Map? data, String? fileName}) async {
  final directory = await getApplicationDocumentsDirectory();
  final file = File('${directory.path}/$fileName');
  await file.writeAsString(jsonEncode(data));
}

// Fungsi untuk memanggil data dari file JSON
Future panggilDataDariJSON({String? fileName}) async {
  try {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/$fileName');
    final jsonData = await file.readAsString();
    return jsonDecode(jsonData);
  } catch (e) {
    print('Error saat membaca file JSON: $e');
    return null;
  }
}
