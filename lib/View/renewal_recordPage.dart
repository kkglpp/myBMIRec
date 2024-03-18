// import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mybmirecord/Controller/recordPage_Controller.dart';
import 'package:mybmirecord/Model/bmi_record.dart';
import 'package:mybmirecord/VM_repository/sqlite_repository.dart';
import 'package:mybmirecord/View/home.dart';
import 'package:mybmirecord/components/graphCard.dart';
import 'package:mybmirecord/components/lineChart.dart';
import 'package:mybmirecord/components/textMiddle.dart';

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
        title: Text("내 몸의 변화과정"),
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              color: Colors.blue[100],
              width: widthsize,
              height: heightsize * 0.26,
              child: GetX<RecordPageController>(builder: (controller) {
                return Column(
                  children: [
                    Text(
                        "${controller.loadRec} 흐르게 만들기. 높이 : 0.26\n클릭하면 각 기록 확인하기. 사진에 날짜 덮어쓰기."),
                    Container(
                        // child: CustomPaint(
                        //   size: Size(widthsize * 0.9, heightsize * 0.1),
                        //   painter: LineChart(),
                        // ),
                        )
                  ],
                );
              }),
            ),
            Container(
              color: Colors.amber[100],
              width: widthsize,
              height: heightsize * 0.3,
              child: Column(
                children: [
                  Container(
                      color: Colors.purple[200],
                      height: heightsize * 0.03,
                      width: widthsize * 0.8,
                      child: Text("그래프 그리는 Container. 높이 : 0.3")),
                  GetX<RecordPageController>(builder: (controller) {
                    if (!controller.loadRec.value) {
                      bringRecords();
                      print("???");
                      return CircularProgressIndicator();
                    } else {
                      print("가져옴?");
                      print(records[0].bmiDouble);
                      return Row(
                        children: [
                          Container(
                            color: Colors.blue[50],
                            width: widthsize,
                            height: heightsize * 0.25,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: records.length,
                              itemBuilder: (context, index) {
                                return graphCard().lineGraphCell(
                                  widthsize*0.2,
                                  heightsize*0.23,
                                  100, //max 그래프에서 보여줄 최대값.
                                  index ==0? null: records[index-1].bmiDouble.clamp(0, 100), // 시작값. 직전 측정값
                                  records[index].bmiDouble.clamp(0, 100), // 해당 날짜의 측정 실제 값.
                                  index+1 < records.length?  records[index+1].bmiDouble.clamp(0, 100) : null,
                                  3,
                                  heightsize*0.02,
                                  records[index].timestamp,
                                );
                                // return Container(
                                //     // color: Colors.grey,
                                //     width: widthsize * 0.2,
                                //     height: heightsize * 0.25,
                                //     // child: Text("${records[index].bmiDouble}")
                                //     child: Column(
                                //       children: [
                                //         CustomPaint(
                                //           size: Size(
                                //               widthsize * 0.1, heightsize * 0.2),
                                //           painter: LineChart(
                                //             heightsize * 0.2,
                                //             widthsize * 0.2,
                                //             100,
                                //             index ==0? null: records[index-1].bmiDouble.clamp(0, 100),
                                //             records[index].bmiDouble.clamp(0, 100),
                                //             3,
                                //           ),
                                //         ),
                                //         Container(
                                //           width: widthsize*0.2,
                                //           height: heightsize*0.05,
                                //           child: TextCustom().customText("${records[index].timestamp}", 7, "L",),
                                //         )
                                //       ],
                                //     ),
                                //     );
                              },
                            ),
                          ),
                        ],
                      );
                    }
                  }),
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
