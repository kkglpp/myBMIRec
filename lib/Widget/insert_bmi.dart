import '../VM/CalcBMI.dart';
import '../View/recordPage.dart';
import '../View/resultPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InsertBMI extends StatefulWidget {
  const InsertBMI({super.key});

  @override
  State<InsertBMI> createState() => _InsrtBMIState();
}

class _InsrtBMIState extends State<InsertBMI> {
  late List<int> height;
  late List<int> weight;
  late double selectedHeight;
  late double selectedWeight;
  late double bmirs; // BMI 수치 저장하는 변수
  late bool rsShow; // BMI 계산전/후를 기억할 변수
  late int bmistatus; // BMI 단계를 저장할 변 수 . 1~5
  late String rs;
  late double maxScreenWidth = MediaQuery.of(context).size.width;
  late double maxScreenHeight = MediaQuery.of(context).size.height;
  late FixedExtentScrollController heightController;
  late FixedExtentScrollController weightController;

  @override
  void initState() {
    super.initState();

    weightController = FixedExtentScrollController(initialItem: 150);
    heightController = FixedExtentScrollController(initialItem: 700);
    height = [];
    weight = [];
    selectedHeight = 170;
    selectedWeight = 60;
    rsShow = false;
    bmirs = CalcBMI().calcbmi(selectedHeight, selectedWeight);
    bmistatus = CalcBMI().classbmi(bmirs)[0];
    rs = CalcBMI().classbmi(bmirs)[1];
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Spacer(),
          Container(
            // color: Colors.grey,s
            color: Theme.of(context).colorScheme.background,
            width: maxScreenWidth * 0.8,
            height: maxScreenHeight * 0.4,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: maxScreenHeight * 0.4 * 0.05,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: maxScreenWidth * 0.8 * 0.5 * 0.8,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '신장',
                            style: TextStyle(
                                fontSize:
                                    (maxScreenWidth * 0.05).clamp(15.0, 24.0),
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: maxScreenWidth * 0.8 * 0.1,
                    ),
                    SizedBox(
                      width: maxScreenWidth * 0.8 * 0.5 * 0.8,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '몸무게',
                            style: TextStyle(
                                fontSize:
                                    (maxScreenWidth * 0.05).clamp(15.0, 24.0),
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),

                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      //start of 키를 입력하는 pickerview 넣는 사이즈 박스
                      width: maxScreenWidth * 0.8 * 0.5 * 0.8,
                      height: maxScreenHeight * 0.4 * 0.8,
                      child: CupertinoPicker(
                          itemExtent: (maxScreenHeight * 0.05).clamp(30, 40),
                          scrollController: heightController,
                          onSelectedItemChanged: (value) {
                            selectedHeight = (value.toDouble() / 10) + 100;
                            //setState(() {                      });
                            bmirs = CalcBMI()
                                .calcbmi(selectedHeight, selectedWeight);
                            bmistatus = CalcBMI().classbmi(bmirs)[0];
                            rs = CalcBMI().classbmi(bmirs)[1];
                            setState(() {});
                          },
                          children: List.generate(
                            1001,
                            (index) => Center(
                              child: Text("${(index.toDouble() / 10) + 100}"),
                            ),
                          )),
                    ), //end of 키를 입력하는 pickerview 넣는 사이즈 박스
                    SizedBox(
                      width: maxScreenWidth * 0.8 * 0.1,
                    ),
                    SizedBox(
                      // start of 몸무게 입력하는 피커뷰넣는 사이즈 박스
                      width: maxScreenWidth * 0.8 * 0.5 * 0.8,
                      height: maxScreenHeight * 0.4 * 0.8,
                      child: CupertinoPicker(
                          itemExtent: (maxScreenHeight * 0.05)
                              .clamp(25, 40), // 아이템의 높이/넓이
                          scrollController: weightController, //60번째 값이 초기값이다.
                          onSelectedItemChanged: (value) {
                            selectedWeight = (value.toDouble() / 10) + 45;
                            //setState(() {                      });
                            bmirs = CalcBMI()
                                .calcbmi(selectedHeight, selectedWeight);
                            bmistatus = CalcBMI().classbmi(bmirs)[0];
                            rs = CalcBMI().classbmi(bmirs)[1];
                            setState(() {});
                          },
                          children: List.generate(
                            600,
                            (index) => Center(
                              child: Text("${(index.toDouble() / 10) + 45}"),
                            ),
                          )),
                    ) // End of 몸무게 입력하는 피커뷰 넣는 사이즈 박스
                  ],
                ),
              ],
            ),
          ),
          const Spacer(),
          Container(
            // color: Theme.of(context).colorScheme.background,
            // color: Colors.amber,
            width: maxScreenWidth * 0.8,
            height: maxScreenHeight * 0.2,
            decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.background,
                border: Border.all(
                  color: Theme.of(context).colorScheme.onBackground,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(12)),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(
                      15, (maxScreenHeight * 0.2 * 0.1).clamp(10, 20), 0, 0),
                  child: Row(
                    children: [
                      SizedBox(
                        width: maxScreenWidth * 0.8 * 0.4,
                        child: Text(
                          "BMI : ${bmirs.toStringAsFixed(1)}",
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onBackground,
                            fontSize: (maxScreenWidth * 0.1).clamp(13.0, 24.0),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      SizedBox(
                        width: maxScreenWidth * 0.8 * 0.4,
                        child: Text(
                          rs.toString(),
                          style: TextStyle(
                            fontSize: (maxScreenWidth * 0.1).clamp(13.0, 24.0),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(
                      15, (maxScreenHeight * 0.2 * 0.2).clamp(15, 40), 0, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: List.generate(
                      bmistatus + 1,
                      (index) {
                        return Container(
                          height: maxScreenHeight * 0.2 * 0.3,
                          width: maxScreenWidth * 0.8 * 0.15,
                          // color: Color.fromARGB(index * 40 + 55, 255, 0, 0),
                          color: Theme.of(context)
                              .colorScheme
                              .error
                              .withOpacity((index * 40 + 55) / 255),
                        );
                      },
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: maxScreenHeight * 0.05,
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: maxScreenWidth * 0.8,
                height: maxScreenHeight * 0.1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            minimumSize: Size(maxScreenWidth * 0.8 * 0.5 * 0.9,
                                maxScreenHeight * 0.1 * 0.8),
                            backgroundColor: Colors.blue,
                            foregroundColor:
                                Theme.of(context).colorScheme.onPrimary),
                        onPressed: () {
                          Get.to(ResultPage(
                            nowShow: true,
                            bmiDouble: bmirs,
                            bmiString: rs,
                            bmistatus: bmistatus,
                          ))?.then((value) {
                          heightController.jumpToItem(700);
                          weightController.jumpToItem(150);
                        });
                        },
                        child: Text(
                          "오늘의 기록 \n저장하기 ",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: (maxScreenWidth*0.04).clamp(15, 30),
                            fontWeight: FontWeight.bold,
                          ),
                        )),
                    SizedBox(
                      width: maxScreenWidth * 0.8 * 0.5 * 0.2,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          minimumSize: Size(maxScreenWidth * 0.8 * 0.5 * 0.9,
                              maxScreenHeight * 0.1 * 0.8),
                          backgroundColor: Theme.of(context).colorScheme.error,
                          foregroundColor:
                              Theme.of(context).colorScheme.onError),
                      onPressed: () {
                        Get.to(const RecordPage(nowShow: false))?.then((value) {
                          heightController.jumpToItem(700);
                          weightController.jumpToItem(150);
                        });
                      },
                      child: Text(
                        "내몸의 변화 \n확인하기",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: (maxScreenWidth*0.04).clamp(15, 30), fontWeight: FontWeight.bold,),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: (maxScreenHeight * 0.05).clamp(40, 70),
          ),
        ],
      ),
    );
  }
  //
  // --- Function ---
}//end
