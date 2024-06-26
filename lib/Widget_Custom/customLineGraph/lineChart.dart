import 'package:flutter/material.dart';

/// 박스안에 선그래프 그리기 
class LineChart extends CustomPainter {

  /// boxLength, boxWidth:
  /// pastValue
  /// realValue
  /// nextValue
  /// linewidth
  /// fs
  /// unit  
  final double boxLength; // 선이 그려지는 박스의 세로 길이
  final double boxWidth; // 선이 그려지는 박스의 가로 길이
  final double minValue; // 세로축의 최소값
  final double maxValue; // 세로축의 최대값
  double? pastValue; //시작점.  직전 좌표.
  final double realValue; //실제 보여줄 세로값이지.
  double? nextValue; //다음 실측값의 좌표
  final double lineWidth;
  double fs;
  late String unit;


  LineChart(
      /// boxLength, boxWidth
    this.boxLength,
    this.boxWidth,
    this.minValue,
    this.maxValue,
    this.pastValue,
    this.realValue,
    this.nextValue,
    this.lineWidth, {
    this.fs = 8,
    this.unit = "",
  });

  
  late double realRange  = maxValue - minValue;
  late double minPosition = boxLength*(maxValue/realRange);
  late double maxPosition = boxLength*(minValue/realRange);
  
  //주어진 값에따라 y좌표를 계산해 주는 함수
  double realLength(double value) {
    // return (boxLength) * ((maxValue - value) / maxValue);
    return (boxLength) * ((maxValue - (value - minValue) ) / realRange);
  }

  @override
  void paint(Canvas canvas, Size size) {
// 그려지는 그림들의 설정을 만드는 파트

/* 선의 색상 및 두꼐 등을 설정 */
    Paint paint = Paint() // Paint 클래스는 어떤 식으로 화면을 그릴지 정할 때 쓰임.
      ..color = Colors.deepPurpleAccent // 색은 보라색
      ..strokeCap = StrokeCap.round // 선의 끝은 둥글게 함.
      ..strokeWidth = lineWidth; // 선의 굵기는 4.0

/*
점 생성하는 파트
좌표값으로 선이 그어지는 시작점 중간점 마지막점 생성 
                                          */
    Offset p1 = Offset(
        pastValue == null ? boxWidth / 2 : 0,
        pastValue == null
            ? realLength(realValue.clamp(0, maxValue))
            : realLength(
                (pastValue!.clamp(0, maxValue) + realValue.clamp(0, maxValue)) /
                    2));
                // (pastValue!.clamp(0, maxValue) + realValue.clamp(0, maxValue)) /
                //     2));
    Offset p2 = Offset(boxWidth / 2, realLength(realValue.clamp(0, maxValue)));
    // Offset p2 = Offset(boxWidth / 2, realLength(realValue.clamp(0, maxValue)));

    Offset p3 = Offset(
        nextValue == null ? boxWidth / 2 : boxWidth,
        nextValue == null
            ? realLength((realValue.clamp(0, maxValue)))
            // ? realLength((realValue.clamp(0, maxValue)))
            : realLength(
                (nextValue!.clamp(0, maxValue) + realValue.clamp(0, maxValue)) /
                    2));

    Offset textLocation = Offset(
      (boxWidth / 2) - (boxWidth * 0.35),
      (pastValue ?? realValue).clamp(0, realRange) < realValue.clamp(0, realRange)
      // (pastValue ?? realValue).clamp(0, maxValue) < realValue.clamp(0, maxValue)
          ? realLength((realValue.clamp(0, maxValue))) -
              10
          :  realLength((realValue.clamp(0, maxValue))) +
              3,
    );

/* 각 점에 해당하는 수치를 입력하는 파트 */
    TextPainter textPainter = TextPainter(
      text: TextSpan(
        text: "${realValue.toStringAsFixed(1)} $unit", // 표시할 텍스트
        style: TextStyle(
          color: Colors.black, // 글자 색상
          fontSize: fs, // 글자 크기
        ),
      ),
      textDirection: TextDirection.ltr,
    );

//************* 이 아래 한i줄이 그림 그리기가 실행되는 곳이다.
    canvas.drawLine(p1, p2, paint); // 선을 그림.  *********** 요기가 그림 그리는 곳
    canvas.drawLine(p2, p3, paint); // 선을 그림.  *********** 요기가 그림 그리는 곳

// p2에 점 그리기
    canvas.drawCircle(p2, lineWidth * 1.3, paint);
    textPainter.layout(); // 텍스트의 레이아웃을 설정
    textPainter.paint(canvas, textLocation); // 텍스트를 그림
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return false;
  }
}
