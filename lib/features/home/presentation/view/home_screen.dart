import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../widgets/home_grid.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    String image = "assets/images/image1.png";
    final List<String> texts = ["أذكار الصباح", "أذكار المساء", "أوقات الصلاة", "السبحة"];
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 40.0,left: 20,right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Center(
              child: SizedBox(
                width: 200.w,
                height: 200.h,
                child: Image.asset(image),
              ),
            ),
            SizedBox(height: 50.h,),
            HomeGrid(texts: texts),
          ],
        ),
      ),
    );
  }
}
