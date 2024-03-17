import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mybmirecord/Controller/recordPage_Controller.dart';
import 'package:mybmirecord/Model/bmi_record.dart';
import 'package:mybmirecord/VM_repository/sqlite_repository.dart';
import 'package:mybmirecord/components/lineChart.dart';
import 'package:mybmirecord/components/textMiddle.dart';
import 'dart:ui' as ui;

class ReRecordPage extends StatelessWidget {
  ReRecordPage({super.key});
  late List<BMIrecord> records =[];
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
              child: GetBuilder(
                builder: (controller) {
                  return Column(
                    children: [
                      Text("사진 흐르게 만들기. 높이 : 0.26\n클릭하면 각 기록 확인하기. 사진에 날짜 덮어쓰기."),
                      Container(
                          // child: CustomPaint(
                          //   size: Size(widthsize * 0.9, heightsize * 0.1),
                          //   painter: LineChart(),
                          // ),
                          )
                    ],
                  );
                }
              ),
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
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: GetX<RecordPageController>(
                      builder: (controller) {
                        if(!controller.loadRec.value)
                        {
                          records=bringRecords();
                        return CircularProgressIndicator();
                        }
                        else{
                        
                        return Row(
                          children: [
                            Container(
                              width: widthsize * 0.05,
                            ),
                            ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: records.length,
                              itemBuilder: (context, index) {
                                return                               Container(
                                color: Colors.grey,
                                width: widthsize * 0.1,
                                height: heightsize * 0.22,
                                child: CustomPaint(
                                  size: ui.Size(widthsize * 0.9, heightsize * 0.2),
                                  painter: LineChart(
                                    heightsize * 0.2,
                                    widthsize * 0.1,
                                    100,
                                    index==0? null : records[index-1].bmiDouble,
                                    records[index].bmiDouble,
                                    3,
                                  ),
                                ),
                              );
                              },),

                          ],
                        );}
                      }
                    ),
                  ),
                  Container(
                    color: Colors.brown[200],
                    width: widthsize,
                    height: heightsize * 0.05,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          for (int i = 0; i <= 10; i++)
                            Container(
                              width: widthsize * 0.1,
                              height: heightsize * 0.03,
                              child: Center(child: Text("${i * i}")),
                            )
                        ],
                      ),
                    ),
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
                        minimumSize: ui.Size(widthsize * 0.8, heightsize * 0.05),
                        // fixedSize: Size(widthsize * 0.8, heightsize * 0.04)
                        ),
                    onPressed: () {},
                    child: TextCustom().customText("목록만 보기", 12, "c",clr: Colors.blue),
                  ),
                  Container(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          minimumSize: ui.Size(widthsize * 0.8, heightsize * 0.05),
                          // fixedSize: Size(widthsize * 0.8, heightsize * 0.04)
                          ),
                      onPressed: () {},
                      child: TextCustom().customText("돌아가기", 12, "c",clr: Colors.red),
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
  records.addAll(await sql.bringRecord()) ;
  print("리스트 가져옴");
  Get.find<RecordPageController>().loadRec.value = true;
  print("컨트롤러 조정");

}//end of bringRecords
} //end  of class
