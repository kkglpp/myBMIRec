import 'package:flutter/material.dart';

import 'package:mybmirecord/View/renewal_insertpage.dart';

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
