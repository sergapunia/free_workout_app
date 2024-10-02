import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:free_workout/constant/base_scaffold.dart';
import 'package:free_workout/navigator/app_navigator.dart';
import 'package:free_workout/widgets/buttom_container.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({super.key});

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      leading: false,

      title: "Free Workout",
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 50.h),
        child: Wrap(
          children: [
            ButtomContainer(
              text: "Знания",
              imagePath: "assets/images/body_phone.png",
              onTap: () {
                AppNavigator.toDataWorkoutScreen(context);
              },
            ),
            ButtomContainer(
              text: "Начать",
              imagePath: "assets/images/train_fone.png",
              onTap: () {
                AppNavigator.toStartTrainScreen(context);
              },
            ),
            ButtomContainer(
              text: "История",
              imagePath: "assets/images/patterns_fone.png",
              onTap: () {
                AppNavigator.toHistoryScreen(context);
              },
            ),
            ButtomContainer(
              text: "Шаблоны",
              imagePath: "assets/images/fone_history.png",
              onTap: () {
                AppNavigator.toPatternsTrainScreen(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
