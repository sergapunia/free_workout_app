import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:free_workout/provider/app_provider.dart';
import 'package:free_workout/screens/home_page_screen.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox("Leg");
  await Hive.openBox("Spine");
  await Hive.openBox("Arms");
  await Hive.openBox("Breast");
  await Hive.openBox("Patterns");
  await Hive.openBox("Hystori");

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    
    return ChangeNotifierProvider(
      create: (context)=> AppState(),
      child: ScreenUtilInit(
          designSize: const Size(412, 915),
          builder: (_, child) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              home: child,
            );
          },
          child: const HomePageScreen(),),
    );
  }
}
