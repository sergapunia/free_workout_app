import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:free_workout/models/exercise_model.dart';
import 'package:free_workout/services/hive_service.dart';

class AddDialog extends StatefulWidget {
  AddDialog({
    super.key,
    required this.boxName,
    required this.onPress,
  });
  String boxName;
  Function onPress;
  @override
  State<AddDialog> createState() => _AddDialogState();
}

class _AddDialogState extends State<AddDialog> {
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController targetGroupController = TextEditingController();
  String select = "сложность...";
  final hive = HiveService();

  bool? valName;
  bool? valDescription;
  bool? valTarget;
  bool? valSelect;

  void validatorName() {
    if (nameController.text.isEmpty) {
      valName = true;
    } else {
      valName = false;
    }
  }

  void validatorDescription() {
    if (descriptionController.text.isEmpty) {
      valDescription = true;
    } else {
      valDescription = false;
    }
  }

  void validatorTarget() {
    if (targetGroupController.text.isEmpty) {
      valTarget = true;
    } else {
      valTarget = false;
    }
  }

  void validatorSelect() {
    if (select == "сложность...") {
      valSelect = true;
    } else {
      valSelect = false;
    }
  }

  Future<void> save() async {
    validatorName();
    validatorTarget();
    validatorDescription();
    validatorSelect();
    if (valName == false &&
        valDescription == false &&
        valSelect == false &&
        valTarget == false) {
      //save
      ExerciseModel exerciese = ExerciseModel(
          name: nameController.text,
          description: descriptionController.text,
          targetGroup: targetGroupController.text,
          complexity: select);
      if (widget.boxName == "Ноги") {
        await hive.writeData(hive.legBox, exerciese.toJson());
      }
      if (widget.boxName == "Руки") {
        await hive.writeData(hive.armBox, exerciese.toJson());
      }
      if (widget.boxName == "Спина") {
        await hive.writeData(hive.spineBox, exerciese.toJson());
      }
      if (widget.boxName == "Грудь") {
        await hive.writeData(hive.breastBox, exerciese.toJson());
      }
      Navigator.pop(context);
      nameController.clear();
      descriptionController.clear();
      targetGroupController.clear();
      select = "сложность...";
      widget.onPress();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        "Добавление упражнения",
        style: TextStyle(
          fontSize: 18.sp,
          fontWeight: FontWeight.w700,
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Visibility(
            visible: valSelect ?? false,
            child: errorText("Выберите сложность"),
          ),
          selectMenu(context),
          Visibility(
            visible: valName ?? false,
            child: errorText("Введите название"),
          ),
          inputField(
            "название упражнения..",
            "Название",
            nameController,
            1,
            60,
          ),
          Visibility(
            visible: valTarget ?? false,
            child: errorText("Введите группы мышц"),
          ),
          inputField(
            "целевые мышцы..",
            "Целевые мышцы",
            targetGroupController,
            1,
            null,
          ),
          Visibility(
            visible: valDescription ?? false,
            child: errorText("Введите описание"),
          ),
          inputField(
            "описание..",
            "Описание",
            descriptionController,
            4,
            null,
          ),
          addButton(),
        ],
      ),
    );
  }

  Widget addButton() {
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
            const Spacer(),
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

  Widget selectMenu(BuildContext context) {
    Color col = Colors.white;
    Color colText = Colors.black;
    if (select == "легко") {
      col = Colors.blue;
      colText = Colors.white;
    }

    if (select == "средне") {
      col = Colors.yellow;
      colText = Colors.black;
    }
    if (select == "тяжело") {
      col = Colors.red;
      colText = Colors.white;
    }
    return PopupMenuButton(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 5.w),
          decoration: BoxDecoration(
            color: col,
            border: Border.all(),
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: Text(
            select,
            style: TextStyle(
              fontSize: 15.sp,
              fontWeight: FontWeight.w600,
              color: colText,
            ),
          ),
        ),
        onSelected: (value) {
          select = value;
          setState(() {});
        },
        itemBuilder: (context) {
          return [
            PopupMenuItem(
              child: Text(
                "легко",
                style: TextStyle(
                  fontSize: 14.sp,
                ),
              ),
              value: "легко",
            ),
            PopupMenuItem(
              child: Text(
                "средне",
                style: TextStyle(
                  fontSize: 14.sp,
                ),
              ),
              value: "средне",
            ),
            PopupMenuItem(
              child: Text(
                "тяжело",
                style: TextStyle(
                  fontSize: 14.sp,
                ),
              ),
              value: "тяжело",
            ),
          ];
        });
  }

  Widget errorText(String text) {
    return Row(
      children: [
        Icon(
          Icons.warning_amber_rounded,
          color: const Color.fromARGB(255, 133, 17, 9),
          size: 20.r,
        ),
        Text(
          text,
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: const Color.fromARGB(255, 185, 29, 18),
          ),
        )
      ],
    );
  }

  Widget inputField(String hint, String title, TextEditingController controller,
      int minLine, int? maxLen) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.h),
      padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
      decoration: BoxDecoration(
        border: Border.all(),
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Divider(
                height: 0,
              ),
            ],
          ),
          TextField(
            maxLength: maxLen,
            style: TextStyle(fontSize: 14.sp),
            controller: controller,
            minLines: minLine,
            maxLines: null,
            decoration: InputDecoration(
              hintStyle: TextStyle(fontSize: 14.sp),
              hintText: hint,
              border: InputBorder.none,
            ),
          ),
        ],
      ),
    );
  }
}
