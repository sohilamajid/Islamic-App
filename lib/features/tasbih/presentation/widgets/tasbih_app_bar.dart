import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../hive_helper.dart';

class TasbihAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Function()? onPressed;
  final void Function()? onTap;
  const TasbihAppBar({super.key, this.onPressed, this.onTap});

  void showDeleteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text("تأكيد الحذف"),
        content: Text("هل أنت متأكد أنك تريد حذف هذا؟"),
        actions: [
          TextButton(
            onPressed: onPressed,
            child: Text('حذف'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('إلغاء'),
          ),
        ],
      ),
    );
  }
  static Future<void> showHistoryDialog(BuildContext context, {VoidCallback? onDelete}) async {
    await HiveHelper.getList();
    int totalCount = HiveHelper.getTotalCount();

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("سجل التسبيحات", style: TextStyle(fontSize: 20.sp)),
                InkWell(
                  onTap: () {
                    if (onDelete != null) onDelete();
                  },
                  child: Icon(Icons.delete, color: Colors.red),
                ),
              ],
            ),
            SizedBox(height: 10.h),
            for (var thikr in ['استغفر الله', 'الحمد لله', 'سبحان الله', 'الله أكبر', 'لا إله إلا الله'])
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('$thikr:'),
                  Text('${HiveHelper.getHistoryCount(thikr)}'),
                ],
              ),
            Divider(),
            Text(
              'إجمالي التسبيحات: ${HiveHelper.getHistoryTotalCount()}',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('إغلاق'),
          ),
        ],
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      leading: InkWell(
         onTap: onTap,
          child: Icon(Icons.mode_rounded)),
      actions: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
              onTap: () => Navigator.pop(context),
              child: Icon(Icons.arrow_forward_ios, size: 20.r)),
        ),
      ],
    );
  }
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}