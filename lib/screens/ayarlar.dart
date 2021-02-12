import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sound_generator/sound_generator.dart';
import 'package:sound_generator/waveTypes.dart';
import 'package:tinnius_therapy/controllers/gecmisekle.dart';
import 'package:tinnius_therapy/screens/gecmis.dart';
import 'package:toggle_switch/toggle_switch.dart';

class Ayarlar extends StatefulWidget {
  @override
  _AyarlarState createState() => _AyarlarState();
}

class _AyarlarState extends State<Ayarlar> {
  bool isPlaying = false;
  bool isWhiteNoise = false;
  double frequency = 20;
  double frequency1 = 15.32;
  double frequency2 = 18;
  double frequency3 = 22;
  double frequency4 = 28;
  double balance = 0;
  double volume = 1;
  waveTypes waveType = waveTypes.SINUSOIDAL;
  int sampleRate = 96000;
  List<int> oneCycleData;
  bool status = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          InkWell(
              onTap: () {
                Get.to(Gecmis());
              },
              child: Icon(Icons.book)),
          SizedBox(width: 10)
        ],
        title: Text('Ayarlar'),
      ),
      body: Container(
        child: Column(
          children: [
            Text(
              'Ana Frekans',
              style: TextStyle(fontSize: 30),
            ),
            Container(
                width: double.infinity,
                height: 40,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Expanded(
                        flex: 2,
                        child: Center(
                            child: Text(
                                this.frequency.toStringAsFixed(2) + " Hz")),
                      ),
                      Expanded(
                        flex: 8, // 60%
                        child: Slider(
                            min: 20,
                            max: 16000,
                            value: this.frequency,
                            onChanged: (_value) {
                              setState(() {
                                this.frequency1 = this.frequency * 0.766;
                                this.frequency2 = this.frequency * 0.9;
                                this.frequency3 = this.frequency * 1.1;
                                this.frequency4 = this.frequency * 1.4;
                                this.frequency = _value.toDouble();
                                SoundGenerator.setFrequency(this.frequency);
                              });
                            }),
                      )
                    ])),
            CircleAvatar(
                radius: 25,
                backgroundColor: Colors.lightBlueAccent,
                child: IconButton(
                    icon: Icon(isPlaying ? Icons.stop : Icons.play_arrow),
                    onPressed: () {
                      if (this.frequency.toInt() <= 30) {
                        SoundGenerator.stop();
                      } else {
                        SoundGenerator.play();
                      }

                      //SoundGenerator.setFrequency(1000);
                      SoundGenerator.setBalance(0);
                      SoundGenerator.setVolume(1);

                      //isPlaying ? SoundGenerator.stop() : SoundGenerator.play();
                    })),
            SizedBox(
              height: 10,
            ),
            Column(
              children: [
                Text('f = ' + this.frequency.toStringAsFixed(2) + " Hz"),
                Text('f1 = ' + this.frequency1.toStringAsFixed(2) + " Hz"),
                Text('f2 = ' + this.frequency2.toStringAsFixed(2) + " Hz"),
                Text('f3 = ' + this.frequency3.toStringAsFixed(2) + " Hz"),
                Text('f4 = ' + this.frequency4.toStringAsFixed(2) + " Hz"),
              ],
            ),
            SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('White Noise'),
                SizedBox(width: 10),
                FlutterSwitch(
                  //width: 125.0,
                  // height: 55.0,
                  valueFontSize: 25.0,
                  toggleSize: 45.0,
                  value: status,
                  borderRadius: 30.0,
                  //padding: 8.0,
                  showOnOff: true,
                  onToggle: (val) async {
                    setState(() {
                      status = val;
                    });
                  },
                ),
              ],
            ),
            SizedBox(height: 5),
            RaisedButton(
                child: Text('karanlık mod'),
                onPressed: () {
                  Get.changeTheme(ThemeData.dark());
                }),
            SizedBox(height: 5),
            RaisedButton(
                child: Text('aydınlık mod'),
                onPressed: () {
                  Get.changeTheme(ThemeData.light());
                }),
            RaisedButton(
                child: Text('Geçmişi Sil'),
                onPressed: () {
                  gecmisSil();
                }),
            SizedBox(height: 5),

            /* Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('White Noise'),
                SizedBox(width: 10),
                ToggleSwitch(
                  minWidth: 90.0,
                  cornerRadius: 20.0,
                  activeBgColor: Colors.blue,
                  activeFgColor: Colors.white,
                  inactiveBgColor: Colors.grey,
                  inactiveFgColor: Colors.white,
                  labels: ['Açık', 'Kapalı'],
                  icons: [Icons.check, Icons.time_to_leave],
                  onToggle: (index) {
                    print('switched to: $index');
                  },
                ),
              ],
            ), */
            //TODO: geçmişi temizle butonu
            RaisedButton(
                child: Text('Kaydet'),
                onPressed: () async {
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  //save data
                  prefs.setDouble('f1', this.frequency1);
                  prefs.setDouble('f2', this.frequency2);
                  prefs.setDouble('f3', this.frequency3);
                  prefs.setDouble('f4', this.frequency4);
                  print(prefs.getDouble('f1').toString() +
                      "---" +
                      prefs.getDouble('f2').toString() +
                      "---" +
                      prefs.getDouble('f3').toString() +
                      "---" +
                      prefs.getDouble('f4').toString());
                  prefs.setBool('whitenoise', status);

                  Get.back();
                }),
          ],
        ),
      ),
    );
  }
}
