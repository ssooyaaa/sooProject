import 'dart:async';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotification {
  // 플러그인 인스턴스 생성
  static final FlutterLocalNotificationsPlugin
  _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  // 푸시 알림 스트림 생성
  static final StreamController<String?> notificationStream =
  StreamController<String?>.broadcast();

// 푸시 알림 탭 했을 때 호출되는 함수
  static void onNotificationTap(NotificationResponse notificationResponse) {
    notificationStream.add(notificationResponse.payload!);
  }

  //플러그인 초기화
  static Future init() async {

    //안드로이드 알람 이미지 세팅
    const AndroidInitializationSettings initializationSettingAndroid =
    AndroidInitializationSettings("@mipmap/ic_launcher");

    //iOS 세팅 - 유저 권한 요청
    const DarwinInitializationSettings initializationSettingIOS =
    DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    const InitializationSettings initializationSettings =
    InitializationSettings(
      android: initializationSettingAndroid,
      iOS: initializationSettingIOS,
    );

// 안드로이드 알람 권한 요청
    if (Platform.isAndroid) {
      _flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()!
          .requestNotificationsPermission();
    }

    _flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      //푸시 알람 탭 클릭시 호출 콜백함수
      onDidReceiveNotificationResponse: onNotificationTap,
      onDidReceiveBackgroundNotificationResponse: onNotificationTap,
    );
  }

//일반 푸시알람 보내기
  static Future showSimpleNotification({
    required String title,
    required String body,
    required String payload,
  }) async {
    const AndroidNotificationDetails androidNotificationDetails =
    AndroidNotificationDetails('channel 1', 'channel 1 name',
        channelDescription: 'channel 1 desc',
        importance: Importance.max,
        priority: Priority.high,
        ticker: 'ticker');

    const NotificationDetails notificationDetails =
    NotificationDetails(android: androidNotificationDetails);

    await _flutterLocalNotificationsPlugin
        .show(0, title, body, notificationDetails, payload: payload);
  }

//지정된 스케줄에 맞춰 알람 보내기
  static Future showScheduledNotification({
    required String title,
    required String body,
    required String payload,
    required DateTime scheduledTime, // 원하는 시간을 입력받음
  }) async {
    tz.initializeTimeZones(); //타임존 초기화

    // DateTime을 TZDateTime으로 변환
    final tz.TZDateTime scheduledDateTime = tz.TZDateTime.from(scheduledTime, tz.local);

    await _flutterLocalNotificationsPlugin.zonedSchedule(
        2,
        title,
        body,
        tz.TZDateTime.now(tz.local).add(const Duration(seconds: 5)),
        const NotificationDetails(
          android: AndroidNotificationDetails(
            'channel 3',
            "channel name",
            channelDescription: "channel desc",
            importance: Importance.max,
            priority: Priority.high,
            ticker: 'ticker',
          ),
        ),
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        /*uiLocalNotificationDateInterpretation:
        UILocalNotificationDateInterpretation.absoluteTime,*/ //ios 알림시간 해석 방식 설정
        payload: payload);
  }

  static Future scheduleDailyNotification({
    required String title,
    required String body,
    required String payload,
  }) async {
    tz.initializeTimeZones(); // 타임존 초기화
    tz.setLocalLocation(tz.getLocation('Asia/Seoul'));

    // 매일 오후 11시 설정
    //final tz.TZDateTime asia = tz.TZDateTime.now(tz.getLocation('Asia/Seoul'));
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);

    final tz.TZDateTime scheduledDateTime = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      23, // 오후 11시
      0,  // 분
      0,  // 초
    );


    // 만약 현재 시간이 오후 11시 이후라면 다음 날로 설정
    final tz.TZDateTime finalScheduledDateTime =
    scheduledDateTime.isBefore(now) ? scheduledDateTime.add(const Duration(days: 1)) : scheduledDateTime;

   await _flutterLocalNotificationsPlugin.zonedSchedule(
      DateTime.now().millisecondsSinceEpoch ~/ 1000, // 고유 ID 생성 // 알림 ID
      title,
      body,
      finalScheduledDateTime, // 매일 오후 11시
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'daily_channel_id', // 채널 ID
          'Daily Notifications', // 채널 이름
          channelDescription: 'Daily scheduled notifications', // 채널 설명
          importance: Importance.max,
          priority: Priority.high,
        ),
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      matchDateTimeComponents: DateTimeComponents.time, // 매일 같은 시간에 반복
      payload: payload,
    );
  }
}
