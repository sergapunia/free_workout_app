import 'package:flutter/material.dart';
import 'package:free_workout/models/exercise_model.dart';
import 'package:free_workout/screens/data_workout.dart';
import 'package:free_workout/screens/exercise_info_screen.dart';
import 'package:free_workout/screens/history_train_screen.dart';
import 'package:free_workout/screens/home_page_screen.dart';
import 'package:free_workout/screens/patterns_train_screen.dart';
import 'package:free_workout/screens/start_train_screen.dart';

class AppNavigator {
  static void toHomeScreen(BuildContext context) {
    Route route = MaterialPageRoute(
      builder: (context) => const HomePageScreen(),
    );
    Navigator.pushReplacement(context, route);
  }

  static void toDataWorkoutScreen(BuildContext context) {
    Route route = MaterialPageRoute(
      builder: (context) =>  DataWorkout(),
    );
    Navigator.push(context, route);
  }

  static void toStartTrainScreen(BuildContext context,List<ExerciseModel> pattern) {
    Route route = MaterialPageRoute(
      builder: (context) =>  StartTrainScreen(pattern:pattern),
    );
    Navigator.push(context, route);
  }

  static void toHistoryScreen(BuildContext context) {
    Route route = MaterialPageRoute(
      builder: (context) => const HistoryTrainScreen(),
    );
    Navigator.push(context, route);
  }

  static void toPatternsTrainScreen(BuildContext context) {
    Route route = MaterialPageRoute(
      builder: (context) => const PatternsTrainScreen(),
    );
    Navigator.push(context, route);
  }

  static void toExerciseInfoScreen(
    BuildContext context,
    String title,
  ) {
    Route route = MaterialPageRoute(
      builder: (context) => ExerciseInfoScreen(
        title: title,
      ),
    );
    Navigator.push(context, route);
  }
}
