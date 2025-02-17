import 'package:flutter/material.dart';
import '../custom_widget.dart';
import 'line_chart.dart';

class GraphCard {
  lineGraphCell(int graphStatus,double widthsize, double heightsize,double minNum,  double maxNum,
      double? startNum, double middleNum, double? endNum, double lineWeight, double heightsize2 ,String xAxis, double heightsize3, {double fsizeX = 2 }) {
    return SizedBox(
        // color: Colors.grey ,
        // color: Colors.grey.withAlpha(255*(middleNum/maxNum).toInt()) ,
        width: widthsize,
        height: heightsize +heightsize2 + heightsize3,
        // child: Text("${records[index].bmiDouble}")
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            CustomPaint(
              size: Size(widthsize, heightsize-10),
              painter: LineChart(
                heightsize-10,
                widthsize,
                minNum,
                maxNum,
                startNum,
                middleNum,
                endNum,
                3,
              ),
            ),
            SizedBox(
              height: heightsize3,
            ),
    
            SizedBox(
              // color: Colors.red,
              width: widthsize,
              height: heightsize2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                CustomWidget().customText(
                xAxis,
                fsizeX,
                "C",
              ),],
              )
              

            )
          ],
        ),
        );
  }
}
