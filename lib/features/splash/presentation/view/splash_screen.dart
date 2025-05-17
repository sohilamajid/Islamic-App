import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:islamic/const.dart';
import 'package:islamic/features/home/presentation/view/home_screen.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();

}

class _SplashScreenState extends State<SplashScreen> {
  // @override
  // void initState() {
  //   Future.delayed(const Duration(seconds: 3)).then((value) =>
  //       Get.offAll(() => const HomeScreen()),);
  //   super.initState();
  // }
  @override
  Widget build(BuildContext context) {
    String quran = "assets/images/quran.png";
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Spacer(),
          Center(
            child: SizedBox(
              width: 210.w,
              height: 200.h,
              child: Image.asset(quran),
            ),
          ),
          Text("My Quran",style: TextStyle(
            color: AppColors.blueColor,
            fontSize: 30.sp,
            fontWeight: FontWeight.bold,
          ),),
          Text("Read the Quran Easily",style: TextStyle(
            color: Colors.grey,
            fontSize: 20.sp,
          ),),
          // SizedBox(height: 20.h,),
          // CircularProgressIndicator(
          //   color: AppColors.blueColor,
          // ),
          Spacer(),
          InkWell(
            onTap: () => Get.offAll(() => const HomeScreen()),
            child: Container(
              height: 53.h,
              width: 181.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: AppColors.blueColor,
              ),
              child: Center(child: Text("Read Now",style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 17.sp,
              ),)),
            ),
          ),
          SizedBox(height: 30.h,),
        ],
      ),
    );
  }
}
