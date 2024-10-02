import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:free_workout/models/exercise_model.dart';
import 'package:free_workout/services/hive_service.dart';
import 'package:free_workout/widgets/buttom_dialog_pattern.dart';
import 'package:free_workout/widgets/info_exerciese_for_pattern.dart';

class AddPatternDialog extends StatefulWidget {
  AddPatternDialog({super.key, required this.saveFunc});
  Function saveFunc;
  @override
  State<AddPatternDialog> createState() => _AddPatternDialogState();
}

class _AddPatternDialogState extends State<AddPatternDialog> {
  final hive = HiveService();
  Future<void> save() async {
    await hive.writePatternData(listPatterns.map((e) => e.toJson()).toList());
    Navigator.pop(context);
    widget.saveFunc();
  }

  void add() {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return ButtomDialogPattern(
            add: (value) {
              listPatterns.add(value);
              setState(() {});
            },
          );
        });
  }

  List<ExerciseModel> listPatterns = [];
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        "Добавить шаблон",
        style: TextStyle(
          fontSize: 18.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ConstrainedBox(
            constraints: BoxConstraints(maxHeight: 400.h),
            child: SingleChildScrollView(
              child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: listPatterns
                      .map((e) => Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Expanded(
                                  child: InfoExercieseForPattern(value: e)),
                              GestureDetector(
                                onTap: () {
                                  listPatterns.remove(e);
                                  setState(() {});
                                },
                                child: Icon(
                                  Icons.delete_forever_outlined,
                                  color: Colors.red,
                                  size: 30.r,
                                ),
                              ),
                            ],
                          ))
                      .toList()),
            ),
          ),
          addButton(),
          saveButton(),
        ],
      ),
    );
  }

  Widget addButton() {
    return GestureDetector(
      onTap: () {
        add();
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 40.w),
        margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 5.h),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 17, 57, 0),
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.add_circle_outline_rounded,
              size: 20.r,
              color: Colors.white,
            ),
            SizedBox(
              width: 10.w,
            ),
            Flexible(
              child: Text(
                "Добавить упражнение",
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget saveButton() {
    return GestureDetector(
      onTap: () async {
        await save();
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 40.w),
        margin: EdgeInsets.symmetric(horizontal: 20.w),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 20, 26, 77),
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.save,
              size: 20.r,
              color: Colors.white,
            ),
            SizedBox(
              width: 10.w,
            ),
            Text(
              "Сохранить",
              style: TextStyle(
                fontSize: 14.sp,
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
