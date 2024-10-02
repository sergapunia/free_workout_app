import 'package:flutter/material.dart';
import 'package:free_workout/constant/base_scaffold.dart';

import 'package:free_workout/widgets/buttom_container.dart';

import '../navigator/app_navigator.dart';

class DataWorkout extends StatelessWidget {
  DataWorkout({super.key});

  @override
  Widget build(BuildContext context) {
    void toScreenData(String title) {
      AppNavigator.toExerciseInfoScreen(context, title);
    }

    return BaseScaffold(
      leading: true,
      title: "База знаний",
      child: Center(
        child: Wrap(
          children: [
            ButtomContainer(
              text: "Ноги",
              imagePath: "assets/images/leg.png",
              onTap: ()  {
                
                toScreenData("Ноги");
              },
            ),
            ButtomContainer(
              text: "Руки",
              imagePath: "assets/images/ruki.png",
              onTap: ()  {
             
                toScreenData("Руки");
              },
            ),
            ButtomContainer(
              text: "Спина",
              imagePath: "assets/images/spine.png",
              onTap: ()  {

                toScreenData("Спина");
              },
            ),
            ButtomContainer(
              text: "Грудь",
              imagePath: "assets/images/grud.png",
              onTap: ()  {
               
                toScreenData("Грудь");
              },
            ),
          ],
        ),
      ),
    );
  }
}
