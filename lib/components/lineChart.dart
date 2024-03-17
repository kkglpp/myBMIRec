import 'package:flutter/material.dart';

class LineChart extends CustomPainter {
  final double boxLength; // 선이 그려지는 박스의 세로 길이
  final double boxWidth; // 선이 그려지는 박스의 가로 길이
  final double maxValue; // 세로값에 영향주겠지
  double? pastValue; //시작점.  직전 좌표.
  final double realValue; //실제 보여줄 세로값이지.
  final double lineWidth;

  LineChart(this.boxLength, this.boxWidth, this.maxValue, this.pastValue,
      this.realValue, this.lineWidth);

  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint
    pastValue ??= realValue;
    // double dividedNum = maxValue
    double realLength = boxLength * ((maxValue - realValue) / maxValue);

    Paint paint = Paint() // Paint 클래스는 어떤 식으로 화면을 그릴지 정할 때 쓰임.
      ..color = Colors.deepPurpleAccent // 색은 보라색
      ..strokeCap = StrokeCap.round // 선의 끝은 둥글게 함.
      ..strokeWidth = lineWidth; // 선의 굵기는 4.0

    Offset p1 = Offset(
      0,
      boxLength* ( (maxValue - pastValue!)   / maxValue)
      // boxLength - pastValue!,
    ); // 선을 그리기 위한 좌표값을 만듬.
    Offset p2 = Offset(
      boxWidth,
      boxLength * ((maxValue - realValue) / maxValue), //
    );

//************* 이 아래 한i줄이 그림 그리기가 실행되는 곳이다.
    canvas.drawLine(p1, p2, paint); // 선을 그림.  *********** 요기가 그림 그리는 곳

    // canvas.drawRect(rect, paint); // 사각형 그리기
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return false;
  }
}
