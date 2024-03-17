// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:mybmirecord/Model/bmi_record.dart';
// import 'package:mybmirecord/VM/database_handler.dart';
// import 'package:mybmirecord/own_chart.dart';

// class ResultPage extends StatefulWidget {
//   final bool nowShow;
//   final double bmiDouble;
//   final String bmiString;
//   final int bmistatus;

//   const ResultPage(
//       {super.key,
//       required this.nowShow,
//       required this.bmiDouble,
//       required this.bmiString,
//       required this.bmistatus});

//   @override
//   State<ResultPage> createState() => _ResultPageState();
// }

// class _ResultPageState extends State<ResultPage> {
//   late List<String> advices;
//   late double maxScreenWidth;
//   late double maxScreenHeight;

//   @override
//   void initState() {
//     super.initState();
//     advices = [
//       "근육이 붙어야 살도 붙습니다. \n음식을 충분히 먹고, 웨이트 트레이닝을 하세요!",
//       "매우 건강한 지표를 보이고 있습니다. \n꾸준한 운동과 적절한 영양공급! 잊지마세요.",
//       "체중이 불어나고 있어요!! \n방심하면 비만으로 넘어갑니다. 위기에요!",
//       "비만에 돌입했어요. \n내일 말고 지금 이순간 부터 운동 해볼까요?",
//       "다이어트는 최고의 성형입니다. \n당신의 아름다움을 속살에 너무 숨기지 마세요!",
//       "맙소사...늦었다 싶을때가 진짜 늦은 때에요! \n사랑하는 사람들을 위해 체중을 줄여봐요."
//     ];
//   }

//   setSize() {
//     maxScreenWidth = MediaQuery.of(context).size.width;
//     maxScreenHeight = MediaQuery.of(context).size.height;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("내 BMI 결과 확인하기"),
//       ),
//       body: OrientationBuilder(builder: (context, orientation) {
//         setSize();
//         return Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: [
//               // SizedBox(
//               //   height: maxScreenHeight * 0.05,
//               // ),
//               const Spacer(),
//               /* 그래프를 그리는 파트 */
//               OwnChart(
//                   nowShow: widget.nowShow,
//                   bmiDouble: widget.bmiDouble,
//                   bmiString: widget.bmiString), // 높이 40%
//               const Spacer(),//-------------------------------------------------------------------
//               /* 건강 관리를 위한 제안을 넣는 파트 */
//               Container(
//                 width: maxScreenWidth * 0.9,
//                 height: maxScreenHeight * 0.25,
//                 color: Theme.of(context).colorScheme.background,
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       children: [
//                         Container(
//                           color: Theme.of(context).colorScheme.background,
//                           width: maxScreenWidth * 0.9 * 0.4,
//                           height: maxScreenHeight * 0.25 * 0.9,
//                           child: Image.asset(
//                             "images/${widget.bmistatus.toString()}.jpeg",
//                             fit: BoxFit.fitHeight,
//                           ),
//                         ),
//                         SizedBox(
//                           width: maxScreenWidth * 0.9 * 0.05,
//                         ),
//                         Container(
//                           // color: Theme.of(context)
//                           //     .colorScheme
//                           //     .primary
//                           //     .withOpacity(0.8),
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(12),
//                             color:
//                                 selectColor(widget.bmiDouble).withOpacity(0.7),
//                           ),

//                           width: maxScreenWidth * 0.9 * 0.55,
//                           height: maxScreenHeight * 0.25 * 0.9,
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               Padding(
//                                 padding:
//                                     const EdgeInsets.fromLTRB(0, 10, 0, 10),
//                                 child: Row(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   children: [
//                                     Text(
//                                       "BMI 수치",
//                                       textAlign: TextAlign.center,
//                                       style: TextStyle(
//                                           fontSize: 24,
//                                           fontWeight: FontWeight.bold,
//                                           color: Theme.of(context)
//                                               .colorScheme
//                                               .onPrimary),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               const Spacer(),
//                               Row(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 crossAxisAlignment: CrossAxisAlignment.end,
//                                 children: [
//                                   const Spacer(),
//                                   Text(
//                                     widget.bmiDouble.toStringAsFixed(2),
//                                     style: TextStyle(
//                                         fontWeight: FontWeight.bold,
//                                         fontSize: (maxScreenHeight * 0.02)
//                                             .clamp(18, 40),
//                                         color: Theme.of(context)
//                                             .colorScheme
//                                             .onPrimary),
//                                   ),
//                                   const Spacer(),
//                                   Text(
//                                     widget.bmiString,
//                                     style: TextStyle(
//                                         fontWeight: FontWeight.bold,
//                                         fontSize: (maxScreenHeight * 0.018)
//                                             .clamp(18, 40),
//                                         color: Theme.of(context)
//                                             .colorScheme
//                                             .onPrimary),
//                                   ),
//                                   const Spacer(),
//                                 ],
//                               ),
//                               const Spacer(),
//                               Row(
//                                 mainAxisAlignment: MainAxisAlignment.end,
//                                 crossAxisAlignment: CrossAxisAlignment.end,
//                                 children: [
//                                   Padding(
//                                     padding:
//                                         const EdgeInsets.fromLTRB(0, 0, 10, 5),
//                                     child: Text(
//                                       "${DateTime.now().year.toString()}-${DateTime.now().month.toString()} - ${DateTime.now().day.toString()}",
//                                       style: TextStyle(
//                                           fontSize: 15,
//                                           color: Theme.of(context)
//                                               .colorScheme
//                                               .onPrimary),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ],
//                           ),
//                         )
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//               const Spacer(),
//               SizedBox(
//                 height: maxScreenHeight * 0.25 * 0.25,
//                 child: Center(
//                   child: Text(
//                     advices[widget.bmistatus],
//                     textAlign: TextAlign.center,
//                     style: TextStyle(
//                       fontSize: (maxScreenWidth * 0.02).clamp(15, 20),
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//               ),
//               const Spacer(),

//               /* Button 을 넣기 위한 sizedBox*/
//               SizedBox(
//                 width: maxScreenWidth * 0.9,
//                 height: maxScreenHeight * 0.05,
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     const Spacer(),
//                     /* _____________________ 저장하기 Button _____________________*/
//                     ElevatedButton(
//                       style: ElevatedButton.styleFrom(
//                           minimumSize: Size(
//                               maxScreenWidth * 0.3, maxScreenHeight * 0.05)),
//                       onPressed: () {
//                         _dialogFirst();
//                       },
//                       child: Text(
//                         "저장하기",
//                         style: TextStyle(
//                           fontSize: (maxScreenWidth * 0.02).clamp(15, 30),
//                           color: Colors.blue,
//                         ),
//                       ),
//                     ),
//                     const Spacer(),
//                     /* _____________________ 취소하기 Button _____________________*/
//                     ElevatedButton(
//                       style: ElevatedButton.styleFrom(
//                           minimumSize: Size(
//                               maxScreenWidth * 0.3, maxScreenHeight * 0.05)),
//                       onPressed: () {
//                         Get.back();
//                       },
//                       child: Text(
//                         "취소하기",
//                         style: TextStyle(
//                           fontSize: (maxScreenWidth * 0.02).clamp(15, 30),
//                           color: Colors.red,
//                         ),
//                       ),
//                     ),
//                     const Spacer(),
//                   ],
//                 ),
//               ),
//               const Spacer(),
//               const SizedBox(
//                 height: 5,
//               ),
//             ],
//           ),
//         );
//       }),
//     );
//   }

//   // ---Function
//   _saveBMI() {
//     DatabaseHandler handler = DatabaseHandler();
//     handler.initializeDB();

//     int nowYear = DateTime.now().year;
//     int nowday = DateTime.now().day;
//     int nowMonth = DateTime.now().month;
//     BMIrecord bmi = BMIrecord(
//         weightDouble: w,
//         bmiDouble: widget.bmiDouble,
//         timestamp: "$nowYear / $nowMonth / $nowday");

//     // handler.InsertRecord(bmi);
//     Get.back();
//     Get.back();
//   }

//   _dialogFirst() {
//     Get.defaultDialog(
//         title: "오늘의 BMI 저장하기",
//         middleText: "저장하시겠습니까?",
//         barrierDismissible: false,
//         actions: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               // const SizedBox(width: 70,),
//               TextButton(
//                   onPressed: () {
//                     _saveBMI();
//                   },
//                   child: const Text(
//                     "저 장",
//                     style: TextStyle(fontSize: 25, color: Colors.blue),
//                   )),
//               const SizedBox(
//                 width: 10,
//               ),
//               TextButton(
//                   onPressed: () {
//                     Get.back();
//                   },
//                   child: const Text(
//                     "취 소",
//                     style: TextStyle(fontSize: 25, color: Colors.red),
//                   )),
//               // const SizedBox(width: 70,),
//             ],
//           ),
//         ]);
//   }

//   selectColor(double bmi) {
//     Color barColor = const Color.fromARGB(255, 139, 0, 0);
//     // Color barColor = const Color.fromARGB(255, 75, 0, 130);
//     // Color barColor = const Color.fromARGB(255, 139, 0, 0);
//     if (bmi > 18.5) {
//       // barColor = const Color.fromARGB(255, 0, 255, 0);
//       // barColor = const Color.fromARGB(255, 64, 224, 208);
//       barColor = const Color.fromARGB(255, 0, 150, 80);
//     }
//     if (bmi > 22.9) {
//       barColor = const Color.fromARGB(255, 255, 165, 0);
//       // barColor = const Color.fromARGB(255, 255, 127, 80);
//       // barColor = const Color.fromARGB(255, 255, 255, 102);
//     }
//     if (bmi > 25) {
//       barColor = const Color.fromARGB(255, 255, 140, 0);
//       // barColor = const Color.fromARGB(255, 233, 150, 122);
//       // barColor = const Color.fromARGB(255, 255, 165, 0);
//     }
//     if (bmi > 30) {
//       barColor = const Color.fromARGB(255, 139, 0, 0);
//       // barColor = const Color.fromARGB(255, 205, 92, 92);
//       // barColor = const Color.fromARGB(255, 255, 102, 102);
//     }
//     if (bmi > 34.9) {
//       barColor = const Color.fromARGB(255, 101, 67, 33);
//       // barColor = const Color.fromARGB(255, 160, 82, 45);
//       // barColor = const Color.fromARGB(255, 130, 130, 130);
//     }
//     return barColor;
//   }
// }//end
