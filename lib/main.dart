import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:mybmirecord/View/home.dart';
import 'package:responsive_framework/responsive_framework.dart';



const Map<String, String> UNIT_ID = kReleaseMode
    ? {
        'ios': '[YOUR iOS AD UNIT ID]',
        'android': '[YOUR ANDROID AD UNIT ID]',
      }
    : {
        'ios': 'ca-app-pub-4716787481822502/4135660246',
        'android': 'ca-app-pub-3940256099942544/6300978111',
      };


void main() {
  WidgetsFlutterBinding.ensureInitialized(); //Flutter 초기화 여부 확인
  MobileAds.instance.initialize(); // MobilesAD 초기화
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  static const seedColor = Color.fromARGB(255, 67, 0, 93);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return GetMaterialApp(
      builder: (context, child) =>
          ResponsiveBreakpoints.builder(child: child!, breakpoints: [
        const Breakpoint(start: 0, end: 450, name: MOBILE),
        const Breakpoint(start: 451, end: 800, name: TABLET),
        const Breakpoint(start: 801, end: 1920, name: '2K'),
        const Breakpoint(start: 1921, end: double.infinity, name: '4K'),
      ]),
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
  }
}