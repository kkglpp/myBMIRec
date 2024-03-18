import 'package:flutter/material.dart';
import 'package:mybmirecord/View/insert_bmi.dart';
import 'package:mybmirecord/View/renewal_insertPage.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("오늘의 BMI 입력하기"),
      ),
      body: const Center(
        child: InsertPage(),
      ),
    );
  }
}