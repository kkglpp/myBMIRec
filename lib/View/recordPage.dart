
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mybmirecord/Model/bmi_record.dart';
import 'package:mybmirecord/datahandler/calcBMI.dart';
import 'package:mybmirecord/datahandler/database_handler.dart';
import 'package:mybmirecord/rulerBar.dart';

class RecordPage extends StatefulWidget {
  final bool nowShow;
  const RecordPage({super.key, required this.nowShow});

  @override
  State<RecordPage> createState() => _RecordPageState();
}

class _RecordPageState extends State<RecordPage> {
  late bool picked;
  late double bmirs; // BMI 수치 저장하는 변수
  late int bmistatus; // BMI 단계를 저장할 변 수 . 1~5
  late String rs;
  late String rsdate;
  late double barwidth;
  late DatabaseHandler handler;
  late List<String> advices;
  late double maxScreenWidth ;
  late double maxScreenHeight ;

  @override
  void initState() {
    super.initState();
    picked = false;
    handler = DatabaseHandler();
    handler.initializeDB(); //db 연결
    reloadData();
    barwidth = 40;
    bmirs = 22.9;
    bmistatus = 1;
    rsdate = "";
    rs = "";
    advices = [
      "근육이 붙어야 살도 붙습니다. \n음식을 충분히 먹고, 웨이트 트레이닝을 하세요!",
      "매우 건강한 지표를 보이고 있습니다. \n꾸준한 운동과 적절한 영양공급! 잊지마세요.",
      "체중이 불어나고 있어요!! \n방심하면 비만으로 넘어갑니다. 위기에요!",
      "비만에 돌입했어요. \n내일 말고 지금 이순간 부터 운동 해볼까요?",
      "다이어트는 최고의 성형입니다. \n당신의 아름다움을 속살에 너무 숨기지 마세요!",
      "맙소사...늦었다 싶을때가 진짜 늦은 때에요! \n사랑하는 사람들을 위해 체중을 줄여봐요."
    ];
  }
  setSize(){
    maxScreenWidth = MediaQuery.of(context).size.width;
    maxScreenHeight = MediaQuery.of(context).size.height;
  }
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("내 BMI 기록지"),
      ),
      body: OrientationBuilder(builder: (context,orientation) {
            setSize();
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // SizedBox(
              //   height: maxScreenHeight * 0.05,
              // ),
              const Spacer(),
              /* 그래프를 그리는 파트 */
              Container(
                width: maxScreenWidth * 0.9,
                height: maxScreenHeight * 0.8 * 0.5,
                // color: Colors.cyan,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
                ),
          
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: (maxScreenWidth * 0.9 * 0.05).clamp(10, 20),
                    ),
                    //기준이 되는 Y축을 그라데이션 들어간 그래프로 표시하였음.
                    //width 0.9 * 0.2
                    SizedBox(
                      height: maxScreenHeight * 0.8 * 0.45 + 40,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          RulerBar(
                              maxScreenWidth: maxScreenWidth,
                              maxScreenHeight: maxScreenHeight),
                          const SizedBox(
                            height: 30,
                          ),
                        ],
                      ),
                    ),
          
                    SizedBox(
                      width: (maxScreenWidth * 0.9 * 0.05).clamp(10, 20),
                    ),
                    Container(
                      width: maxScreenWidth * 0.9 * 0.70,
                      height: maxScreenHeight * 0.8 * 0.45 + 40,
                      color: Theme.of(context)
                          .colorScheme
                          .background
                          .withOpacity(0),
                      child: FutureBuilder(
                          future: handler.queryRecord(),
                          builder: (BuildContext context,
                              AsyncSnapshot<List<BMIrecord>> snapshot) {
                            if (snapshot.hasData) {
                              return ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: snapshot.data?.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(2, 0, 2, 0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          SizedBox(
                                            width: barwidth,
                                            child: ownText(
                                                snapshot.data![index].bmiDouble
                                                    .toStringAsFixed(1),
                                                11),
                                          ),
                                          SizedBox(
                                            width: barwidth,
                                            height:
                                                (maxScreenHeight * 0.8 * 0.45) *
                                                    ((snapshot.data![index]
                                                                .bmiDouble -
                                                            13) /
                                                        28).clamp(0, (maxScreenHeight * 0.8 * 0.45)*0.8),
                                            child: GestureDetector(
                                                onLongPress: () {
                                                  deleteAction(
                                                      snapshot.data![index]);
                                                  setState(() {});
                                                },
                                                onTap: () {
                                                  selectRow(
                                                      snapshot.data![index]);
                                                },
                                                child: graphBar(snapshot
                                                    .data![index].bmiDouble)),
                                          ),
                                          Container(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary
                                                .withOpacity(0),
                                            width: barwidth,
                                            height: 30,
                                            child: Center(
                                              child: Text(
                                                snapshot.data![index].timestamp
                                                    .substring(snapshot
                                                            .data![index]
                                                            .timestamp
                                                            .length -
                                                        7),
                                                textAlign: TextAlign.center,
                                                style: const TextStyle(
                                                    fontSize: 9,
                                                    color: Colors.black),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    );
                                  });
                            } else {
                              return const Text("데이터가 없습니다.");
                            }
                          }),
                    ),
                    SizedBox(
                      width: (maxScreenWidth * 0.9 * 0.05).clamp(10, 20),
                    ),
                  ],
                ),
              ),
              const Spacer(),//-------------------------------------------------------------------
              /* 건강 관리를 위한 제안을 넣는 파트 */
              Container(
                width: maxScreenWidth * 0.9,
                height: maxScreenHeight * 0.25,
                color: Theme.of(context).colorScheme.background,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          color: Theme.of(context).colorScheme.background,
                          width: maxScreenWidth * 0.9 * 0.4,
                          height: maxScreenHeight * 0.25 * 0.9,
                          child: Image.asset(
                            "images/${bmistatus.toString()}.jpeg",
                            fit: BoxFit.fitHeight,
                          ),
                        ),
                        SizedBox(
                          width: maxScreenWidth * 0.9 * 0.05,
                        ),
                        Container(
                          // color: Theme.of(context)
                          //     .colorScheme
                          //     .primary
                          //     .withOpacity(0.8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: selectColor(bmirs).withOpacity(0.7),
                          ),
          
                          width: maxScreenWidth * 0.9 * 0.55,
                          height: maxScreenHeight * 0.25 * 0.9,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(0, 10, 0, 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "BMI 수치",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onPrimary),
                                    ),
                                  ],
                                ),
                              ),
                                                            const Spacer(),
          
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  const Spacer(),
                                  Text(
                                    picked ? bmirs.toStringAsFixed(2) : "",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: (maxScreenHeight*0.02).clamp(18, 40),
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onPrimary),
                                  ),
                                  const Spacer(),
                                  Text(
                                    picked ? rs : "",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: (maxScreenHeight*0.02).clamp(18, 40),
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onPrimary),
                                  ),
                                  const Spacer(),
                                ],
                              ),
                              const Spacer(),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 0, 10, 5),
                                    child: Text(
                                      picked ? rsdate : "",
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onPrimary),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              const Spacer(),
          
              SizedBox(
                  height: maxScreenHeight * 0.25 * 0.25,
                  child: Center(
                    child: Text(
                      picked ? advices[bmistatus] : "",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: (maxScreenWidth * 0.02).clamp(15, 25),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )),
          
              const Spacer(),
              /* Button 을 넣기 위한 sizedBox*/
              SizedBox(
                width: maxScreenWidth * 0.9,
                height: maxScreenHeight * 0.05,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    /* _____________________ 저장하기 Button _____________________*/
          
                    /* _____________________ 취소하기 Button _____________________*/
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(context)
                              .colorScheme
                              .primary
                              .withOpacity(0.8),
                          foregroundColor:
                              Theme.of(context).colorScheme.onPrimary,
                          minimumSize: Size(
                              maxScreenWidth * 0.9, maxScreenHeight * 0.05)),
                      // style: ButtonStyle(
                      //   backgroundColor: MaterialStateProperty.all<Color>(Theme.of(context).colorScheme.primary.withOpacity(0.2))
          
                      // ),
                      onPressed: () {
                        Get.back();
                      },
                      child: Text(
                        "뒤로가기",
                        style: TextStyle(
                            fontSize: (maxScreenHeight * 0.02).clamp(15, 25),
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
          
              SizedBox(
                height: (maxScreenHeight * 0.05).clamp(20, 80),
              ),
            ],
          ),
        );
      }),
    );
  }

  selectColor(double bmi) {
    Color barColor = const Color.fromARGB(255, 139, 0, 0);
    // Color barColor = const Color.fromARGB(255, 75, 0, 130);
    // Color barColor = const Color.fromARGB(255, 139, 0, 0);
    if (bmi > 18.5) {
      // barColor = const Color.fromARGB(255, 0, 255, 0);
      // barColor = const Color.fromARGB(255, 64, 224, 208);
      barColor = const Color.fromARGB(255, 0, 150, 80);
    }
    if (bmi > 22.9) {
      barColor = const Color.fromARGB(255, 255, 165, 0);
      // barColor = const Color.fromARGB(255, 255, 127, 80);
      // barColor = const Color.fromARGB(255, 255, 255, 102);
    }
    if (bmi > 25) {
      barColor = const Color.fromARGB(255, 255, 140, 0);
      // barColor = const Color.fromARGB(255, 233, 150, 122);
      // barColor = const Color.fromARGB(255, 255, 165, 0);
    }
    if (bmi > 30) {
      barColor = const Color.fromARGB(255, 139, 0, 0);
      // barColor = const Color.fromARGB(255, 205, 92, 92);
      // barColor = const Color.fromARGB(255, 255, 102, 102);
    }
    if (bmi > 34.9) {
      barColor = const Color.fromARGB(255, 101, 67, 33);
      // barColor = const Color.fromARGB(255, 160, 82, 45);
      // barColor = const Color.fromARGB(255, 130, 130, 130);
    }
    return barColor;
  }

  Widget graphBar(
    double bmi,
  ) {
    Color barColor = selectColor(bmi);

    return Container(
      color: barColor,
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.start,
      ),
    );
  }

  //Widget
  Widget ownText(String con, double fsize) {
    return Text(
      con,
      style: TextStyle(
        color: Theme.of(context).colorScheme.primary,
        fontSize: fsize,
        fontWeight: FontWeight.bold,
      ),
      textAlign: TextAlign.center,
    );
  }

//ontap action
  selectRow(BMIrecord bmi) {
    // CalcBMI calc = CalcBMI();
    // bmirs = snapshot
    //     .data![index].bmiDouble;
    // bmistatus = calc.classbmi(
    //     snapshot.data![index]
    //         .bmiDouble)[0];
    // rsdate = snapshot
    //     .data![index].timestamp;
    // rs = calc.classbmi(snapshot
    //     .data![index]
    //     .bmiDouble)[1];
    // picked = true;
    // setState(() {});
    CalcBMI calc = CalcBMI();
    bmirs = bmi.bmiDouble;
    bmistatus = calc.classbmi(bmi.bmiDouble)[0];
    rsdate = bmi.timestamp;
    rs = calc.classbmi(bmi.bmiDouble)[1];
    picked = true;
    setState(() {});
  }

//DB 쓰는 Function
// 삭제하는 기ㅇ
  deleteAction(BMIrecord bmi) {
    Get.defaultDialog(
        title: "삭제 하시겠습니까?",
        middleText: "삭제된 기록은 복구 될 수 없습니다.\n정말로 삭제 하시겠습니까?",
        actions: [

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                  onPressed: () {
                    deletedrow(bmi);
                  },
                  child: const Text(
                    "삭 제",
                    style: TextStyle(fontSize: 25, color: Colors.blue),
                  )),
                  const SizedBox(width: 30,),
              
              TextButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: const Text(
                    "취 소",
                    style: TextStyle(fontSize: 25, color: Colors.red),
                  )),
            ],
          ),

        ]);
  }

  deletedrow(BMIrecord bmi) {
    handler.deleteRecord(bmi);
    Get.back();
    reloadData();
  }

  reloadData() {
    handler.queryRecord();
    setState(() {});
  }
} //end
