import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamic/features/athkar/presentation/widgets/notification_service.dart';
import '../../../../const.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  bool notificationsEnabled = false;
  TimeOfDay selectedTime = TimeOfDay.now();

  Future<void> _pickTime() async {
    final TimeOfDay? time = await showTimePicker(
      context: context,
      initialTime: selectedTime,
      builder: (context, child) => child!,
    );

    if (time != null) {
      setState(() => selectedTime = time);
    }
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
                  onChanged: (value) {
                    setState(() {
                      notificationsEnabled = value;
                      NotificationService().scheduleNotification(
                          title: "أذكار الصباح",
                          body: "لا تنس قراءتها",
                          hour: selectedTime.hour,
                          minute: selectedTime.minute,
                      );
                    });
                  },
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
            // ElevatedButton(
            //     onPressed: () {
            //       NotificationService().scheduleNotification(
            //           title: "test",
            //           body: "now",
            //           hour: 22,
            //           minute: 22,
            //           );
            //     },
            //     child: Text("scheduled Notification"),),
          ],
        ),
      ),
    ) ;
  }
}
