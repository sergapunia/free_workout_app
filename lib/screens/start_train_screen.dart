import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:free_workout/models/exercise_model.dart';
import 'package:free_workout/services/hive_service.dart';
import 'package:free_workout/widgets/timer_train.dart';
import '../constant/base_scaffold.dart';
import '../widgets/train_exerciese_container.dart';

class StartTrainScreen extends StatelessWidget {
  StartTrainScreen({super.key, required this.pattern});
  List<ExerciseModel> pattern;
  bool scope = false;
  final hive = HiveService();

  //[[[1, 3]], [[1, 3]], [], [], [], [[1, 4], [2, 4], [3, 4]]]
  Future<void> saveData(String trainTime) async {
    DateTime time = DateTime.now();
    List<Map<String, dynamic>> data = [
      {
        "date": "${time.day}.${time.month}.${time.year}",
      },
      {
        "trainingTime": trainTime,
      },
      {
        "time": "${time.hour}:${time.minute}",
      },
      ...results,
    ];
    await hive.writeHistoryData(data);
    log("сохранил тренировку: $data");
  }

  List<Map<String, dynamic>> results = []; // Для хранения результатов

  void updateResults(int id, Map<String, dynamic> newResults) {
    results[id] = newResults; // Обновляем результаты для конкретного id
    log("${results}");
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      leading: false,
      title: "Тренировка",
      child: PopScope(
        canPop: scope,
        child: PopScope(
          canPop: scope,
          child: Column(
            children: [
              TimerTrain(
                saveData: saveData,
              ),
              Expanded(
                  child: SingleChildScrollView(
                child: Column(
                  children: pattern.map((e) {
                    int index = pattern.indexOf(e);
                    if (results.length < pattern.length) {
                      results.add({"name": pattern[index].name, "results": []});
                    }
                    return TrainExercieseContainer(
                        exerciese: pattern[index],
                        onResultsChanged: updateResults,
                        id: index);
                  }).toList(),
                ),
              )),
            ],
          ),
        ),
      ),
    );
  }
}
