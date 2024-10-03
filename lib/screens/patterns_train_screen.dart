import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:free_workout/models/exercise_model.dart';
import 'package:free_workout/services/hive_service.dart';
import 'package:free_workout/widgets/add_pattern_dialog.dart';
import 'package:free_workout/widgets/pattern_container.dart';
import '../constant/base_scaffold.dart';

class PatternsTrainScreen extends StatefulWidget {
  const PatternsTrainScreen({super.key});

  @override
  State<PatternsTrainScreen> createState() => _PatternsTrainScreenState();
}

class _PatternsTrainScreenState extends State<PatternsTrainScreen> {
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

  void addDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AddPatternDialog(
        saveFunc: () {
          read();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      leading: true,
      title: "Шаблоны тренировок",
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 10.h),
            child: ListView.builder(
                itemCount: listData.length,
                itemBuilder: (context, index) {
                  if (index == listData.length - 1) {
                    Padding(
                      padding: EdgeInsets.only(bottom: 60.h),
                      child: pattern(index),
                    );
                  }
                  return pattern(index);
                }),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: addButton(context),
          ),
        ],
      ),
    );
  }

  Widget pattern(int index) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 10.w),
          decoration: BoxDecoration(
            border: Border.all(
              color: const Color.fromARGB(255, 255, 197, 110),
            ),
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Удалить шаблон",
                style: TextStyle(
                  fontSize: 16.sp,
                  color: Colors.red,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Icon(
                Icons.delete_forever_outlined,
                size: 22.r,
                color: Colors.red,
              )
            ],
          ),
        ),
        PatternContainer(
          pattern: listData[index],
        ),
      ],
    );
  }

  Widget addButton(BuildContext context) {
    return GestureDetector(
      onTap: () {
        addDialog(context);
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 30.w, vertical: 10.h),
        padding: EdgeInsets.symmetric(vertical: 10.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.r),
          color: const Color.fromARGB(255, 0, 23, 42),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.add_circle_outline_outlined,
              size: 22.r,
              color: Colors.white,
            ),
            Text(
              "Добавить",
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
