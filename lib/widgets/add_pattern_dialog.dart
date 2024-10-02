import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:free_workout/models/exercise_model.dart';

class AddPatternDialog extends StatefulWidget {
  const AddPatternDialog({super.key});

  @override
  State<AddPatternDialog> createState() => _AddPatternDialogState();
}

class _AddPatternDialogState extends State<AddPatternDialog> {
  Future<void> save() async {}
  void add() {
    listPatterns.add(
      ExerciseModel(
        name: "name",
        description: "des",
        targetGroup: "tar",
        complexity: "легко",
      ),
    );
    setState(() {});
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
                  children: listPatterns.map((e) => containerInfo(e)).toList()),
            ),
          ),
          addButton(),
          saveButton(),
        ],
      ),
    );
  }

  Widget containerInfo(ExerciseModel value) {
    Color col = Colors.black;
    Color colText = Colors.white;
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
          Text(
            value.name,
            style: TextStyle(
              fontSize: 18.sp,
            ),
          ),
          const Spacer(),
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
