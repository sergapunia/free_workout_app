import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:free_workout/models/exercise_model.dart';

class InfoExercieseForPattern extends StatelessWidget {
  InfoExercieseForPattern({super.key, required this.value});
  final ExerciseModel value;
  Color col = Colors.black;
  Color colText = Colors.white;

  @override
  Widget build(BuildContext context) {
    if (value.complexity == "легко") {
      col = Colors.blue;
      colText = Colors.white;
    }
    if (value.complexity == "средне") {
      col = Colors.yellow;
      colText = Colors.black;
    }
    if (value.complexity == "тяжело") {
      col = Colors.red;
      colText = Colors.white;
    }
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
      margin: EdgeInsets.symmetric(vertical: 3.h),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.orange,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: Text(
              value.name,
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 5.w),
            decoration: BoxDecoration(
              color: col,
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Text(
              value.complexity,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: colText,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
