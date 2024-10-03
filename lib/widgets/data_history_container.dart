import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DataHistoryContainer extends StatelessWidget {
  DataHistoryContainer({
    super.key,
    required this.data,
  });

  List<Map<String, dynamic>> data;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.h),
      child: Column(
        children: [
          rowDate(),
          listTrain(),
        ],
      ),
    );
  }

  Widget listTrain() {
    return Column(
      children: data.sublist(3).map((e) => containerExercieseInfo(e)).toList(),
    );
  }

  Widget containerExercieseInfo(Map<String, dynamic> value) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      margin: EdgeInsets.symmetric(vertical: 5.h, horizontal: 20.w),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 162, 97, 0),
        borderRadius: BorderRadius.circular(10.r),
        border: Border(
          bottom: BorderSide(
            width: 2.r,
            color: Colors.white,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Подходы",
                style: TextStyle(
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
              SizedBox(
                width: 10.w,
              ),
              Text(
                "Повторения",
                style: TextStyle(
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 2.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 3,
                  child: Text(
                    value["name"].toString(),
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    children: List<List<int>>.from(value["results"])
                        .map((e) => counterContainer(e))
                        .toList(),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget counterContainer(List<int> counter) {
    return Row(
      children: [
        Text(
          counter[0].toString(),
          style: TextStyle(
            fontSize: 16.sp,
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(
          width: 50.w,
        ),
        Text(
          counter[1].toString(),
          style: TextStyle(
            fontSize: 16.sp,
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }

  Widget rowDate() {
    List<String> preTime = data[2]["time"].toString().split(":");
    String time = "${preTime[0].padLeft(2, "0")}:${preTime[1].padLeft(2, "0")}";
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.w),
      margin: EdgeInsets.symmetric(horizontal: 30.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        color: const Color.fromARGB(255, 142, 113, 69),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 2.h),
            decoration: BoxDecoration(
              border: Border.all(
                width: 2.r,
                color: const Color.fromARGB(255, 0, 30, 55),
              ),
              borderRadius: BorderRadius.circular(5.r),
            ),
            child: Row(
              children: [
                Text(
                  data[0]["date"].toString(),
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  width: 10.w,
                ),
                Text(
                  time,
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          Text(
            data[1]["trainingTime"].toString(),
            style: TextStyle(
              fontSize: 20.sp,
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
