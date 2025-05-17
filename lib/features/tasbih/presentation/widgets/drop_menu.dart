import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../const.dart';

class DropMenu extends StatelessWidget {
  final int count;
  final List<String> athkarList;
  final String selectedThikr;
  final Function() increment ;
  final Function() loading ;
  final void Function(String?)? onChanged;

  const DropMenu({super.key, required this.count, required this.selectedThikr, required this.athkarList, required this.increment, required this.loading, this.onChanged});


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Text(
            "$count",
            style: TextStyle(color: Colors.black, fontSize: 50.sp),
          ),
        ),
        SizedBox(height: 20.h,),
        Row(
          children: [
            InkWell(
              onTap: increment,
              child: Container(
                margin: EdgeInsets.only(right: 10.w),
                width: 200.w,
                height: 50.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.r),
                  color: AppColors.blueColor,
                ),
                child: Center(
                  child: Text(
                    selectedThikr,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(width: 10.w),
            DropdownButton<String>(
              value: null,
              underline: SizedBox(),
              icon: Icon(Icons.arrow_drop_down_circle_outlined,
                color: AppColors.blueColor, size: 30.r,),
              style: TextStyle(color: Colors.black),
              items: athkarList.map((value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              }).toList(),
              onChanged: onChanged,
            ),
          ],
        ),
      ],
    );
  }
}
