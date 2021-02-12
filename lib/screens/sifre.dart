import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:tinnius_therapy/screens/ayarlar.dart';

import 'gecmis.dart';

class Sifre extends StatefulWidget {
  @override
  _SifreState createState() => _SifreState();
}

class _SifreState extends State<Sifre> {
  TextEditingController textEditingController = TextEditingController();
  // ..text = "123456";

  bool hasError = false;
  String currentText = "";
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Şifre Gir'),
      ),
      body: Container(
        child: PinCodeTextField(
          appContext: context,
          length: 6,
          obscureText: false,
          animationType: AnimationType.fade,
          pinTheme: PinTheme(
            shape: PinCodeFieldShape.box,
            borderRadius: BorderRadius.circular(5),
            fieldHeight: 50,
            fieldWidth: 40,
            activeFillColor: Colors.white,
          ),
          animationDuration: Duration(milliseconds: 300),
          backgroundColor: Colors.blue.shade50,
          enableActiveFill: true,
          //errorAnimationController: errorController,
          controller: textEditingController,
          onCompleted: (v) {
            print("Completed $v");
            String sifre = '555555';
            if (v == sifre) {
              Get.to(Ayarlar());
            }
          },
          onChanged: (value) {
            print(value);
            setState(() {
              currentText = value;
            });
          },
          beforeTextPaste: (text) {
            print("Allowing to paste $text");
            //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
            //but you can show anything you want here, like your pop up saying wrong paste format or etc
            return true;
          },
        ),
      ),
    );
  }
}
