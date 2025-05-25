import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../prayer_data.dart';
import '../widgets/prayers_layout.dart';
import '../widgets/prayers_list.dart';
import 'package:http/http.dart' as http;

class PrayerTimeScreen extends StatefulWidget {
  const PrayerTimeScreen({super.key});

  @override
  State<PrayerTimeScreen> createState() => _PrayerTimeScreenState();
}

class _PrayerTimeScreenState extends State<PrayerTimeScreen> {

  late Data prayer;

  static String city = 'Menofia';
  static String country = 'Egypt';
  static int method = 5;

  final String url =
      'http://api.aladhan.com/v1/timingsByCity?city=$city&country=$country&method=$method';
  Future getPTData() async {
    final uri = Uri.parse(url);
    http.Response res = await http.get(uri);
    final data = jsonDecode(res.body);

    prayer = Data.fromJson(data);

    //print(prayer.data.timings.fajr);
    return prayer;
  }

  @override
  Widget build(BuildContext context) {
    String background = "assets/images/mosque.png";
    var height = MediaQuery.sizeOf(context).height;
    var width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      body: FutureBuilder(
        future: getPTData(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if(snapshot.hasData){
            return Stack(
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
                    child: Icon(Icons.arrow_back_ios, color: Colors.white),
                  ),
                ),
                Center(
                  child: Padding(
                    padding: EdgeInsets.only(top: 150.0.h),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "أوقات الصلاة",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 30.sp,
                          ),
                        ),
                        SizedBox(
                          height: 450.h,
                          child: ListView.separated(
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              final prayer = prayerTimes[index];
                              final timing = snapshot.data.data.timings.toJson()[prayer["key"]];
                              return PrayersLayout(prayer: prayer, timing: timing);
                            },
                            separatorBuilder:
                                (context, index) => SizedBox(height: 10.h),
                            itemCount: prayerTimes.length,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }else{
            return Center(child: CircularProgressIndicator());
          }
        }
      ),
    );
  }
}

