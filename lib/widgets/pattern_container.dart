import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:free_workout/models/exercise_model.dart';
import 'package:free_workout/widgets/info_exerciese_for_pattern.dart';

class PatternContainer extends StatelessWidget {
  PatternContainer({super.key, required this.pattern});
  List<ExerciseModel> pattern;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
      margin: EdgeInsets.only(left: 10.w, right: 10.w, bottom: 10.h),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 204, 204, 204),
        border: Border.all(
          width: 2.r,
          color: const Color.fromARGB(255, 255, 197, 110),
        ),
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Column(
          children:
              pattern.map((e) => InfoExercieseForPattern(value: e)).toList()),
    );
  }
}
