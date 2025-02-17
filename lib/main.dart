import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:mybmirecord/View/home.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized(); //Flutter 초기화 여부 확인
    await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  MobileAds.instance.initialize(); // MobilesAD 초기화
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  static const seedColor = Color.fromARGB(255, 67, 0, 93);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return ScreenUtilInit( // 크기를 반응형으로 만등기 위함
      designSize: const Size(435, 1000),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            // colorScheme: ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 224, 87, 19)),
            colorSchemeSeed: seedColor,
            brightness: Brightness.light,
            useMaterial3: true,
          ),
          home: const Home(),
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}
