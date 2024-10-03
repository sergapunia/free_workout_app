import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:free_workout/models/exercise_model.dart';
import 'package:free_workout/services/hive_service.dart';
import 'package:free_workout/widgets/pattern_container.dart';

import '../navigator/app_navigator.dart';

class ButtomDialogStartTrain extends StatefulWidget {
  ButtomDialogStartTrain({super.key});
  @override
  State<ButtomDialogStartTrain> createState() => _ButtomDialogStartTrainState();
}

class _ButtomDialogStartTrainState extends State<ButtomDialogStartTrain> {
  void startTrain(BuildContext context,List<ExerciseModel> pattern) {

    AppNavigator.toStartTrainScreen(context,pattern);
  }

  final hive = HiveService();

  List<List<ExerciseModel>> listData = [];

  void read() async {
    List<List<Map<String, String>>> list =
        await hive.readDataPatterns(hive.patternsBox);
    listData = list
        .map((e) => e.map((v) => ExerciseModel.fromJson(v)).toList())
        .toList();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    read();
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      height: 600.h,
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 49, 49, 49),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.r),
          topRight: Radius.circular(30.r),
        ),
      ),
      child: Column(
        children: [
          Text(
            "Выберите шаблон для тренировки",
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          Divider(
            height: 0,
            thickness: 2.h,
            color: Colors.white,
          ),
          Padding(
            padding: EdgeInsets.only(top: 10.h),
            child: patterns(),
          ),
        ],
      ),
    );
  }

  Widget patterns() {
    return SizedBox(
      height: 550.h,
      child: ListView(
        children: listData.map((e) => GestureDetector(
          onTap: (){startTrain(context,e);},
          child: PatternContainer(pattern: e))).toList(),
      ),
    );
  }
}
