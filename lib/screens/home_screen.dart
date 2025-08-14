import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void _loadData() async {
    final dataString = await rootBundle.loadString('assets/files/data.json');
    final dataJson = jsonDecode(
      dataString,
    ); //stringi jsona çevirmek için jsonDecode kullandık
    print(
      dataJson['kategoriler'],
    ); //dart tanısın diye jsona dönüştürdük böyle de yazdırdık
  } //veri okuma

  @override
  void initState() {
    _loadData(); // buraya ne yazarsak uygulama ilk başladığında çalışır
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Column(children: [])),
    );
  }
}
