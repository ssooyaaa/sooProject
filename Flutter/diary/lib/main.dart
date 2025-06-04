import 'dart:math';

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
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'LocalNotification.dart';


final navigatorKey = GlobalKey<NavigatorState>();
FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();

//알람 메시지 문구
List<String> titles = [
  "오늘도 수고했어요! 🌟",
  "당신은 멋진 하루를 보냈어요! 💪",
  "좋은 밤 되세요! 🌙",
  "하루를 마무리하며",
  "오늘도 최고였어요! 😄"
];

List<String> bodies = [
  "하루를 잘 마무리하세요. 내일은 더 멋진 하루가 될 거예요.",
  "하루를 돌아보며 나만의 시간을 가져보세요. 내일을 기대해요.",
  "오늘도 힘내셨어요. 편안한 밤 되세요.",
  "당신의 하루는 이미 특별했어요. 좋은 꿈 꾸세요!",
  "오늘도 잘 버텨냈어요! 내일은 더 좋은 날이 될 거예요."
];

//랜덤으로 일치하는 title과 body를 반환하는 함수
Map<String, String> getRandomTitleAndBody(){
  final randomIndex = Random().nextInt(titles.length);  // 랜덤 인덱스 선택
  String title = titles[randomIndex];
  String body = bodies[randomIndex];
  return {'title': title, 'body': body};
}


void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // 로컬 푸시 알림 초기화
  await LocalNotification.init();

  // 이전 알림 모두 취소
  await flutterLocalNotificationsPlugin.cancelAll();


  // 앱이 종료된 상태에서 푸시 알람 탭
  final NotificationAppLaunchDetails? notificationAppLaunchDetails =
  await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();

  if (notificationAppLaunchDetails?.didNotificationLaunchApp ?? false) {
    Future.delayed(const Duration(seconds: 1), () {
      navigatorKey.currentState!.pushNamed('/message',
          arguments:
          notificationAppLaunchDetails?.notificationResponse?.payload);
    });
  }

  // 매일 오후 11시 알림 설정
  Map<String, String> msg = getRandomTitleAndBody();
  String title = msg['title']!;
  String body = msg['body']!; //!:null이 아님을 보장
  //String? body = msg['body']; //?:null이 될 수 있음을 허용
  await LocalNotification.scheduleDailyNotification(
    title: title,
    body: body,
    payload: 'daily_reminder',
  );

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
        routes: {
          '/message': (context) => SplashScreen(), // 알림 탭 시 이동할 화면
        },
      ),
    );
  }
}

