import 'package:flutter/material.dart';

class RulerBar extends StatelessWidget {
  final double maxScreenWidth;
  final double maxScreenHeight;

  const RulerBar(
      {super.key, required this.maxScreenWidth, required this.maxScreenHeight});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: (maxScreenWidth * 0.9 * 0.1).clamp(50, 80),
      height: maxScreenHeight * 0.8 * 0.45 - 10,
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            child: Container(
              width: (maxScreenWidth * 0.9 * 0.1).clamp(50, 80),
              // height: (maxScreenHeight * 0.8 * 0.45*5/28) ,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color.fromARGB(255, 128, 0, 0), //비만 끝판왕
                    Color.fromARGB(255, 195, 51, 51),
                  ],
                ),
              ),
              child: Center(
                child: ownText("비만3단계", 11),
              ),
            ),
          ),
          Container(
            width: (maxScreenWidth * 0.9 * 0.1).clamp(50, 80),
            height: (maxScreenHeight * 0.8 * 0.45 * 5 / 28),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color.fromARGB(255, 195, 51, 51), //비만 3시작
                  Color.fromARGB(255, 225, 182, 182),
                ],
              ),
            ),
            child: Center(
              child: ownText("비만2단계", 11),
            ),
          ),
          Container(
            width: (maxScreenWidth * 0.9 * 0.1).clamp(50, 80),
            height: (maxScreenHeight * 0.8 * 0.45 * 5 / 28),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color.fromARGB(255, 225, 182, 182), //비만2시작
                  Color.fromARGB(255, 255, 220, 220), //비만시작
                ],
              ),
            ),
            child: Center(
              child: ownText("비만1단계", 11),
            ),
          ),
          Container(
            width: (maxScreenWidth * 0.9 * 0.1).clamp(50, 80),
            height: (maxScreenHeight * 0.8 * 0.45 * 2 / 28),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color.fromARGB(255, 255, 220, 220), //과체중 끝
                  Color.fromARGB(255, 255, 240, 240), //과체중 시작
                ],
              ),
            ),
            child: Center(
              child: ownText("과체중", 11),
            ),
          ),
          Container(
            width: (maxScreenWidth * 0.9 * 0.1).clamp(50, 80),
            height: (maxScreenHeight * 0.4 * 0.45 * 5 / 28),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color.fromARGB(255, 255, 240, 240), // 정상체중 끝
                  Color.fromARGB(255, 255, 255, 255), //정상체중 중간값. 최고로 정상적
                ],
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ownText("정상체중", 11),
              ],
            ),
          ),
          Container(
            width: (maxScreenWidth * 0.9 * 0.1).clamp(50, 80),
            height: (maxScreenHeight * 0.4 * 0.45 * 5 / 28),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color.fromARGB(255, 255, 255, 255), //정상 체중 중간값. 최고로 정상적
                  Color.fromARGB(255, 255, 220, 220), //정상체중 시작
                ],
              ),
            ),
          ),
          Container(
            width: (maxScreenWidth * 0.9 * 0.1).clamp(50, 80),
            height: (maxScreenHeight * 0.8 * 0.45 * 5 / 28),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color.fromARGB(255, 255, 220, 220), // 저체중에서 정상으로 넘어가는 파트
                  Color.fromARGB(255, 128, 0, 0), //저체중 끝판왕
                ],
              ),
            ),
            child: Center(
              child: ownText("저체중", 11),
            ),
          ),
        ],
      ),
    );
  }

//Widget
  Widget ownText(String con, double fsize) {
    return Text(
      con,
      style: TextStyle(
          color: Colors.black, fontSize: fsize, fontWeight: FontWeight.bold),
      textAlign: TextAlign.start,
    );
  }
} //end
