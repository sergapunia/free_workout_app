import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'constant.dart';

class BaseScaffold extends StatelessWidget {
  const BaseScaffold({super.key, required this.child, required this.title,required this.leading});
  final Widget child;
  final String title;
  final bool leading;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: leading?IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios_new_outlined,
            color: Colors.white,
            size: 20.r,
          ),
        ):null,
        centerTitle: true,
        backgroundColor: Colors.black,
        title: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 20.sp,
            color: Colors.white,
          ),
        ),
      ),
      body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            gradient: backgroundGradient,
          ),
          child: child),
    );
  }
}
