import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:islamic/features/athkar/presentation/widgets/notification_service.dart';
import 'features/splash/presentation/view/splash_screen.dart';
import 'features/tasbih/hive_helper.dart';


void main() async {
  await Hive.initFlutter();
  await Hive.openBox(HiveHelper.tasbihBox);
  await HiveHelper.initializeTasbihList();
  WidgetsFlutterBinding.ensureInitialized();
  //init notifications
  await NotificationService().initNotification();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return GetMaterialApp(
          theme: ThemeData(
            fontFamily: 'Cairo',
          ),
          locale: const Locale("ar"),
          debugShowCheckedModeBanner: false,
          home: const SplashScreen(),
        );
      },
    );
  }
}
