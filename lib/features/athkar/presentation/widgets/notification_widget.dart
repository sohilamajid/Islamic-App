import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamic/features/athkar/presentation/widgets/notification_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../const.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  bool notificationsEnabled = false;
  TimeOfDay selectedTime = TimeOfDay.now();

  @override
  void initState() {
    super.initState();
    _loadNotificationPreference();
  }
  @override
  Widget build(BuildContext context) {
    final timeString = selectedTime.format(context);
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Container(
        padding: EdgeInsets.only(top: 10.h,right: 20.w,left: 20.w ),
        width: double.infinity,
        height: 100.h,
        decoration: BoxDecoration(
          color: AppColors.navyBlueColor,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  'تفعيل الاشعارات',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.sp,
                  ),
                ),
                const Spacer(),
                Switch(
                  value: notificationsEnabled,
                  onChanged: _onSwitchChanged,
                  activeColor: Colors.white,
                ),
              ],
            ),
            GestureDetector(
              onTap: _pickTime,
              child: Row(
                children: [
                  const Icon(Icons.access_time, color: Colors.white),
                  const SizedBox(width: 10),
                  Text(
                    'الوقت المحدد لارسال الاشعارات: $timeString',
                    style:  TextStyle(
                      fontSize: 15.sp,
                        color: Colors.white
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ) ;
  }
  Future<void> _loadNotificationPreference() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      notificationsEnabled = prefs.getBool("notification") ?? false;
      final hour = prefs.getInt("notif_hour") ?? TimeOfDay.now().hour;
      final minute = prefs.getInt("notif_minute") ?? TimeOfDay.now().minute;
      selectedTime = TimeOfDay(hour: hour, minute: minute);
    });
  }

  Future<void> _scheduleDailyNotification() async {
    final now = TimeOfDay.now();
    final isEvening = now.hour > 16 || (now.hour == 16 && now.minute >= 30);

    final title = isEvening ? "أذكار المساء" : "أذكار الصباح";
    final body = isEvening ? "لا تنس أذكار المساء" : "لا تنس أذكار الصباح";

    await NotificationService().scheduleNotification(
      title: title,
      body: body,
      hour: selectedTime.hour,
      minute: selectedTime.minute,
    );
  }

  Future<void> _pickTime() async {
    final TimeOfDay? time = await showTimePicker(
      context: context,
      initialTime: selectedTime,
      builder: (context, child) => child!,
    );

    if (time != null) {
      setState(() => selectedTime = time);
    }
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt("notif_hour", time!.hour);
    await prefs.setInt("notif_minute", time.minute);
    if (notificationsEnabled) {
      await _scheduleDailyNotification();
    }
  }

  Future<void> _onSwitchChanged(bool value) async {
    setState(() => notificationsEnabled = value);

    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool("notification", value);

    if (value) {
      await _scheduleDailyNotification();
    } else {
      NotificationService().cancelAllNotifications();
    }
  }
}
