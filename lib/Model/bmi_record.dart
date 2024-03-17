import 'dart:typed_data';

import 'package:get/get_rx/src/rx_types/rx_types.dart';

class BMIrecord {
  final int? seq;
  final double bmiDouble;
  final double weightDouble;
  final double heightDouble;
  final String timestamp;
  final Uint8List? imgbyte;

  BMIrecord( {this.seq,required this.weightDouble,required this.heightDouble,required this.bmiDouble, required this.timestamp, this.imgbyte});

  BMIrecord.fromMap(Map<String, dynamic> res)
      : seq = res['seq'],
        bmiDouble = res['bmi'],
        weightDouble = res['height'],
        heightDouble = res['weight'],
        timestamp = res['insertdate'],
        imgbyte = res['image'];
}
