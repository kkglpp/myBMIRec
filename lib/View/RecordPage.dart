import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:mybmirecord/View/View_Component/record_cardList.dart';
import 'package:mybmirecord/View/View_Component/record_graph.dart';
import 'package:mybmirecord/ViewModel_Controller/recordpageController.dart';
import 'package:mybmirecord/View/home.dart';
import 'package:mybmirecord/Widget_Custom/CustomWidget.dart';
import 'package:mybmirecord/static/forBannerAd.dart';

import '../static/forRelativeSize.dart';

class RecordPage extends StatelessWidget {
  const RecordPage({super.key});
  // late List<BMIrecord> records = [];

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
        title: customText("My BMI Status ? ", fsizeXLarge, "C"),
      ),
      body: Center(
        child: Column(
          children: [
            /* 
            사용자가 저장한 기록 목록을 보여주는 파트
            사용자가 저장한 사진에 BMI 수치와 날짜를 얹어서 보여준다.
            높이 0.19
             */
            GetX<RecordPageController>(builder: (controller) {
              // print("목록 build");
              if (!controller.loadRec.value) {
                // print("목록 불러오는 중");
                controller.bringRecords();
                return Container(
                  color: const Color.fromARGB(255, 144, 143, 143),
                  width: widthsize,
                  height: (heightsize * 0.19),
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(),
                    ],
                  ),
                );
              } else if(controller.records.isEmpty){
                return Container(
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 202, 202, 202),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  width: widthsize,
                  height: heightsize * 0.19,
                  child: Center(child: customText("기록이 없습니다.\n당신의 오늘을 기록하세요!", fsizeLarge, "C")),
                );
                
              }
              else {
                // print("목록 불러오기 성공");
                return recordCardList(context, controller);
              }
            }),
            // 목록과 하단의 그래프 선택 부분을 나누는 여백을 위한 부분.
            // 너무 넓어지면 좋지 않기에 0.01로 고정값 지정
            // 여기까지 높이 0.2
            SizedBox(
              height: heightsize * 0.01,
            ),
            /*
            파트 2 : 
            내용 : 그래프 종류 선택하는 파트 + 그래프 그려주는 파트
            높이 0.33
            누적 : 0.53
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
                      //파트 2-1 그래프 종류를 선택하는 파트. 높이 0.04
                      builder: (controller) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                                width: widthsize * 0.21,
                                height: heightsize * 0.04,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    customText(
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
                                child: customText("BMI", fsizeSmall, "C")),
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
                                child: customText("키", fsizeSmall, "C")),
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
                                child: customText("몸무게", fsizeSmall, "C")),
                          ],
                        );
                      },
                    ),
                  ),
                  /*
                  파트 2-2
                  그래프를 그리는 파트
                  GetX Controller를 굳이 분리해본 이유
                  -> 혹시 따로 지정하면서 생기는 이슈가 있을까 싶어서.
                  화면 랜더링 등이 중복되는지 확인.                  
                   */


                  GetX<RecordPageController>(
                    builder: (controller) {
                      // print("그래프 build");
                      if (!controller.loadRec.value) {
                        // print("그래프 불러오는 중");
                        // 데이터 불러오는 중에는 로딩화면
                        return Container(
                          color: Colors.grey[300],
                          width: widthsize,
                          height: (heightsize * 0.26),
                          child: const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircularProgressIndicator(),
                            ],
                          ),
                        );
                      } else {
                        // print("그래프 다 불러왔음");
                        // 버튼 선택 상태에 따라 보여주는 그래프 종류를다르게함.
                        // 0 : BMI 수치  1: 키   2 : 몸무게
                        return recordGraph(context, controller);
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
            누적 0.67
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
            ),
            /*
            파트4 :
            높이 0.14
            누적 0.81  + @ (Spacer)x2
            배너 크기는 고정이다. 그래서 틀어질 수 있으니 체크 필요.
            내용 : 배너 광고 페이지
             */
            // 배너광고와 상단 컨텐츠 사이의 여백을 Spacer로 지정. (배너 크기에 유동적으로 반응 하도록)
            const Spacer(),
            // Container(
            SizedBox(
              // color: Colors.purple[100],
              width: widthsize,
              height: heightsize * 0.14,
              child: kReleaseMode
                  ? AdWidget(ad: MkBannerADclass().mkBannerAD(context))
                  : const Center(child: Text("for banner ad")),

              // child: const Text("광고 파트, 높이 : 0.14"),
            ),
            // 배너광고와 하단 컨텐츠 사이의 여백을 Spacer로 지정. (배너 크기에 유동적으로 반응 하도록)
            
            const Spacer(),

            /*
            파트 5 :
            높이 0.15
            누적 :0.96 + @(Spacer) x2
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

                      ),
                      onPressed: () {
                        Get.off(() => const Home());
                      },
                      child: customText("새로 입력하기", fsizeLarge, "c",
                          clr: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
            //하단 여백파트를 Spacer로 지정.
            const Spacer(),
          ],
        ),
      ),
    );
  } // end of widget
} //end  of class
