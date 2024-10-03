import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../models/exercise_model.dart';

class TrainExercieseContainer extends StatefulWidget {
  TrainExercieseContainer({
    super.key,
    required this.exerciese,
    required this.onResultsChanged,
    required this.id,
  });
  final Function(int, Map<String,dynamic>) onResultsChanged; // Изменено
  final int id; // Идентификатор упражнения

  final ExerciseModel exerciese;

  @override
  State<TrainExercieseContainer> createState() =>
      _TrainExercieseContainerState();
}

class _TrainExercieseContainerState extends State<TrainExercieseContainer> {
  int approah = 1;
  int count = 0;
  List<List<int>> listResults = [];
  void addApproah() {
    if (count > 0) {
      listResults.add([approah, count]);
      widget.onResultsChanged(
          widget.id, {"name":widget.exerciese.name, "results":listResults}); // Передача id и результатов
      approah += 1;
      count = 0;
      setState(() {});
    }
  }


  void changeCount(int i) {
    count += i;
    if (count <= 0) {
      count = 0;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5.h, horizontal: 10.w),
      padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 5.w),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 36, 57, 119),
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                child: Text(
                  widget.exerciese.name,
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 5.w),
                margin: EdgeInsets.only(bottom: 10.h),
                decoration: BoxDecoration(
                  border: Border.all(width: 1.r, color: Colors.white),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Text(
                  widget.exerciese.complexity,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          Divider(
            height: 0,
            color: Colors.white,
            thickness: 2.h,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              titleRow(),
              countResults(),
              redactorRow(),
              TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.white,
                ),
                onPressed: () {
                  addApproah();
                },
                child: Text(
                  "Закончить подход",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.sp,
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget redactorRow() {
    return Padding(
      padding: EdgeInsets.only(right: 50.w, left: 100.w),
      child: Row(
        children: [
          Text(
            approah.toString(),
            style: TextStyle(
              fontSize: 16.sp,
              color: Colors.white,
            ),
          ),
          const Spacer(),
          counter(count, changeCount),
        ],
      ),
    );
  }

  Widget titleRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text(
          "Подход",
          style: TextStyle(
            fontSize: 16.sp,
            color: Colors.white,
          ),
        ),
        Text(
          "Количество",
          style: TextStyle(
            fontSize: 16.sp,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget countResults() {
    return Column(
      children: listResults
          .map((e) => Container(
                margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 4.h),
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 1.r,
                    color: Colors.white,
                  ),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      e[0].toString(),
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      e[1].toString(),
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ))
          .toList(),
    );
  }

  Widget counter(
    int value,
    Function(int) fun,
  ) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          onPressed: () {
            fun(-1);
          },
          icon: Icon(
            Icons.arrow_left_sharp,
            color: Colors.white,
            size: 30.r,
          ),
        ),
        Text(
          value.toString(),
          style: TextStyle(
            fontSize: 16.sp,
            color: Colors.white,
          ),
        ),
        IconButton(
          onPressed: () {
            fun(1);
          },
          icon: Icon(
            Icons.arrow_right_sharp,
            color: Colors.white,
            size: 30.r,
          ),
        ),
      ],
    );
  }
}
