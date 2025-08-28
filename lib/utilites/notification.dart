import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:go_router/go_router.dart';
import 'package:preppal/service/model/meals_by_cat.dart';
import 'package:timezone/timezone.dart' as tz;

import '../routes.dart';

class NotificationMethod {
  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static void init({BuildContext? context}) {
    AndroidInitializationSettings initializationSettingsAndroid =
        const AndroidInitializationSettings('@mipmap/ic_launcher');

    final InitializationSettings initializationSettings =
        InitializationSettings(
          android: initializationSettingsAndroid,
          iOS: DarwinInitializationSettings(),
        );

    flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse notificationResponse) async {
        final payload = notificationResponse.payload;
        if (payload != null) {
        final data = jsonDecode(payload);

        print("_________________________$payload");

        navigatorKey.currentContext?.go(
          "/detailed",
          extra: {
            'imgLink': data["imgLink"],
            'mealId': data["mealId"],
            'mealName': data["mealName"],
          },
        );
      }},

      // onDidReceiveBackgroundNotificationResponse: notificationTapBackground,
    );
  }

  static Future<void> scheduleNotification(
    int id,
    DateTime scheduledDateTime,
    String title,
    String mealId,
      String imgLink,
      String mealName,

  ) async {
    AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
          'MealPlanner',
          'MealPlanner',
          channelDescription: 'MealPlanner',
          importance: Importance.max,
          priority: Priority.high,
          playSound: true,
          showWhen: true,
          enableLights: true,
          enableVibration: true,
          showProgress: true,
          icon: '@mipmap/ic_launcher',
        );
    NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
    );

    await flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      'Make Time ⏰',
      title,
      tz.TZDateTime.from(scheduledDateTime, tz.local),
      platformChannelSpecifics,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      matchDateTimeComponents: null,
      payload: jsonEncode({
        "imgLink": imgLink,
        "mealId": mealId,
        "mealName": mealName,
      }),
      // uiLocalNotificationDateInterpretation:
      // UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  static Future<void> scheduleNotificationFromInput(
    int id,
    DateTime selectedDate,
    TimeOfDay selectedTime,
    String title,
    String mealId,
      String imgLink,
      String mealName
  ) async {
    final DateTime scheduledDateTime = DateTime(
      selectedDate.year,
      selectedDate.month,
      selectedDate.day,
      selectedTime.hour,
      selectedTime.minute,
    );
    await scheduleNotification(id, scheduledDateTime, title, mealId,imgLink,mealName);
  }
}
