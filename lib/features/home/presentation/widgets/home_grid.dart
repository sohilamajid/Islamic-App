import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamic/features/athkar/presentation/view/athkar_screen.dart';
import '../../../prayer_times/presentation/view/prayer_time_screen.dart';
import '../../../tasbih/presentation/view/tasbih_screen.dart';

class HomeGrid extends StatelessWidget {
  const HomeGrid({
    super.key,
    required this.texts,
  });

  final List<String> texts;

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      const AthkarScreen(type: 'sabah'),
      const AthkarScreen(type: 'masaa'),
      const PrayerTimeScreen(),
      const TasbihScreen(),
    ];
    return SizedBox(
      height: 300.h,
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.all(8),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 15,
          crossAxisSpacing: 15,
        ),
        itemBuilder:(context, index) => InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => pages[index]),
            );
          },
          child: Container(
            width: 150.w,
            height: 150.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
                bottomRight: Radius.circular(30),
                bottomLeft: Radius.circular(15),
              ),
              color: Color(0xFF586491),
            ),
            child: Center(
              child: Text(texts[index],
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),),
            ),
          ),
        ),
        itemCount: texts.length,
      ),
    );
  }
}