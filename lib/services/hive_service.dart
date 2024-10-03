import 'package:hive_flutter/hive_flutter.dart';

class HiveService {
  final legBox = Hive.box("Leg");
  final armBox = Hive.box("Arms");
  final spineBox = Hive.box("Spine");
  final breastBox = Hive.box("Breast");
  final patternsBox = Hive.box("Patterns");
  final historyBox = Hive.box("Hystori");



  Future<void> writeData(Box box, Map<String, String> data) async {
    await box.add(data);
  }

  Future<void> writeHistoryData(List<Map<String,dynamic>> data)async{
    await historyBox.add(data);
  }

  Future<void> writePatternData(List<Map<String,String>> data,)async{
    await patternsBox.add(data);
  }

  Future<List<List<Map<String, dynamic>>>> readDataHystori() async {
    return List<List<Map<String, dynamic>>>.from(historyBox.values.map((dynamic value) {
      if (value is List) {
        // Проверяем, является ли value списком
        return List<Map<String, dynamic>>.from(value.map((dynamic item) {
          if (item is Map) {
            // Проверяем, является ли элемент картой
            return Map<String, dynamic>.from(item);
          } else {
            throw Exception('Неверный тип данных в элементе: $item');
          }
        }));
      } else {
        throw Exception('Неверный тип данных: $value');
      }
    }));
  }

  Future<List<List<Map<String, String>>>> readDataPatterns(Box box) async {
    return List<List<Map<String, String>>>.from(box.values.map((dynamic value) {
      if (value is List) {
        // Проверяем, является ли value списком
        return List<Map<String, String>>.from(value.map((dynamic item) {
          if (item is Map) {
            // Проверяем, является ли элемент картой
            return Map<String, String>.from(item);
          } else {
            throw Exception('Неверный тип данных в элементе: $item');
          }
        }));
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
