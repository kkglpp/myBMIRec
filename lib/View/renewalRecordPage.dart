import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:mybmirecord/View/renewalResultbmiPage.dart';
import 'package:mybmirecord/Controller_ViewModel/recordpageController.dart';
import 'package:mybmirecord/Model_Func/sqlite_repository.dart';
import 'package:mybmirecord/View/home.dart';
import 'package:mybmirecord/View_Custom/customLineGraph/graphCard.dart';
import 'package:mybmirecord/View_Custom/gridCard.dart';
import 'package:mybmirecord/View_Custom/textcustom.dart';
import 'package:mybmirecord/static/forBannerAd.dart';

import '../Model_dataModel/bmi_record.dart';
import '../static/forRelativeSize.dart';

class ReRecordPage extends StatelessWidget {
  ReRecordPage({super.key});
  late List<BMIrecord> records = [];
  late double minBMI = 5 ;
  late double maxBMI = 60;
  late double minHeight=0;
  late double maxHeight=180;
  late double minWeight=30;
  late double maxWeight=100;
  @override
  Widget build(BuildContext context) {
    Get.put(RecordPageController());
    double widthsize = RelativeSizeClass(context).widthSize!;
    double heightsize = RelativeSizeClass(context).heightSize!;
    double fsizeSmall = RelativeSizeClass(context).customFontSizeS!;
    double fsizeMiddle = RelativeSizeClass(context).customFontSizeM!;
    double fsizeLarge = RelativeSizeClass(context).customFontSizeL!;
    double fsizeXLarge = RelativeSizeClass(context).customFontSizeXL!;

    return Scaffold(
      appBar: AppBar(
        title: TextCustom().customText("My BMI Status ? ", fsizeXLarge, "C"),
      ),
      body: Center(
        child: Column(
          children: [
            /* 첫번쨰 파트 
            높이 : 0.25
            내가 기록한 목록 보기 
             */
            GetX<RecordPageController>(builder: (controller) {
              if (!controller.loadRec.value) {
                bringRecords();
                return const CircularProgressIndicator();
              } else {
                return Container(
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 144, 143, 143),
                      borderRadius: BorderRadius.circular(10)),
                  width: widthsize,
                  height: (heightsize * 0.19)
                      // .clamp((widthsize * 0.35), heightsize * 0.19)
                      ,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: records.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Get.off(
                              ResultBMIPage(recordKey: records[index].seq!));
                        },
                        child: SizedBox(
                          child: Center(
                            child: GridCard(records[index].imgbyte,
                                    records[index].timestamp)
                                .girdCard(widthsize * 0.35, heightsize * 0.19,
                                    records[index].bmi, 3,
                                    fsize: RelativeSizeClass(context).orientation == Orientation.portrait? fsizeMiddle : fsizeMiddle/1.8),
                          ),
                        ),
                      );
                    },
                  ),
                );
              }
            }),
            SizedBox(
              height: heightsize * 0.01,
            ),
            /*
            파트 2 : 
            높이 0.32
            누적 : 0.57 +1 = 0.58
            내용 : 그래프 보여주는 곳
             */
            Container(
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(10)),
              width: widthsize,
              height: heightsize * 0.33,
              child: Column(
                children: [
                  SizedBox(
                    // color: Colors.purple[200],
                    height: heightsize * 0.05,
                    width: widthsize,
                    child: GetX<RecordPageController>(
                      builder: (controller) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                                width: widthsize * 0.21,
                                height: heightsize * 0.5,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    TextCustom().customText(
                                        controller.graphSelect.value == 0
                                            ? "단위 : "
                                            : controller.graphSelect.value == 1
                                                ? "단위 : cm "
                                                : "단위 : kg",
                                        fsizeMiddle,
                                        "C",
                                        clr: Colors.black)
                                  ],
                                )),
                            const Spacer(),
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        controller.graphSelect.value != 0
                                            ? Colors.amber[100]
                                            : Colors.grey,
                                    minimumSize: Size(
                                        widthsize * 0.23, heightsize * 0.04),
                                    fixedSize: Size(
                                        widthsize * 0.23, heightsize * 0.04)),
                                onPressed: controller.graphSelect.value != 0
                                    ? () {
                                        controller.selectBMIGraph();
                                      }
                                    : null,
                                child: TextCustom()
                                    .customText("BMI", fsizeSmall, "C")),
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        controller.graphSelect.value != 1
                                            ? Colors.blue[100]
                                            : Colors.grey,
                                    minimumSize: Size(
                                        widthsize * 0.23, heightsize * 0.04),
                                    fixedSize: Size(
                                        widthsize * 0.23, heightsize * 0.04)),
                                onPressed: controller.graphSelect.value != 1
                                    ? () {
                                        controller.selectHeightGraph();
                                      }
                                    : null,
                                child: TextCustom()
                                    .customText("키", fsizeSmall, "C")),
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        controller.graphSelect.value != 2
                                            ? Colors.green[100]
                                            : Colors.grey,
                                    minimumSize: Size(
                                        widthsize * 0.23, heightsize * 0.04),
                                    fixedSize: Size(
                                        widthsize * 0.23, heightsize * 0.04)),
                                onPressed: controller.graphSelect.value != 2
                                    ? () {
                                        controller.selectWeightGraph();
                                      }
                                    : null,
                                child: TextCustom()
                                    .customText("몸무게", fsizeSmall, "C")),
                          ],
                        );
                      },
                    ),
                  ),
                  GetX<RecordPageController>(
                    builder: (controller) {
                      if (!controller.loadRec.value) {
                        bringRecords();
                        return const CircularProgressIndicator();
                      } else {
                        return Row(
                          children: [
                            Visibility(
                              visible: controller.graphSelect.value == 0,
                              child: Container(
                                color: Colors.amber.withAlpha(50),
                                width: widthsize,
                                height: heightsize * 0.26,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: records.length,
                                  itemBuilder: (context, index) {
                                    return graphCard().lineGraphCell(
                                        controller.graphSelect.value,
                                        widthsize * 0.2,
                                        heightsize * 0.22, //height 1
                                        minBMI*0.1, //min 그래프 y 축의 최소값
                                        maxBMI*1.1, //max 그래프에서 보여줄 최대값.
                                        index == 0
                                            ? null
                                            : records[index - 1]
                                                .bmi, // 시작값. 직전 측정값
                                        records[index].bmi, // 해당 날짜의 측정 실제 값.
                                        index + 1 < records.length
                                            ? records[index + 1].bmi
                                            : null,
                                        3,
                                        heightsize * 0.03, //height 2  가로축의 값을 입력하는 파트
                                        records[index].timestamp,
                                        heightsize * 0.01, //height 3 그래프와 가로축 사이의 여백
                                        fsizeX: fsizeSmall);
                                  },
                                ),
                              ),
                            ),
                            Visibility(
                              visible: controller.graphSelect.value == 1,
                              child: Container(
                                color: Colors.blue[50],
                                width: widthsize,
                                height: heightsize * 0.26,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: records.length,
                                  itemBuilder: (context, index) {
                                    return graphCard().lineGraphCell(
                                        controller.graphSelect.value,
                                        widthsize * 0.2,
                                        heightsize * 0.22,
                                        minHeight*0.3,
                                        maxHeight*1.1, //max 그래프에서 보여줄 최대값.
                                        index == 0
                                            ? null
                                            : records[index - 1]
                                                .height, // 시작값. 직전 측정값
                                        records[index]
                                            .height, // 해당 날짜의 측정 실제 값.
                                        index + 1 < records.length
                                            ? records[index + 1].height
                                            : null,
                                        3,
                                        heightsize * 0.03,
                                        records[index].timestamp,
                                        heightsize * 0.01,
                                        fsizeX: fsizeSmall);
                                  },
                                ),
                              ),
                            ),
                            Visibility(
                              visible: controller.graphSelect.value == 2,
                              child: Container(
                                color: Colors.green[50],
                                width: widthsize,
                                height: heightsize * 0.26,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: records.length,
                                  itemBuilder: (context, index) {
                                    return graphCard().lineGraphCell(
                                        controller.graphSelect.value,
                                        widthsize * 0.2,
                                        heightsize * 0.22,
                                        minWeight*0.15,
                                        maxWeight*1.2, //max 그래프에서 보여줄 최대값.
                                        index == 0
                                            ? null
                                            : records[index - 1]
                                                .weight, // 시작값. 직전 측정값
                                        records[index]
                                            .weight, // 해당 날짜의 측정 실제 값.
                                        index + 1 < records.length
                                            ? records[index + 1].weight
                                            : null,
                                        3,
                                        heightsize * 0.03,
                                        records[index].timestamp,
                                        heightsize * 0.01,
                                        fsizeX: fsizeSmall);
                                  },
                                ),
                              ),
                            ),
                          ],
                        );
                      }
                    },
                  ),
                  
                ],
              ),
            ),
const Spacer(),
            /*
            파트3 :
            높이 0.14
            누적 0.66
            내용 : BMI 수치 그림 
             */
            // Container(
            SizedBox(
              // color: Colors.red[100],
              width: widthsize,
              height: heightsize * 0.2,
              child: Image.asset(
                "images/BMI_man.jpg",
                fit: BoxFit.contain,
              ),
              // child: const Text("광고 넣을 자리, 높이 : 0.14"),
            ),
            /*
            파트4 :
            높이 0.14
            누적 0.80
            내용 : 배너 광고 페이지
             */
            const Spacer(),
            // Container(
            SizedBox(
              // color: Colors.purple[100],
              width: widthsize,
              height: heightsize * 0.14,
              child: 
              // kReleaseMode? 
              AdWidget(ad: MkBannerADclass().mkBannerAD(context))
              // :const Center(child: Text("for banner Contents"))
              ,
              
              // child: const Text("광고 파트, 높이 : 0.14"),
            ),
            const Spacer(),

            /*
            파트 5 :
            높이 0.15
            누적 :0.95
            내용 : 버튼 
             */
            // Container(
            SizedBox(
              // color: Colors.green[100],
              width: widthsize,
              height: heightsize * 0.12,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        minimumSize: Size(widthsize, heightsize * 0.07),
                        // fixedSize: Size(widthsize * 0.8, heightsize * 0.04)
                      ),
                      onPressed: () {
                        Get.off(() => const Home());
                      },
                      child: TextCustom()
                          .customText("새로 입력하기", fsizeLarge, "c", clr: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  } // end of widget

  bringRecords() async {
    SqliteRepository sql = SqliteRepository();

    // records.addAll(await sql.bringRecord()) ;
    records = await sql.bringRecord();
    if (records.isNotEmpty){
    minBMI = (records.map((record) => record.bmi).toList()).reduce(min);
    maxBMI = (records.map((record) => record.bmi).toList()).reduce(max);
    minWeight = (records.map((record) => record.weight).toList()).reduce(min);
    maxWeight = (records.map((record) => record.weight).toList()).reduce(max);
    minHeight = (records.map((record) => record.height).toList()).reduce(min);
    maxHeight = (records.map((record) => record.height).toList()).reduce(max);
    }






    Get.find<RecordPageController>().loadRec.value = true;
  } //end of bringRecords
} //end  of class
