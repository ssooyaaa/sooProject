import 'package:csh_final_app/config/app_color.dart';
import 'package:csh_final_app/screen/splash_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        fontFamily: 'noto_r',
        primarySwatch: getMaterialColor(AppColors.mainColor),
        useMaterial3: false,
      ),
      home: SplashScreen(),
    );
  }
}

