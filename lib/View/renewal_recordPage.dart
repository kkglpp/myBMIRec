// import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mybmirecord/Controller/recordPage_Controller.dart';
import 'package:mybmirecord/Custom/gridCard.dart';
import 'package:mybmirecord/Model/bmi_record.dart';
import 'package:mybmirecord/VM_repository/sqlite_repository.dart';
import 'package:mybmirecord/View/home.dart';
import 'package:mybmirecord/Custom/graphCard.dart';
import 'package:mybmirecord/Custom/lineChart.dart';
import 'package:mybmirecord/Custom/textMiddle.dart';

class ReRecordPage extends StatelessWidget {
  ReRecordPage({super.key});
  late List<BMIrecord> records = [];
  @override
  Widget build(BuildContext context) {
    Get.put(RecordPageController());
    double widthsize = 350;
    double heightsize = 700;
    var radiobtnStatus;

    return Scaffold(
      appBar: AppBar(
        title: Text("내 몸의 변화과정"),
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              color: Colors.blue[100],
              width: widthsize,
              height: heightsize * 0.24,
              child: GetX<RecordPageController>(builder: (controller) {
                return Column(
                  children: [
                    Container(
                      width: widthsize,
                      height: heightsize*0.02,
                      child: TextCustom().customText( 
                          "${controller.loadRec} 흐르게 만들기. 높이 : 0.24\n클릭하면 각 기록 확인하기. 사진에 날짜 덮어쓰기.",8,"L"),
                    ),
      
                    GetX<RecordPageController>(
                      builder: (controller) {
                                            if (!controller.loadRec.value) {
                      return CircularProgressIndicator();
                    } else {
                        return Container(
                          width: widthsize,
                          height: heightsize*0.2,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: records.length,
                            itemBuilder: (context, index) {
                              return GridCard(records[index].imgbyte, records[index].timestamp).girdCard(widthsize*0.3,widthsize*0.3,records[index].bmiDouble,3);
                                
                                
                              
                              
                            },
                            
                            ),
                            );
                      }
                      }
                    ),

                  SizedBox(
                    height: heightsize*0.02,
                  )                        
                  ],
                );
              }),
            ),
            Container(
              color: Colors.amber[100],
              width: widthsize,
              height: heightsize * 0.32,
              child: Column(
                children: [
                  Container(
                      // color: Colors.purple[200],
                      height: heightsize * 0.05,
                      width: widthsize,
                      child: GetX<RecordPageController>(builder: (controller) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text("높이 : 0.09 ${controller.graphSelect}"),
                            const Spacer(),
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: controller.graphSelect.value !=0 ? Colors.green[50] : Colors.grey,

                                    minimumSize: Size(
                                        widthsize * 0.2, heightsize * 0.04),
                                    fixedSize: Size(
                                        widthsize * 0.2, heightsize * 0.04)),
                                onPressed: controller.graphSelect.value !=0 ? () {
                                  controller.selectBMIGraph();
                                }: null,
                                child: TextCustom().customText("BMI", 8, "C")),

                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: controller.graphSelect.value !=1 ? Colors.green[50] : Colors.grey,

                                    minimumSize: Size(
                                        widthsize * 0.2, heightsize * 0.04),
                                    fixedSize: Size(
                                        widthsize * 0.2, heightsize * 0.04)),
                                onPressed: controller.graphSelect.value !=1 ? () {
                                  controller.selectHeightGraph();
                                }:null,
                                child: TextCustom().customText("키", 8, "C")),
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: controller.graphSelect.value !=2 ? Colors.green[50] : Colors.grey,

                                    minimumSize: Size(
                                        widthsize * 0.2, heightsize * 0.04),
                                    fixedSize: Size(
                                        widthsize * 0.2, heightsize * 0.04)),
                                onPressed:controller.graphSelect.value !=2 ?  () {
                                  controller.selectWeightGraph();
                                }:null,
                                child: TextCustom().customText("몸무게", 8, "C")),
                          ],
                        );
                      },),),
                  GetX<RecordPageController>(builder: (controller) {
                    if (!controller.loadRec.value) {
                      bringRecords();
                      return CircularProgressIndicator();
                    } else {
                      return Row(
                        children: [
                          Visibility(
                            visible: controller.graphSelect.value ==0,
                            child: Container(
                              color: Colors.grey.withAlpha(50),
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
                                                .bmiDouble, // 시작값. 직전 측정값
                                        records[index]
                                            .bmiDouble, // 해당 날짜의 측정 실제 값.
                                        index + 1 < records.length
                                            ? records[index + 1].bmiDouble
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
                            visible: controller.graphSelect.value ==1,
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
                                                .heightDouble, // 시작값. 직전 측정값
                                        records[index]
                                            .heightDouble, // 해당 날짜의 측정 실제 값.
                                        index + 1 < records.length
                                            ? records[index + 1].heightDouble
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
                            visible: controller.graphSelect.value ==2,
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
                                        180, //max 그래프에서 보여줄 최대값.
                                        index == 0
                                            ? null
                                            : records[index - 1]
                                                .weightDouble, // 시작값. 직전 측정값
                                        records[index]
                                            .weightDouble, // 해당 날짜의 측정 실제 값.
                                        index + 1 < records.length
                                            ? records[index + 1].weightDouble
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
                        ],
                      );
                    }
                  },
                  ),
                  SizedBox(
                    height: heightsize*0.02,
                  )
                ],
              ),
            ),
            Container(
              color: Colors.red[100],
              width: widthsize,
              height: heightsize * 0.14,
              child: Text("광고 넣을 자리, 높이 : 0.14"),
            ),
            Container(
              color: Colors.purple[100],
              width: widthsize,
              height: heightsize * 0.15,
              child: Text("남는 파트, 높이 : 0.15"),
            ),

            /*
            버튼 놓는 박스 : 높이 0.15
             */
            Container(
              color: Colors.green[100],
              width: widthsize,
              height: heightsize * 0.15,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(widthsize * 0.8, heightsize * 0.05),
                      // fixedSize: Size(widthsize * 0.8, heightsize * 0.04)
                    ),
                    onPressed: () {},
                    child: TextCustom()
                        .customText("목록만 보기", 12, "c", clr: Colors.blue),
                  ),
                  Container(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(widthsize * 0.8, heightsize * 0.05),
                        // fixedSize: Size(widthsize * 0.8, heightsize * 0.04)
                      ),
                      onPressed: () {
                        Get.off(() => Home());
                      },
                      child: TextCustom()
                          .customText("돌아가기", 12, "c", clr: Colors.red),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  } // end of widget

  bringRecords() async {
    SqliteRepository sql = SqliteRepository();
    print("뷰 에서보기");
    // records.addAll(await sql.bringRecord()) ;
    records = await sql.bringRecord();
    print("리스트 가져옴");
    Get.find<RecordPageController>().loadRec.value = true;
    print("컨트롤러 조정");
  } //end of bringRecords
} //end  of class
