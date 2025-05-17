import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class TotalWidget extends StatelessWidget {
  final int totalCount ;
  final void Function()? onTap;
  const TotalWidget({
    super.key, required this.totalCount, this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 20.0.w, right: 10.w),
      child: Row(
        children: [
          Text(
            "الإجمالي: $totalCount",
            style: TextStyle(
              color: Colors.black,
              fontSize: 30.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          Spacer(),
          InkWell(
            onTap: onTap,
              child: Icon(Icons.replay_outlined, color: Colors.black, size: 40.r)),
        ],
      ),
    );
  }
}