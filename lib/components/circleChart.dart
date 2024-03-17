import 'package:flutter/material.dart';

class CircleChart extends CustomPainter{
  final double radius;
  final Color clr;
  final Color clrBor;

  CircleChart(this.clr, this.clrBor, {required this.radius});

  
  @override
  void paint(Canvas canvas, Size size) {

    //내부는 비어있고, 테두리만 있는 원 그리기. 
    final paint = Paint()
    ..color = clrBor
    ..style = PaintingStyle.stroke
    ..strokeWidth = 2;
    canvas.drawCircle(Offset(size.width/2,size.height/2 ), radius, paint);

  //내부가 색칙되어있는 원 그리기.
  final fillPaint = Paint()
    ..color = clr // 안의 색상 설정
    ..style = PaintingStyle.fill; // 안의 색을 칠하는 스타일로 설정
  canvas.drawCircle(Offset(size.width / 2, size.height / 2), radius, fillPaint); // 안의 색을 칠한 원 그리기
}

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
return true;
  }      

  }





