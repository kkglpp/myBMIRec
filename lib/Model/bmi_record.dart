import 'dart:typed_data';



class BMIrecord {
  final int? seq;
  final double bmi;
  final double weight;
  final double height;
  final String timestamp;
  final Uint8List? imgbyte;

  BMIrecord( {this.seq,required this.weight,required this.height,required this.bmi, required this.timestamp, this.imgbyte});

  BMIrecord.fromMap(Map<String, dynamic> res)
      : seq = res['seq'],
        bmi = res['bmi'],
        weight = res['weight'],
        height = res['height'],
        timestamp = res['insertdate'],
        imgbyte = res['image'];
}
