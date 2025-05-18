import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:flutter_timezone/flutter_timezone.dart';

class NotificationService {
  final notificationsPlugin = FlutterLocalNotificationsPlugin();

  final bool _isInitialized = false;

  bool get isInitialized => _isInitialized;

  //INITIALIZE
  Future<void> initNotification() async {
    if (_isInitialized) return; //prevent re-intialization

    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
    flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()!.requestNotificationsPermission();

    //init timezone handling
    tz.initializeTimeZones();
    final String currentTimeZone = await FlutterTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(currentTimeZone));

    //prepare android init settings
    const initSettingsAndroid = AndroidInitializationSettings(
      '@mipmap/ic_launcher',
    );

    //prepare android init settings
    const initSettingsIOS = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    //init settings
    const initSettings = InitializationSettings(
      android: initSettingsAndroid,
      iOS: initSettingsIOS,
    );

    //finally initialize the plugin
    await notificationsPlugin.initialize(initSettings);

  }

  //NOTIFICATIONS DETAIL SETUP
  NotificationDetails notificationDetails() {
    return const NotificationDetails(
      android: AndroidNotificationDetails(
        'daily_channel_id',
        "Daily Notifications",
        channelDescription: 'Daily Notification Channel',
        importance: Importance.max,
        priority: Priority.high,
      ),
      iOS: DarwinNotificationDetails(),
    );
  }

  //SHOW an immediate notification
  Future<void> showNotification({
    int id = 0,
    String? title,
    String? body,
    String? payload,
  }) async {
    return notificationsPlugin.show(id, title, body, notificationDetails());
  }

  //Schedule a notification at a specified time
  Future<void> scheduleNotification({
    int id = 1,
    required String title,
    required String body,
    required int hour,
    required int minute,
  }) async {
    //Get the current date/time in device's local timezone
    final now = tz.TZDateTime.now(tz.local);

    //create a date/time for today at the specified hour/min
    var scheduleDate = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      hour,
      minute,
    );

    //Schedule the notification
    await notificationsPlugin.zonedSchedule(
        id,
        title,
        body,
        scheduleDate,
        notificationDetails(),

      //IOS specific: Use exact time specified (vs relative time)
      //uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,

      //Android specific: Allow notification while device is in low_power mode
      androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,

      //make notification repeat daily at same time
      matchDateTimeComponents: DateTimeComponents.time,
    );
    print("Notification Scheduled --------------------");
  }

  //cancel all notifications
  Future<void> cancelAllNotifications()async{
    await notificationsPlugin.cancelAll();
  }
}
