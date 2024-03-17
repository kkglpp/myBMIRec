
import 'package:flutter/material.dart';
import 'package:mybmirecord/Model/bmi_record.dart';
import 'package:mybmirecord/datahandler/database_handler.dart';
import 'package:mybmirecord/rulerBar.dart';

class OwnChart extends StatefulWidget {
  final bool nowShow;
  final double bmiDouble;
  final String bmiString;

  const OwnChart(
      {super.key,
      required this.nowShow,
      required this.bmiDouble,
      required this.bmiString});

  @override
  State<OwnChart> createState() => _OwnChartState();
}

class _OwnChartState extends State<OwnChart> {
  late double maxScreenWidth ;
  late double maxScreenHeight ;
  late List<BMIrecord> data = [];
  late bool nowShow;
  late double bmiDouble;
  late String bmiString;
  late int nowYear;
  late int nowMonth;
  late int nowday;
  late double barwidth;
  DatabaseHandler handler = DatabaseHandler();

  @override
  void initState() {
    super.initState();
    bmiDouble = widget.bmiDouble;
    bmiString = widget.bmiString;
    nowShow = widget.nowShow;
    nowYear = DateTime.now().year;
    nowday = DateTime.now().day;
    nowMonth = DateTime.now().month;
    nowShow
        ? data.add(
            BMIrecord(bmiDouble: 120, timestamp: DateTime.now().toString()))
        : dataInit();

    barwidth = 80;
  }

  dataInit() {
    handler.initializeDB(); //DB시작.
    // DateTime now = DateTime.now();
    handler.queryRecord();
  }

  reloadData() {
    handler.queryRecord();
    setState(() {});
  }
  setSize(){
    maxScreenWidth = MediaQuery.of(context).size.width;
    maxScreenHeight = MediaQuery.of(context).size.height;
  }

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation){
        setSize();
      return Center(
        child: Container(
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
                color: Theme.of(context).colorScheme.background.withOpacity(0),
                child: Row(
                        // BMI 날짜별로 그래프 그리는 곳. ************************************** 이후에 sqlite 적용후 그 목록 싹다 그릴 페이지.
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                SizedBox(
                                  width: (maxScreenWidth*0.4).clamp(200, 500),
                                  child:
                                      ownText(bmiDouble.toStringAsFixed(1), 20),
                                ),
                                SizedBox(
                                  width: (maxScreenWidth*0.4).clamp(200, 500),
                                  height: (maxScreenHeight * 0.8 * 0.45) *
                                      ((bmiDouble - 13) / 28),
                                  child: graphBar(bmiDouble),
                                ),
                                Container(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .primary
                                      .withOpacity(0),
                                  width: (maxScreenWidth*0.4).clamp(200, 500),
                                  height: 30,
                                  child: Center(
                                    child: Text(
                                      "$nowMonth/$nowday",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize:  (maxScreenWidth*0.04).clamp(12, 20),
                                          color: Colors.black,),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      )
              ),
              SizedBox(
                width: (maxScreenWidth * 0.9 * 0.05).clamp(10, 20),
              ),
            ],
          ),
        ),
      );
      }
    );
  }

  Widget graphBar(
    double bmi,
  ) {
    Color barColor = const Color.fromARGB(255, 139, 0, 0);
    // Color barColor = const Color.fromARGB(255, 75, 0, 130);
    // Color barColor = const Color.fromARGB(255, 139, 0, 0);
    if (bmi > 18.5) {
      // barColor = const Color.fromARGB(255, 0, 255, 0);
      // barColor = const Color.fromARGB(255, 64, 224, 208);
      barColor = const Color.fromARGB(255, 0, 255, 110);
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
}//end
