import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mybmirecord/ViewModel_Controller/insertpage_controller.dart';
import 'package:mybmirecord/static/relative_size.dart';

import '../../Widget_Custom/custom_widget.dart';

Widget insertHeight(BuildContext context, InsertPageController controller) {
  double widthsize = RelativeSizeClass(context).widthSize!;
  double heightsize = RelativeSizeClass(context).heightSize!;
  // double fsizeSmall = RelativeSizeClass(context).customFontSizeS!;
  // double fsizeMiddle = RelativeSizeClass(context).customFontSizeM!;
  double fsizeLarge = RelativeSizeClass(context).customFontSizeL!;
  double fsizeXLarge = RelativeSizeClass(context).customFontSizeXL!;
  
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      SizedBox(
        width: widthsize * 0.3,
        height: heightsize * 0.09,
        // color: Colors.blue,
        child: Center(
          child: CustomWidget().customText(
              "${controller.height.toStringAsFixed(1)}cm", fsizeLarge, 'C'),
        ),
      ),
      SizedBox(
        // color: Colors.amber,
        width: widthsize * 0.55,
        height: heightsize * 0.09,
        child: Slider(
          value: controller.height.value,
          min: 100,
          max: 250,
          divisions: 1500,
          onChanged: (value) {
            controller.changeHeight(value);
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
                onTap: () => controller.plusHeight(),
                onTapDown: (details) {
                  controller.repeatedPlusHeight();
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
              child:GestureDetector(
                onTap: () => controller.subHeight(),
                onTapDown: (details) {
                  controller.repeatedSubHeight();
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
      )
    ],
  );
}
