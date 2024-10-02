import 'package:flutter/material.dart';

import '../constant/base_scaffold.dart';

class HistoryTrainScreen extends StatelessWidget {
  const HistoryTrainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      leading: true,

        child: Container(
          child: Text("История тренировок"),
        ),
        title: "История");

  }
}