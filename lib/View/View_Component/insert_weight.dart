import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mybmirecord/ViewModel_Controller/insertpage_controller.dart';
import 'package:mybmirecord/static/relative_size.dart';

import '../../Widget_Custom/custom_widget.dart';

Widget insertWeight(BuildContext context, InsertPageController controller) {
  double widthsize = RelativeSizeClass(context).widthSize!;
  double heightsize = RelativeSizeClass(context).heightSize!;
  // double fsizeSmall = RelativeSizeClass(context).customFontSizeS!;
  // double fsizeMiddle = RelativeSizeClass(context).customFontSizeM!;
  double fsizeLarge = RelativeSizeClass(context).customFontSizeL!;
  double fsizeXLarge = RelativeSizeClass(context).customFontSizeXL!;
  CustomWidget custom = CustomWidget();
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      SizedBox(
        width: widthsize * 0.3,
        height: heightsize * 0.09,
        // color: Colors.blue,
        child: Center(
          child: custom.customText(
              "${controller.weight.toStringAsFixed(1)} kg", fsizeLarge, 'C'),
        ),
      ),
      SizedBox(
        // color: Colors.amber,
        width: widthsize * 0.55,
        height: heightsize * 0.09,
        child: Slider(
          value: controller.weight.value,
          min: 30,
          max: 180,
          divisions: 1500,
          onChanged: (value) {
            controller.changeWeight(value);
          },
        ),
      ),
      SizedBox(
        // color: Colors.green,
        width: widthsize * 0.15,
        height: heightsize * 0.09,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              // color: Colors.pink,
              height: heightsize * 0.045,
              child: GestureDetector(
                onTap: () => controller.plusWeight(),
                onTapDown: (details) {
                  controller.repeatedPlusWeight();
                },
                onTapUp: (details) {
                  controller.timerEnd();
                },
                child: Icon(
                  Icons.keyboard_arrow_up_sharp,
                  size: fsizeXLarge * 1.2,
                ),
              ),
            ),
            const Spacer(),
            SizedBox(
              // color: Colors.yellow,
              height: heightsize * 0.045,
              child: GestureDetector(
                onTap: () => controller.subWeight(),
                onTapDown: (details) {
                  controller.repeatedSubWeight();
                },
                onTapUp: (details) {
                  controller.timerEnd();
                },
                child: Icon(
                  Icons.keyboard_arrow_down_sharp,
                  size: fsizeXLarge * 1.2,
                ),
              ),
            ),
          ],
        ),
      ),
      SizedBox(
        width: widthsize * 0.05,
      ),
    ],
  );
}
