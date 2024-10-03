import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:free_workout/navigator/app_navigator.dart';
import 'package:free_workout/services/hive_service.dart';

class TimerTrain extends StatefulWidget {
   TimerTrain({super.key,required this.saveData});
  Function(String) saveData;
  @override
  State<TimerTrain> createState() => _TimerTrainState();
}

class _TimerTrainState extends State<TimerTrain> {
  int _seconds = 0;
  Timer? _timer;
  bool train = false;

  final hive = HiveService();
  void _startTimer() {
    if (train == false) {
      train = true;
      setState(() {});
      _timer = Timer.periodic(Duration(seconds: 1), (timer) {
        setState(() {
          _seconds++;
        });
      });
    }
  }

  void _stopTimer() async {
    if (train == true) {
      _timer?.cancel();
      train = false;
      await widget.saveData(_formattedTime);
      AppNavigator.toHomeScreen(context);
    }
  }

  void showStopTrain() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          "Закончить тренировку?",
          style: TextStyle(
            fontSize: 22.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
              child: Row(
                children: [
                  Icon(
                    Icons.close,
                    color: Colors.white,
                    size: 22.r,
                  ),
                  Text(
                    "Отмена",
                    style: TextStyle(fontSize: 20.sp, color: Colors.white),
                  ),
                ],
              )),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
              ),
              onPressed: () {
                _stopTimer();
              },
              child: Row(
                children: [
                  Icon(
                    Icons.save,
                    color: Colors.white,
                    size: 22.r,
                  ),
                  Text(
                    "Закончить",
                    style: TextStyle(
                      fontSize: 20.sp,
                      color: Colors.white,
                    ),
                  ),
                ],
              ))
        ],
      ),
    );
  }

  // void _resetTimer() {
  //   _stopTimer();
  //   setState(() {
  //     _seconds = 0;
  //   });
  // }

  String get _formattedTime {
    final minutes = (_seconds ~/ 60).toString().padLeft(2, '0');
    final seconds = (_seconds % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  @override
  void dispose() {
    _stopTimer(); // Остановите таймер при уничтожении виджета
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            _formattedTime,
            style: TextStyle(
                fontSize: 48.sp,
                fontWeight: FontWeight.bold,
                color: Colors.white),
          ),
          SizedBox(height: 20.h),
          GestureDetector(
            onTap: () {
              train == false ? _startTimer() : showStopTrain();
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Text(
                train == false ? "Начать тренировку" : "Закончить тренировку",
                style: TextStyle(
                  fontSize: 22.sp,
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
