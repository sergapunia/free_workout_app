import 'package:hive_flutter/hive_flutter.dart';

class HiveService {
  final legBox = Hive.box("Leg");
  final armBox = Hive.box("Arms");
  final spineBox = Hive.box("Spine");
  final breastBox = Hive.box("Breast");
  final patternsBox = Hive.box("Patterns");


  Future<void> writeData(Box box, Map<String, String> data) async {
    await box.add(data);
  }

  Future<List<List<Map<String, String>>>> readDataPatterns(Box box) async {
    return List<List<Map<String, String>>>.from(box.values.map((dynamic value) {
      if (value is List<Map<dynamic, dynamic>>) {
        return List<Map<String, String>>.from(value);
      } else {
        throw Exception('Неверный тип данных: $value');
      }
    }));
  }

  Future<List<Map<String, String>>> readData(Box box) async {
    return List<Map<String, String>>.from(
  box.values.map((dynamic value) {
    if (value is Map<dynamic, dynamic>) {
      return Map<String, String>.from(value);
    } else {
      throw Exception('Неверный тип данных: $value');
    }
  }));
  }

  Future<void> deleteData(Box box, int index) async {
    box.deleteAt(index);
    box.compact();
  }
}
