import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tinnius_therapy/freq.dart';
import 'package:tinnius_therapy/screens/anasayfa.dart';
import 'package:tinnius_therapy/screens/anasayfa2.dart';
import 'package:tinnius_therapy/screens/ayarlar.dart';
import 'package:tinnius_therapy/screens/gecmis.dart';
import 'package:tinnius_therapy/screens/sifre.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      //home: MyHomePage(title: 'Tinnius Therapy'),
      home: AnaSayfa2(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                  border: InputBorder.none, hintText: 'Frekans Giriniz'),
            ),
            RaisedButton(
                child: Text('freq'),
                onPressed: () {
                  Get.to(Freq());
                }),
            RaisedButton(
                child: Text('Ayarlar'),
                onPressed: () {
                  Get.to(Ayarlar());
                }),
            RaisedButton(
                child: Text('AnaSayfa'),
                onPressed: () {
                  Get.to(AnaSayfa2());
                }),
            RaisedButton(
                child: Text('gecmiş'),
                onPressed: () {
                  Get.to(Gecmis());
                }),
            RaisedButton(
                child: Text('sifre'),
                onPressed: () {
                  Get.to(Sifre());
                })
          ],
        ),
      ),
    );
  }
}
