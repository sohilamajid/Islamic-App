import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class PrayersLayout extends StatelessWidget {
  const PrayersLayout({
    super.key,
    required this.prayer,
    required this.timing,
  });

  final Map<String, dynamic> prayer;
  final dynamic timing;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: double.infinity,
        height: 50.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              Icon(prayer["icon"],color: Colors.black,),
              SizedBox(width: 10.w,),
              Text(prayer["name"],style: TextStyle(
                color: Colors.black,
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
              ),),
              Spacer(),
              Text(convertToArabicNumbers(timing),style: TextStyle(
                color: Colors.black,
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
              ),),
            ],
          ),
        ),
      ),
    );
  }
  String convertToArabicNumbers(String input) {
    const englishDigits = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
    const arabicDigits = ['٠', '١', '٢', '٣', '٤', '٥', '٦', '٧', '٨', '٩'];

    for (int i = 0; i < englishDigits.length; i++) {
      input = input.replaceAll(englishDigits[i], arabicDigits[i]);
    }
    return input;
  }
}
