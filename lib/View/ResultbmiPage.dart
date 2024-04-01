import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:mybmirecord/ViewModel_Controller/resultbmipageController.dart';
import 'package:mybmirecord/Model_Func/sqlite_repository.dart';
import 'package:mybmirecord/View/home.dart';

import 'package:get/get.dart';
import 'package:mybmirecord/Widget_Custom/circleChart.dart';
import 'package:mybmirecord/Widget_Custom/CustomWidget.dart';
import 'package:mybmirecord/static/forBannerAd.dart';

import '../static/forRelativeSize.dart';

class ResultBMIPage extends StatelessWidget {
  final int recordKey;

  const ResultBMIPage({
    Key? key,
    required this.recordKey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(ResultBMIPageController());
    // double widthsize = 350;
    // double heightsize = 700;
    double widthsize = RelativeSizeClass(context).widthSize!;
    double heightsize = RelativeSizeClass(context).heightSize!;
    // double fsizeSmall = RelativeSizeClass(context).customFontSizeS!;
    double fsizeMiddle = RelativeSizeClass(context).customFontSizeM!;
    double fsizeLarge = RelativeSizeClass(context).customFontSizeL!;
    double fsizeXLarge = RelativeSizeClass(context).customFontSizeXL!;

    return Scaffold(
      appBar: AppBar(
        // title: TextCustom().customText("My BMI Status ? ", fsizeXLarge, "C"),
        title: const Text("My BMI Record"),
      ),
      body: GetX<ResultBMIPageController>(builder: (controller) {
        if (!controller.querySuccess.value) {
          doQuery(controller);
          return const Center(child: CircularProgressIndicator());
        } else {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                    color: Colors.blueGrey,
                    width: widthsize,
                    height: heightsize * 0.6,
                    child: controller.bmirec!.imgbyte != null
                        ? Image.memory(
                            controller.bmirec!.imgbyte!,
                            width: widthsize,
                            fit: BoxFit.contain,
                          )
                        : Center(
                            child: Container(
                                color: Colors.black,
                                width: widthsize,
                                height: heightsize * 0.55,
                                child: Center(
                                  child: customText(
                                      "No Image", fsizeXLarge, "C",
                                      clr: Colors.white),
                                )),
                          )),

                SizedBox(
                  height: heightsize * 0.01,
                ),
                //화면 구성3 : 기타 내용을 넣기 위한 컨테이너
                //삭제버튼, 광고 배너,
                SizedBox(
                  // color: Colors.amber,
                  width: widthsize,
                  height: heightsize * 0.14,
                  child: 
                  kReleaseMode?
                  AdWidget(ad: MkBannerADclass().mkBannerAD(context))
                      : Center(child: const Text("for banner ad")),
                ),
                const Spacer(),

                //화면구성2 : 수치 및 메시지 전달하는 컨테이너
                SizedBox(
                  // Container(
                  // color: Colors.green,
                  width: widthsize,
                  height: heightsize * 0.15,
                  child: Row(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            //높이 : 0.04
                            children: [
                              SizedBox(
                                // color: Colors.amber[50],
                                height: heightsize * 0.04,
                                width: widthsize * 0.25,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    customText(
                                      "BMI ",
                                      RelativeSizeClass(context).orientation ==
                                              Orientation.portrait
                                          ? fsizeLarge
                                          : fsizeLarge / 1.5,
                                      "L",
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: heightsize * 0.04,
                                width: widthsize * 0.05,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    customText(
                                      ": ",
                                      RelativeSizeClass(context).orientation ==
                                              Orientation.portrait
                                          ? fsizeLarge
                                          : fsizeLarge / 1.5,
                                      "R",
                                    )
                                  ],
                                ),
                              ),
                              // Container(
                              SizedBox(
                                // color: Colors.red[100],
                                height: heightsize * 0.04,
                                width: widthsize * 0.25,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [customText(
                                      "${controller.bmirec!.bmi.toStringAsFixed(1)} ",
                                      RelativeSizeClass(context).orientation ==
                                              Orientation.portrait
                                          ? fsizeLarge
                                          : fsizeLarge / 1.5,
                                      "R",
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: heightsize * 0.01,
                          ),
                          Row(
                            //높이 : 0.04
                            children: [
                              SizedBox(
                                // color: Colors.amber[50],
                                height: heightsize * 0.04,
                                width: widthsize * 0.25,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    customText(
                                      "몸무게",
                                      RelativeSizeClass(context).orientation ==
                                              Orientation.portrait
                                          ? fsizeLarge
                                          : fsizeLarge / 1.5,
                                      "L",
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: heightsize * 0.04,
                                width: widthsize * 0.05,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    customText(
                                      ": ",
                                      RelativeSizeClass(context).orientation ==
                                              Orientation.portrait
                                          ? fsizeLarge
                                          : fsizeLarge / 1.5,
                                      "R",
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                // color: Colors.red[100],
                                height: heightsize * 0.04,
                                width: widthsize * 0.25,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    customText(
                                      "${controller.bmirec!.weight.toStringAsFixed(1)} kg",
                                      RelativeSizeClass(context).orientation ==
                                              Orientation.portrait
                                          ? fsizeLarge
                                          : fsizeLarge / 1.5,
                                      "R",
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: heightsize * 0.01,
                          ),
                          Row(
                            //높이 : 0.04
                            children: [
                              SizedBox(
                                // color: Colors.amber[50],
                                height: heightsize * 0.04,
                                width: widthsize * 0.25,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    customText(
                                        "키 ",
                                        RelativeSizeClass(context)
                                                    .orientation ==
                                                Orientation.portrait
                                            ? fsizeLarge
                                            : fsizeLarge / 1.5,
                                        "L")
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: heightsize * 0.04,
                                width: widthsize * 0.05,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    customText(
                                      ": ",
                                      RelativeSizeClass(context).orientation ==
                                              Orientation.portrait
                                          ? fsizeLarge
                                          : fsizeLarge / 1.5,
                                      "R",
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                // color: Colors.red[100],
                                height: heightsize * 0.04,
                                width: widthsize * 0.25,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    customText(
                                      "${controller.bmirec!.height.toStringAsFixed(1)} cm",
                                      RelativeSizeClass(context).orientation ==
                                              Orientation.portrait
                                          ? fsizeLarge
                                          : fsizeLarge / 1.5,
                                      "R",
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ), // BMI 몸무게 키 Column 종료
                      SizedBox(
                        width: widthsize * 0.05,
                      ),
                      // 원 그래프 들어있는 컨테이너 시작
                      SizedBox(
                        // color: Colors.pink,
                        width: widthsize * 0.4,
                        height: heightsize * 0.15,
                        child: Center(
                            child: Stack(children: [
                          // BMI 최대치 (720)에 해당하는 원
                          Container(
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.red.withAlpha(40),
                                border:
                                    Border.all(color: Colors.red, width: 3)),
                            width:
                                (min(widthsize * 0.4, heightsize * 0.15)) * 0.9,
                            height:
                                (min(widthsize * 0.4, heightsize * 0.15)) * 0.9,
                            // height: widthsize * 0.9,
                          ),
                          Positioned(
                            child: CustomPaint(
                              size: Size(
                                  (min(widthsize * 0.4, heightsize * 0.15)) *
                                      0.9,
                                  (min(widthsize * 0.4, heightsize * 0.15)) *
                                      0.9),
                              painter: CircleChart(
                                Colors.blue.withAlpha(50),
                                Colors.blue,
                                radius:
                                    ((min(widthsize * 0.4, heightsize * 0.15)) *
                                        0.45 *
                                        (30) /
                                        45),
                              ),
                            ),
                          ),
                          Positioned(
                            child: CustomPaint(
                              size: Size(
                                  (min(widthsize * 0.4, heightsize * 0.15)) *
                                      0.9,
                                  (min(widthsize * 0.4, heightsize * 0.15)) *
                                      0.9),
                              painter: CircleChart(
                                  Colors.purple.withAlpha(50), Colors.purple,
                                  radius: ((min(
                                          widthsize * 0.4, heightsize * 0.15)) *
                                      0.45 *
                                      (18.5) /
                                      45)),
                            ),
                          ),
                          Positioned(
                            child: CustomPaint(
                              size: Size(
                                  (min(widthsize * 0.4, heightsize * 0.15)) *
                                      0.9,
                                  (min(widthsize * 0.4, heightsize * 0.15)) *
                                      0.9),
                              painter: CircleChart(
                                  Colors.green.withAlpha((255 *
                                          (controller.bmirec!.bmi > 45
                                              ? 45
                                              : controller.bmirec!.bmi) /
                                          45)
                                      .round()),
                                  const Color.fromARGB(255, 31, 87, 33),
                                  radius: ((min(
                                          widthsize * 0.4, heightsize * 0.15)) *
                                      0.9 *
                                      0.5 *
                                      (controller.bmirec!.bmi > 45
                                          ? 45
                                          : controller.bmirec!.bmi) /
                                      45)),
                            ),
                          )
                        ])),
                      )
                    ],
                  ), // BMI 몸무게 키 Column 그래프 들어있는 Row
                ), //BMI 몸무게 키 및 그래프 보이는 컨테이너의박스 종료
                // Container(
                //   color: Colors.amber,
                //   width: 20,
                //   height: 10,
                // ),
                const Spacer(),
                SizedBox(
                  // color: Colors.blue,
                  height: heightsize * 0.1,
                  width: widthsize,
                  child: Column(
                    children: [
                      Row(
                        // 높이 : 0.05
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  fixedSize:
                                      Size(widthsize * 0.4, heightsize * 0.06)),
                              onPressed: () {
                                deleteDialog();
                              },
                              child: customText(
                                  "삭제하기", fsizeMiddle, "C",
                                  clr: Colors.red)),
                          SizedBox(
                            width: widthsize * 0.1,
                          ),
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  fixedSize:
                                      Size(widthsize * 0.4, heightsize * 0.06)),
                              onPressed: () {
                                Get.off(const Home());
                              },
                              child: customText(
                                  "확 인", fsizeMiddle, "C",
                                  clr: Colors.blue)),
                        ],
                      ), //버튼 들어있는 row 종료
                    ],
                  ),
                ),
                SizedBox(
                  height: heightsize * 0.01,
                )
              ],
            ),
          );
        }
      }),
    );
  } // end of widget

  doQuery(ResultBMIPageController controller) {
    controller.bringQuery(recordKey);
  } //doQUery 종료

  deleteDialog() {
    Get.defaultDialog(
        title: "기록삭제",
        content: const Text(
            "정말로 기록을 삭제하시겠습니까?\n 지난 날짜의 기록은 기록할 수 없으며,\n삭제된 기록은 복구되지 않습니다. "),
        barrierDismissible: false,
        actions: [
          TextButton(
            onPressed: () {
              deleteQuery(recordKey);
              Get.back();
            },
            child: const Text("삭제"),
          ),
          TextButton(
            onPressed: () {
              Get.back();
            },
            child: const Text("취소"),
          ),
        ]);
  } //end of deleteDialog

  deleteQuery(int seq) async {
    SqliteRepository vm = SqliteRepository();
    bool rs = await vm.deleteRecord(seq);
    if (rs) {
      deleteSuccess();
    } else {
      deleteFail();
    }
    return rs;
  }

  deleteSuccess() async {
    await Get.defaultDialog(
        title: "삭제 완료",
        content: const Text("기록이 정상적으로 삭제되었습니다."),
        barrierDismissible: false,
        actions: [
          TextButton(
            onPressed: () {
              Get.offAll(const Home()); // 다 종료하고 첫화면으로 이동
            },
            child: const Text("확 인"),
          ),
        ]);
    Get.back();
  } //deleteSuccess 종료

  deleteFail() async {
    await Get.defaultDialog(
        title: "삭제 실패",
        content: const Text("기록이 없거나, 삭제할 수 없는 기록입니다."),
        barrierDismissible: false,
        actions: [
          TextButton(
            onPressed: () {
              Get.offAll(const Home()); // 다 종료하고 첫화면으로 이동
            },
            child: const Text("확 인"),
          ),
        ]);
    Get.back();
  } //deleteFail 종료
} //end of class
