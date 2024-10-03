import 'package:flutter/material.dart';
import 'package:free_workout/services/hive_service.dart';
import 'package:free_workout/widgets/data_history_container.dart';

import '../constant/base_scaffold.dart';

class HistoryTrainScreen extends StatefulWidget {
  const HistoryTrainScreen({super.key});

  @override
  State<HistoryTrainScreen> createState() => _HistoryTrainScreenState();
}

class _HistoryTrainScreenState extends State<HistoryTrainScreen> {
  
  final hive = HiveService();
  List<List<Map<String, dynamic>>> data = [];
  void getData() async {
    data = await hive.readDataHystori();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
        leading: true,
        title: "История",
        child: ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              return DataHistoryContainer(data:data[index]);
            }));
  }
}
