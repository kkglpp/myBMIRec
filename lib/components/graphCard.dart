import 'package:flutter/material.dart';
import 'package:mybmirecord/components/lineChart.dart';
import 'package:mybmirecord/components/textMiddle.dart';

class graphCard {
  lineGraphCell(double widthsize, double heightsize, double maxNum,
      double? startNum, double middleNum, double? endNum, double lineWeight, double heightsize2 ,String xAxis) {
    return Container(
        // color: Colors.grey ,
        // color: Colors.grey.withAlpha(255*(middleNum/maxNum).toInt()) ,
        width: widthsize,
        height: heightsize +heightsize2,
        // child: Text("${records[index].bmiDouble}")
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            CustomPaint(
              size: Size(widthsize, heightsize-10),
              painter: LineChart(
                heightsize-10,
                widthsize,
                maxNum,
                startNum,
                middleNum,
                endNum,
                3,
              ),
            ),

            Container(
              // color: Colors.amber,
              width: widthsize,
              height: heightsize2,
              child: TextCustom().customText(
                xAxis,
                8,
                "C",
              ),
            )
          ],
        ),
        );
  }
}
