import 'package:diary/config/app_colors.dart';
import 'package:diary/screen/main_screen.dart';
import 'package:diary/widget/bottom_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

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

        primarySwatch: getMaterialColor(AppColors.basicColor),
        useMaterial3: false,
      ),

      //기본Locale
      locale: Locale('ko', 'KR'),
      supportedLocales: [
        //추가 지원 Locale
        Locale('en', 'US'),
        Locale('ko', 'KR'),
      ],
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        // TableCalendar에 필요함
        DefaultMaterialLocalizations.delegate,
      ],
      home: BottomWidget(),
    );
  }
}

