import 'dart:convert';
import 'dart:io';

class JsonHelper {
  static Future<Map<String, dynamic>?> readJsonFile({
    String filePath = "./hospital.json",
  }) async {
    try {
      String jsonString = await File(filePath).readAsString();
      Map<String, dynamic> jsonData = jsonDecode(jsonString);
      return jsonData;
    } catch (e) {
      print(e);
      return null;
    }
  }

  static Future<bool> writeJsonFile({
    String filePath = "./hospital.json",
    required Map<String, dynamic> data,
  }) async {
    try {
      String jsonString = jsonEncode(data);
      await File(filePath).writeAsString(jsonString);
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  static Future<bool> updateJsonFile({
    String filePath = "./hospital.json",
    required String key,
    required dynamic value,
  }) async {
    try {
      String jsonString = await File(filePath).readAsString();
      Map<String, dynamic> jsonData = jsonDecode(jsonString);

      jsonData[key] = value;

      String updatedJsonString = jsonEncode(jsonData);
      await File(filePath).writeAsString(updatedJsonString);
      print(updatedJsonString);
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
