import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:free_workout/constant/base_scaffold.dart';
import 'package:free_workout/models/exercise_model.dart';
import 'package:free_workout/services/hive_service.dart';
import 'package:free_workout/widgets/add_dialog.dart';
import 'package:free_workout/widgets/exerciese_container.dart';

class ExerciseInfoScreen extends StatefulWidget {
  ExerciseInfoScreen({
    super.key,
    required this.title,
  });

  final String title;

  @override
  State<ExerciseInfoScreen> createState() => _ExerciseInfoScreenState();
}

class _ExerciseInfoScreenState extends State<ExerciseInfoScreen> {
  final hive = HiveService();
  List<ExerciseModel> listExerciese = [];

  void read() async {
    log("Читаю..");
    List<Map<String, String>> list = [];
    if (widget.title == "Ноги") {
      log("ноги..");

      list = await hive.readData(hive.legBox);
      setState(() {});
    }
    if (widget.title == "Руки") {
      log("руки..");

      list = await hive.readData(hive.armBox);
      setState(() {});
    }
    if (widget.title == "Спина") {
      log("спина..");

      list = await hive.readData(hive.spineBox);
      setState(() {});
    }
    if (widget.title == "Грудь") {
      log("грудь..");

      list = await hive.readData(hive.breastBox);
      setState(() {});
    }
    listExerciese = list.map((e) => ExerciseModel.fromJson(e)).toList();
  }

  void delete(int index) {
    if (widget.title == "Ноги") {
      hive.deleteData(hive.legBox, index);
    }
    if (widget.title == "Руки") {
      hive.deleteData(hive.armBox, index);
    }
    if (widget.title == "Спина") {
      hive.deleteData(hive.spineBox, index);
    }
    if (widget.title == "Грудь") {
      hive.deleteData(hive.breastBox, index);
    }
    read();
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
      builder: (context) => AddDialog(
        onPress: () {
          read();
          setState(() {});
        },
        boxName: widget.title,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      leading: true,
      title: widget.title,
      child: Stack(
        children: [
          ListView.builder(
            itemCount: listExerciese.length,
            itemBuilder: (context, index) {
              ExerciseModel exer = listExerciese[index];
              if (index == listExerciese.length - 1) {
                return Padding(
                  padding: EdgeInsets.only(bottom: 60.h),
                  child: ExercieseContainer(
                    deleteFunc: () {
                      delete(index);
                    },
                    index: index,
                    exerciese: exer,
                  ),
                );
              } else {
                return ExercieseContainer(
                  deleteFunc: () {
                    delete(index);
                  },
                  index: index,
                  exerciese: exer,
                );
              }
            },
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: addButton(context),
          ),
        ],
      ),
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
