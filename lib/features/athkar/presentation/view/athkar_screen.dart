import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamic/const.dart';
import 'package:islamic/features/athkar/json_files/evening_json.dart';
import 'package:islamic/features/athkar/presentation/widgets/athkar_app_bar.dart';
import 'package:islamic/features/athkar/presentation/widgets/notification_widget.dart';
import '../../json_files/morning_json.dart';
import '../../model/athkar_model.dart';

class AthkarScreen extends StatefulWidget {
  const AthkarScreen({super.key, required this.type});
final String type;
  @override
  State<AthkarScreen> createState() => _AthkarScreenState();
}

class _AthkarScreenState extends State<AthkarScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  void _onThikrTap() {
    setState(() {
      List<Map<String, dynamic>> sourceList = widget.type == 'sabah' ? athkarList : athkarMap;

      if (sourceList[_currentPage]["count"] > 1) {
        sourceList[_currentPage]["count"] -= 1;
      } else {
        if (_currentPage < sourceList.length - 1) {
          _pageController.nextPage(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeIn,
          );
          _currentPage += 1;
        } else {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text("انتهت الأذكار")));
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<AthkarModel> list =
    widget.type == 'sabah' ? athkarList.map((e) => AthkarModel.fromJson(e)).toList() : athkarMap.map((e) => AthkarModel.fromJson(e)).toList() ;

    final String title = widget.type == 'sabah' ? 'أذكار الصباح' : 'أذكار المساء';

    return Scaffold(
      appBar: AthkarAppBar(title: title,),
      body: SingleChildScrollView(
        child: Column(
          children: [
            NotificationScreen(),
            SizedBox(
              height: 480.h,
              child: PageView.builder(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: list.length,
                itemBuilder: (context, index) {
                  final athkar = list[index];
                  return GestureDetector(
                    onTap: _onThikrTap,
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppColors.navyBlueColor,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          padding: const EdgeInsets.all(24),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                athkar.text??'',
                                textAlign: TextAlign.center,
                                style:  TextStyle(
                                  color: Colors.white,
                                    fontSize: 24.sp
                                ),
                              ),
                              const SizedBox(height: 20),
                              Text(
                                "التكرار المتبقي: ${athkar.count}",
                                style: TextStyle(
                                  fontSize: 20.sp,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
