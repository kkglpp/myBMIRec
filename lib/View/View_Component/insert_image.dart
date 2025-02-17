import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mybmirecord/ViewModel_Controller/insertpage_controller.dart';
import 'package:mybmirecord/static/relative_size.dart';

import '../../Widget_Custom/custom_widget.dart';

Widget insertImg(BuildContext context, InsertPageController ctrl) {
  double widthsize = RelativeSizeClass(context).widthSize!;
  double heightsize = RelativeSizeClass(context).heightSize!;
  // double fsizeSmall = RelativeSizeClass(context).customFontSizeS!;
  double fsizeMiddle = RelativeSizeClass(context).customFontSizeM!;
  double fsizeLarge = RelativeSizeClass(context).customFontSizeL!;
  // double fsizeXLarge = RelativeSizeClass(context).customFontSizeXL!;
  return SizedBox(
    width: widthsize,
    height: heightsize * 0.5,
    // color: Colors.blue,
    child: Column(
      children: [
        SizedBox(
          height: heightsize * 0.025,
        ),
        SizedBox(
            child: ctrl.imgPath.value == "1"
                ? Container(
                  color: Colors.black,
                    height: heightsize * 0.35,
                    width: widthsize*0.6,
                    child: Center(child: CustomWidget().customText("이미지를 골라주세요", fsizeLarge, "C",clr: Colors.white)),
                  )
                : Image.file(
                    File(ctrl.imgPath.value),
                    height: heightsize * 0.35,
                    width: widthsize,
                    fit: BoxFit.fitHeight,
                  )),
        const Spacer(),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: Colors.purple[200],
              foregroundColor: Colors.white,
              minimumSize: Size(widthsize * 0.9, heightsize * 0.05)),
          onPressed: () {
            ctrl.selectImage();
          },
          child: Text(
            "눈바디 사진 선택",
            style:
                TextStyle(fontWeight: FontWeight.w800, fontSize: fsizeMiddle),
          ),
        )
      ],
    ),
  );
}
