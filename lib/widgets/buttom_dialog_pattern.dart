import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:free_workout/models/exercise_model.dart';
import 'package:free_workout/services/hive_service.dart';
import 'package:free_workout/widgets/info_exerciese_for_pattern.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ButtomDialogPattern extends StatefulWidget {
   ButtomDialogPattern({super.key,required this.add});
  Function(ExerciseModel) add;
  @override
  State<ButtomDialogPattern> createState() => _ButtomDialogPatternState();
}

class _ButtomDialogPatternState extends State<ButtomDialogPattern> {
  int index = 0;
  final hive = HiveService();
  void getExercies() async {
    List<Map<String, String>> exerciest = await hive.readData(hive.spineBox);
    spine = exerciest.map((e) => ExerciseModel.fromJson(e)).toList();

    List<Map<String, String>> exerciest2 = await hive.readData(hive.breastBox);
    breast = exerciest2.map((e) => ExerciseModel.fromJson(e)).toList();

    List<Map<String, String>> exerciest3 = await hive.readData(hive.armBox);
    arms = exerciest3.map((e) => ExerciseModel.fromJson(e)).toList();

    List<Map<String, String>> exerciest4 = await hive.readData(hive.legBox);
    leg = exerciest4.map((e) => ExerciseModel.fromJson(e)).toList();
    log("Получил данные");
    setState(() {});
  }

  void addFunction(ExerciseModel value){
    widget.add(value);
    Navigator.pop(context);
  }

  List<ExerciseModel> spine = [];
  List<ExerciseModel> breast = [];
  List<ExerciseModel> arms = [];
  List<ExerciseModel> leg = [];
  @override
  void initState() {
    super.initState();
    getExercies();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500.h,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 49, 49, 49),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.r),
          topRight: Radius.circular(30.r),
        ),
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                button("Спина", index == 0 ? true : false, () {
                  index = 0;
                  setState(() {});
                }),
                button("Грудь", index == 1 ? true : false, () {
                  index = 1;
                  setState(() {});
                }),
                button("Руки", index == 2 ? true : false, () {
                  index = 2;
                  setState(() {});
                }),
                button("Ноги", index == 3 ? true : false, () {
                  index = 3;
                  setState(() {});
                }),
              ],
            ),
          ),
          Divider(
            height: 0,
            thickness: 2.h,
            color: Colors.white,
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10.h),
            child: IndexedStack(
              index: index,
              children: [
                listExerciest(spine),
                listExerciest(breast),
                listExerciest(arms),
                listExerciest(leg),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget listExerciest(List<ExerciseModel> list) {
    return SizedBox(
      height: 300.h,
      child: ListView.builder(
          itemCount: list.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: (){addFunction(list[index]);},
              child: InfoExercieseForPattern(value: list[index]));
          }),
    );
  }

  Widget button(String text, bool selected, Function onPress) {
    return GestureDetector(
      onTap: () {
        onPress();
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            text,
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.w600,
              color: selected ? Colors.white : Colors.grey,
            ),
          ),
          Visibility(
            visible: selected,
            child: Container(
              width: 60.w,
              height: 5.h,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10.r),
                  topRight: Radius.circular(10.r),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
