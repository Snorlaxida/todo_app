import 'dart:async';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_background_service_android/flutter_background_service_android.dart';
import 'package:todo_app/firebase_options.dart';
import 'package:todo_app/model/todo_task.dart';
import 'package:todo_app/service/firestore_service.dart';
import 'package:todo_app/service/notification_service.dart';

class BackgroundService {
  static Future<void> initializeService() async {
    final service = FlutterBackgroundService();
    await service.configure(
      iosConfiguration: IosConfiguration(
        autoStart: true,
        onForeground: onStart,
        onBackground: onIosBackground,
      ),
      androidConfiguration: AndroidConfiguration(
        onStart: onStart,
        isForegroundMode: true,
        autoStart: true,
      ),
    );
  }

  @pragma('vm:entry-point')
  static void onStart(ServiceInstance service) async {
    WidgetsFlutterBinding.ensureInitialized();
    DartPluginRegistrant.ensureInitialized();
    if (service is AndroidServiceInstance) {
      service.on('setAsForeground').listen((event) {
        service.setAsForegroundService();
      });
      service.on('setAsBackground').listen((event) {
        // print('BACK TIME');
        service.setAsBackgroundService();
      });
      service.on('stopService').listen((event) {
        service.stopSelf();
      });
    }
    try {
      await Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform);
    } catch (e) {
      print('error');
      print(e);
    }
    final FirestoreService firestoreService = FirestoreService();
    final tasksStream = firestoreService.getTasksStream();

    tasksStream.listen(
      (snapshot) {
        final List<TodoTask> taskList = [];
        for (var doc in snapshot.docs) {
          final taskData = doc.data() as Map<String, dynamic>;
          final task = TodoTask(
            docId: doc.id,
            userId: taskData['userId'],
            title: taskData['title'],
            description: taskData['description'],
            deadline: (taskData['deadline'] as Timestamp).toDate(),
            isCompleted: taskData['isComplited'],
          );
          taskList.add(task);
        }
        print('TUTA');
        for (var task in taskList) {
          final notificationTime =
              task.deadline!.subtract(const Duration(minutes: 5));

          NotificationService.scheduleNotification(task, notificationTime);
        }
      },
    );

    // Timer.periodic(
    //   const Duration(seconds: 10),
    //   (timer) async {
    //     if (service is AndroidServiceInstance) {
    //       if (await service.isForegroundService()) {
    //         service.setForegroundNotificationInfo(
    //           title: 'HELLO SABS',
    //           content: 'love potatoes',
    //         );
    //       }
    //     }
    //     print('background service running');

    //     service.invoke('update');
    //   },
    // );
  }

  @pragma('vm:entry-point')
  static Future<bool> onIosBackground(ServiceInstance service) async {
    WidgetsFlutterBinding.ensureInitialized();
    DartPluginRegistrant.ensureInitialized();
    return true;
  }
}
