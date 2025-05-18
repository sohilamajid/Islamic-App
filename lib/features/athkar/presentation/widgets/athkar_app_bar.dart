import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../const.dart';
class AthkarAppBar extends StatelessWidget implements PreferredSizeWidget{
  final String title ;
  const AthkarAppBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: AppColors.blueColor,
      title: Text(
        title,
        style: TextStyle(
          fontSize: 20.sp,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      centerTitle: true,
      leading: InkWell(
        onTap: () => Navigator.pop(context),
          child: Icon(Icons.arrow_back, color: Colors.white)),
      actions: [Icon(Icons.more_vert, color: Colors.white)],
    );
  }
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
