import 'package:flutter/material.dart';

import '../constant/base_scaffold.dart';

class StartTrainScreen extends StatelessWidget {
  const StartTrainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
        leading: true,
        child: Container(
          child: Text("Тренировка"),
        ),
        title: "Тренировка");
  }
}
