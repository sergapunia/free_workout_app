import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ButtomContainer extends StatelessWidget {
  const ButtomContainer({
    super.key,
    required this.text,
    required this.imagePath,
    required this.onTap,
  });
  final String text;
  final String imagePath;
  final Function onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:(){onTap();},
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        width: 150.w,
        height: 200.h,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(imagePath),
            fit: BoxFit.cover,
          ),
          border: Border.all(
            width: 5.r,
            color: const Color.fromARGB(255, 40, 61, 64),
          ),
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 5.w),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 230, 230, 230),
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Text(
              text,
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
