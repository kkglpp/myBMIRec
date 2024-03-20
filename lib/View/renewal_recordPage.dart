// import 'dart:ffi';

// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:mybmirecord/Controller/recordpage_controller.dart';
import 'package:mybmirecord/Custom/gridCard.dart';
import 'package:mybmirecord/VM_repository/sqlite_repository.dart';
import 'package:mybmirecord/View/home.dart';
import 'package:mybmirecord/Custom/customLineGraph/graphCard.dart';
import 'package:mybmirecord/Custom/textMiddle.dart';
import 'package:mybmirecord/View/renewal_resultbmipage.dart';
import 'package:mybmirecord/static/forBannerAd.dart';

import '../Model/bmi_record.dart';

class ReRecordPage extends StatelessWidget {
  ReRecordPage({super.key});
  late List<BMIrecord> records = [];
  @override
  Widget build(BuildContext context) {
    Get.put(RecordPageController());
    double widthsize = 350;
    double heightsize = 700;

    return Scaffold(
      appBar: AppBar(
        title: const Text("내 BMI 기록"),
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
                      color: Colors.black.withAlpha(50),
                      borderRadius: BorderRadius.circular(10)),
                  width: widthsize,
                  height: (heightsize * 0.19)
                      .clamp(widthsize * 0.35, heightsize * 0.19),
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: records.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Get.off(ResultBMIPage(recordKey: records[index].seq!));

                        },
                        child: SizedBox(
                          child: Center(
                            child: GridCard(records[index].imgbyte,
                                    records[index].timestamp)
                                .girdCard(widthsize * 0.35, widthsize * 0.35,
                                    records[index].bmi, 3),
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
              height: heightsize * 0.32,
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
                              width: widthsize*0.2,
                              height: heightsize*0.5,
                              child:Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [TextCustom().customText(controller.graphSelect.value == 0? "" : controller.graphSelect.value ==1? "단위 : cm " :"단위 : kg", 11, "C",clr: Colors.black)],
                              )
                              
                              
                            ),
                            
                            const Spacer(),
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        controller.graphSelect.value != 0
                                            ? Colors.amber[100]
                                            : Colors.grey,
                                    minimumSize: Size(
                                        widthsize * 0.2, heightsize * 0.04),
                                    fixedSize: Size(
                                        widthsize * 0.2, heightsize * 0.04)),
                                onPressed: controller.graphSelect.value != 0
                                    ? () {
                                        controller.selectBMIGraph();
                                      }
                                    : null,
                                child: TextCustom().customText("BMI", 8, "C")),
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        controller.graphSelect.value != 1
                                            ? Colors.blue[100]
                                            : Colors.grey,
                                    minimumSize: Size(
                                        widthsize * 0.2, heightsize * 0.04),
                                    fixedSize: Size(
                                        widthsize * 0.2, heightsize * 0.04)),
                                onPressed: controller.graphSelect.value != 1
                                    ? () {
                                        controller.selectHeightGraph();
                                      }
                                    : null,
                                child: TextCustom().customText("키", 8, "C")),
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        controller.graphSelect.value != 2
                                            ? Colors.green[100]
                                            : Colors.grey,
                                    minimumSize: Size(
                                        widthsize * 0.2, heightsize * 0.04),
                                    fixedSize: Size(
                                        widthsize * 0.2, heightsize * 0.04)),
                                onPressed: controller.graphSelect.value != 2
                                    ? () {
                                        controller.selectWeightGraph();
                                      }
                                    : null,
                                child: TextCustom().customText("몸무게", 8, "C")),
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
                                height: heightsize * 0.25,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: records.length,
                                  itemBuilder: (context, index) {
                                    return graphCard().lineGraphCell(
                                      controller.graphSelect.value,
                                      widthsize * 0.2,
                                      heightsize * 0.22,
                                      100, //max 그래프에서 보여줄 최대값.
                                      index == 0
                                          ? null
                                          : records[index - 1]
                                              .bmi, // 시작값. 직전 측정값
                                      records[index]
                                          .bmi, // 해당 날짜의 측정 실제 값.
                                      index + 1 < records.length
                                          ? records[index + 1].bmi
                                          : null,
                                      3,
                                      heightsize * 0.02,
                                      records[index].timestamp,
                                      heightsize * 0.01,
                                      
                                    );
                                  },
                                ),
                              ),
                            ),
                            Visibility(
                              visible: controller.graphSelect.value == 1,
                              child: Container(
                                color: Colors.blue[50],
                                width: widthsize,
                                height: heightsize * 0.25,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: records.length,
                                  itemBuilder: (context, index) {
                                    return graphCard().lineGraphCell(
                                      controller.graphSelect.value,
                                      widthsize * 0.2,
                                      heightsize * 0.22,
                                      250, //max 그래프에서 보여줄 최대값.
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
                                      heightsize * 0.02,
                                      records[index].timestamp,
                                      heightsize * 0.01,
                                      
                                    );
                                  },
                                ),
                              ),
                            ),
                            Visibility(
                              visible: controller.graphSelect.value == 2,
                              child: Container(
                                color: Colors.green[50],
                                width: widthsize,
                                height: heightsize * 0.25,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: records.length,
                                  itemBuilder: (context, index) {
                                    return graphCard().lineGraphCell(
                                      controller.graphSelect.value,
                                      widthsize * 0.2,
                                      heightsize * 0.22,
                                      180, //max 그래프에서 보여줄 최대값.
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
                                      heightsize * 0.02,
                                      records[index].timestamp,
                                      heightsize * 0.01
                                      
                                    );
                                  },
                                ),
                              ),
                            ),
                          ],
                        );
                      }
                    },
                  ),
                  SizedBox(
                    height: heightsize * 0.02,
                  )
                ],
              ),
            ),

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
              child: Image.asset("images/BMI_man.jpg",
              fit: BoxFit.contain,),
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
              child: AdWidget(ad: MkBannerADclass().mkBannerAD(context)),
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
                        minimumSize: Size(widthsize , heightsize * 0.07),
                        // fixedSize: Size(widthsize * 0.8, heightsize * 0.04)
                      ),
                      onPressed: () {
                        Get.off(() => const Home());
                      },
                      child: TextCustom()
                          .customText("돌아 가기", 16, "c", clr: Colors.white),
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

    Get.find<RecordPageController>().loadRec.value = true;

  } //end of bringRecords
} //end  of class
