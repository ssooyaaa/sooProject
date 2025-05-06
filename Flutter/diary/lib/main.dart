import 'package:diary/config/app_colors.dart';
import 'package:diary/model/routine_model.dart';
import 'package:diary/model/todayRoutine_model.dart';
import 'package:diary/model/user_model.dart';
import 'package:diary/screen/login_screen.dart';
import 'package:diary/screen/main_screen.dart';
import 'package:diary/screen/splash_screen.dart';
import 'package:diary/widget/bottom_widget.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UserModel()),
        ChangeNotifierProvider(create: (context) => RoutineModel()),
        ChangeNotifierProvider(create: (context) => TodayRoutineModel()),
      ],
      child: MaterialApp(
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
        home: SplashScreen(),
      ),
    );
  }
}

