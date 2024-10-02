import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:free_workout/models/exercise_model.dart';
import 'package:free_workout/services/hive_service.dart';

class ExercieseContainer extends StatelessWidget {
   ExercieseContainer({
    super.key,
    required this.exerciese,
    required this.index,
    required this.deleteFunc,
  });
  final int index;
  final ExerciseModel exerciese;
  Function deleteFunc;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 255, 191, 95),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Row(
              children: [
                Expanded(
                  flex: 10,
                  child: Center(
                    child: Text(
                      exerciese.name,
                      style: TextStyle(
                        fontSize: 22.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: IconButton(
                    onPressed: (){deleteFunc();},
                    icon: Icon(
                      Icons.delete_forever_outlined,
                      color: Colors.red,
                      size: 30.r,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Divider(
            height: 0,
            color: Colors.black,
            indent: 20.w,
            endIndent: 20.w,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 5.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                targetGroup(),
                complexity(),
              ],
            ),
          ),
          Divider(
            height: 0,
            color: Colors.black,
            indent: 20.w,
            endIndent: 20.w,
          ),
          description(),
        ],
      ),
    );
  }

  Widget description() {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 20.w),
      padding: EdgeInsets.symmetric(vertical: 10.h),
      child: Text(
        exerciese.description,
        style: TextStyle(
          fontSize: 15.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget targetGroup() {
    return Container(
      width: 200.w,
      padding: EdgeInsets.symmetric(horizontal: 5.w),
      decoration: BoxDecoration(
          border: Border(
        left: BorderSide(width: 1.5.r),
        right: BorderSide(width: 1.5.r),
      )),
      child: Text(
        exerciese.targetGroup,
        style: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget complexity() {
    Color col = Colors.blue;
    Color colText = Colors.white;
    if (exerciese.complexity == "средне") {
      col = Colors.yellow;
      colText = Colors.black;
    }
    if (exerciese.complexity == "тяжело") {
      col = Colors.red;
      colText = Colors.white;
    }
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5.w),
      decoration: BoxDecoration(
        color: col,
        borderRadius: BorderRadius.circular(5.r),
      ),
      child: Text(
        exerciese.complexity,
        style: TextStyle(
          fontSize: 15.sp,
          fontWeight: FontWeight.w700,
          color: colText,
        ),
      ),
    );
  }
}
