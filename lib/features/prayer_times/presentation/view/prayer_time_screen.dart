import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../widgets/prayers_layout.dart';
import '../widgets/prayers_list.dart';

class PrayerTimeScreen extends StatelessWidget {
  const PrayerTimeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    String background = "assets/images/mosque.png";
    var height = MediaQuery.sizeOf(context).height;
    var width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            background,
            fit: BoxFit.cover,
            width: width,
            height: height,
          ),
          Positioned(
            top: 50,
              right: 20,
              child: InkWell(
                  onTap: () => Navigator.pop(context),
                  child: Icon(Icons.arrow_back_ios,color: Colors.white,))),
          Center(
            child: Padding(
              padding: EdgeInsets.only(top: 150.0.h),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("أوقات الصلاة",style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 30.sp,
                  ),),
                  SizedBox(
                    height: 450.h,
                    child: ListView.separated(
                      physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          final prayer = prayerTimes[index];
                          return PrayersLayout(prayer: prayer);
                        } ,
                        separatorBuilder: (context, index) => SizedBox(height: 10.h,),
                        itemCount: prayerTimes.length,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

