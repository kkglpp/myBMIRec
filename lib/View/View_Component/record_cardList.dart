import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mybmirecord/View/ResultbmiPage.dart';
import 'package:mybmirecord/ViewModel_Controller/recordpageController.dart';
import 'package:mybmirecord/Widget_Custom/gridCard.dart';
import 'package:mybmirecord/static/forRelativeSize.dart';

Widget recordCardList(BuildContext context, RecordPageController controller){
      double widthsize = RelativeSizeClass(context).widthSize!;
    double heightsize = RelativeSizeClass(context).heightSize!;
    double fsizeSmall = RelativeSizeClass(context).customFontSizeS!;
    double fsizeMiddle = RelativeSizeClass(context).customFontSizeM!;
    double fsizeLarge= RelativeSizeClass(context).customFontSizeL!;
    double fsizeXLarge= RelativeSizeClass(context).customFontSizeXL!;

  return  Container(
                  decoration: BoxDecoration(
                      // color: const Color.fromARGB(255, 144, 143, 143),
                      borderRadius: BorderRadius.circular(10)),
                  width: widthsize,
                  height: (heightsize * 0.19),
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: controller.records.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Get.off(ResultBMIPage(
                              recordKey: controller.records[index].seq!));
                        },
                        child: SizedBox(
                          child: Center(
                            child: GridCard(controller.records[index].imgbyte,
                                    controller.records[index].timestamp)
                                .girdCard(
                              widthsize * 0.35,
                              heightsize * 0.19,
                              controller.records[index].bmi,
                              8,
                              fsize: RelativeSizeClass(context).orientation ==
                                      Orientation.portrait
                                  ? fsizeMiddle
                                  : fsizeMiddle / 1.8,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
}