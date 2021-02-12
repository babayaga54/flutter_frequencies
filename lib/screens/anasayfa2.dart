import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:chips_choice/chips_choice.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sound_generator/sound_generator.dart';
import 'package:sound_generator/waveTypes.dart';
import 'package:tinnius_therapy/controllers/gecmisekle.dart';
import 'package:tinnius_therapy/main.dart';
import 'package:tinnius_therapy/screens/sifre.dart';

class AnaSayfa2 extends StatefulWidget {
  @override
  _AnaSayfa2State createState() => _AnaSayfa2State();
}

class MyPainter extends CustomPainter {
  //         <-- CustomPainter class
  final List<int> oneCycleData;

  MyPainter(this.oneCycleData);

  @override
  void paint(Canvas canvas, Size size) {
    var i = 0;
    List<Offset> maxPoints = [];

    final t = size.width / (oneCycleData.length - 1);
    for (var _i = 0, _len = oneCycleData.length; _i < _len; _i++) {
      maxPoints.add(Offset(
          t * i,
          size.height / 2 -
              oneCycleData[_i].toDouble() / 32767.0 * size.height / 2));
      i++;
    }

    final paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 1
      ..strokeCap = StrokeCap.round;
    canvas.drawPoints(PointMode.polygon, maxPoints, paint);
  }

  @override
  bool shouldRepaint(MyPainter old) {
    if (oneCycleData != old.oneCycleData) {
      return true;
    }
    return false;
  }
}

class _AnaSayfa2State extends State<AnaSayfa2> {
  bool isPlaying = false;
  bool isPlayingWhiteNoise = false;
  bool isPlaying1 = false;
  bool isPlaying2 = false;
  bool isPlaying3 = false;
  bool isPlaying4 = false;
  int white_noise_sayac = 0;
  double frequency = 20;
  double balance = 0;
  double volume = 0.50;
  double white_volume = 1;
  waveTypes waveType = waveTypes.SINUSOIDAL;
  int sampleRate = 96000;
  List<int> oneCycleData;
  final assetsAudioPlayer = AssetsAudioPlayer();
  final white_player = AssetsAudioPlayer.withId("white");
  Timer _zamanlayiciTimer;
  int tag = 1;
  List<String> options = ['', 'Kapalı', 'Şömine', 'Doğa', 'Kuş', 'Yağmur'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Tinnitus Therapy'),
          actions: [
            InkWell(
                onTap: () {
                  Get.to(Sifre());
                },
                child: Icon(Icons.settings)),
            SizedBox(width: 10)
          ],
        ),
        body: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            padding: EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 20,
            ),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("Tinnitus Therapy"),
                  Divider(
                    color: Colors.red,
                  ),
                  CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.lightBlueAccent,
                      child: IconButton(
                          icon:
                              Icon(isPlaying4 ? Icons.stop : Icons.play_arrow),
                          onPressed: () async {
                            isPlaying4
                                ? zamanlayiciIptal()
                                : zamanlayiciShared();

                            SharedPreferences prefs =
                                await SharedPreferences.getInstance();

                            bool whiteCal = prefs.getBool('whitenoise');

                            print('fonskiyonda' + whiteCal.toString());
                            if (whiteCal == true && isPlaying4 == true) {
                              white_player.open(
                                Audio("assets/white2.mp3"),
                                autoStart: true,
                              );
                            }
                          })),
                  Divider(
                    color: Colors.red,
                  ),
                  /*    Text("Tek Frekans Oynatıcı"),
                  CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.lightBlueAccent,
                      child: IconButton(
                          icon:
                              Icon(isPlaying3 ? Icons.stop : Icons.play_arrow),
                          onPressed: () async {
                            isPlaying3
                                ? SoundGenerator.stop()
                                : SoundGenerator.play();

                            SharedPreferences prefs =
                                await SharedPreferences.getInstance();

                            bool whiteCal = prefs.getBool('whitenoise');

                            print('fonskiyonda' + whiteCal.toString());
                          })),
                  Divider(
                    color: Colors.red,
                  ), */
                  SizedBox(height: 5),
                  Text("Volume"),
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
                                  child: Text(this.volume.toStringAsFixed(2))),
                            ),
                            Expanded(
                              flex: 8, // 60%
                              child: Slider(
                                  min: 0,
                                  max: 0.50,
                                  value: this.volume,
                                  onChanged: (_value) {
                                    setState(() {
                                      this.volume = _value.toDouble();
                                      SoundGenerator.setVolume(this.volume);
                                    });
                                  }),
                            )
                          ])),
                  /*
                  Divider(
                    color: Colors.red,
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
                              child: Center(child: Text('f1')),
                            ),
                            Expanded(
                              flex: 8, // 60%
                              child: Slider(
                                  min: 0,
                                  max: 1,
                                  value: this.volume,
                                  onChanged: (_value) {
                                    setState(() {
                                      this.volume = _value.toDouble();
                                      SoundGenerator.setVolume(this.volume);
                                    });
                                  }),
                            ),
                            Expanded(
                              flex: 2,
                              child: Center(
                                  child: CircleAvatar(
                                      radius: 30,
                                      backgroundColor: Colors.lightBlueAccent,
                                      child: IconButton(
                                          icon: Icon(isPlaying2
                                              ? Icons.stop
                                              : Icons.play_arrow),
                                          onPressed: () {
                                            SoundGenerator.setFrequency(6000);

                                            isPlaying2
                                                ? SoundGenerator.stop()
                                                : SoundGenerator.play();
                                          }))),
                            ),
                          ])),
                  SizedBox(height: 15),
                  Container(
                      width: double.infinity,
                      height: 40,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            Expanded(
                              flex: 2,
                              child: Center(child: Text('f2')),
                            ),
                            Expanded(
                              flex: 8, // 60%
                              child: Slider(
                                  min: 0,
                                  max: 1,
                                  value: this.volume,
                                  onChanged: (_value) {
                                    setState(() {
                                      this.volume = _value.toDouble();
                                      SoundGenerator.setVolume(this.volume);
                                    });
                                  }),
                            ),
                            Expanded(
                              flex: 2,
                              child: Center(
                                  child: CircleAvatar(
                                      radius: 30,
                                      backgroundColor: Colors.lightBlueAccent,
                                      child: IconButton(
                                          icon: Icon(isPlaying2
                                              ? Icons.stop
                                              : Icons.play_arrow),
                                          onPressed: () {
                                            SoundGenerator.setFrequency(8000);

                                            isPlaying2
                                                ? SoundGenerator.stop()
                                                : SoundGenerator.play();
                                          }))),
                            ),
                          ])),
                  SizedBox(height: 15),
                  Container(
                      width: double.infinity,
                      height: 40,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            Expanded(
                              flex: 2,
                              child: Center(child: Text('f3')),
                            ),
                            Expanded(
                              flex: 8, // 60%
                              child: Slider(
                                  min: 0,
                                  max: 1,
                                  value: this.volume,
                                  onChanged: (_value) {
                                    setState(() {
                                      this.volume = _value.toDouble();
                                      SoundGenerator.setVolume(this.volume);
                                    });
                                  }),
                            ),
                            Expanded(
                              flex: 2,
                              child: Center(
                                  child: CircleAvatar(
                                      radius: 30,
                                      backgroundColor: Colors.lightBlueAccent,
                                      child: IconButton(
                                          icon: Icon(isPlaying2
                                              ? Icons.stop
                                              : Icons.play_arrow),
                                          onPressed: () {
                                            SoundGenerator.setFrequency(10000);

                                            isPlaying2
                                                ? SoundGenerator.stop()
                                                : SoundGenerator.play();
                                          }))),
                            ),
                          ])),
                  SizedBox(height: 15),
                  Container(
                      width: double.infinity,
                      height: 40,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            Expanded(
                              flex: 2,
                              child: Center(child: Text('f4')),
                            ),
                            Expanded(
                              flex: 8, // 60%
                              child: Slider(
                                  min: 0,
                                  max: 1,
                                  value: this.volume,
                                  onChanged: (_value) {
                                    setState(() {
                                      this.volume = _value.toDouble();
                                      SoundGenerator.setVolume(this.volume);
                                    });
                                  }),
                            ),
                            Expanded(
                              flex: 2,
                              child: Center(
                                  child: CircleAvatar(
                                      radius: 30,
                                      backgroundColor: Colors.lightBlueAccent,
                                      child: IconButton(
                                          icon: Icon(isPlaying2
                                              ? Icons.stop
                                              : Icons.play_arrow),
                                          onPressed: () {
                                            SoundGenerator.setFrequency(2000);

                                            isPlaying2
                                                ? SoundGenerator.stop()
                                                : SoundGenerator.play();
                                          }))),
                            ),
                          ])), */
                  Divider(
                    color: Colors.red,
                  ),
                  /* SizedBox(height: 5),
                  Text("White Noise"),
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
                                      this.white_volume.toStringAsFixed(2))),
                            ),
                            Expanded(
                              flex: 8, // 60%
                              child: Slider(
                                  min: 0,
                                  max: 1,
                                  value: this.white_volume,
                                  onChanged: (_value) {
                                    setState(() {
                                      this.white_volume = _value.toDouble();

                                      white_player.setVolume(this.white_volume);
                                    });
                                  }),
                            ),
                            Expanded(
                              flex: 2,
                              child: Center(
                                  child: CircleAvatar(
                                      radius: 30,
                                      backgroundColor: Colors.lightBlueAccent,
                                      child: IconButton(
                                          icon: Icon(white_noise_sayac.isOdd
                                              ? Icons.stop
                                              : Icons.play_arrow),
                                          onPressed: () {
                                            white_noise_sayac++;
                                            if (white_noise_sayac.isEven) {
                                              isPlayingWhiteNoise = true;
                                            } else {
                                              isPlayingWhiteNoise = false;
                                            }
                                            isPlayingWhiteNoise
                                                ? white_player.stop()
                                                : white_player.open(
                                                    Audio("assets/white.mp3"),
                                                    autoStart: true,
                                                  );
                                          }))),
                            ),
                          ])),
                  Divider(
                    color: Colors.red,
                  ), */
                  ChipsChoice<int>.single(
                    choiceStyle: C2ChoiceStyle(
                      color: Colors.grey,
                    ),
                    choiceActiveStyle: C2ChoiceStyle(color: Colors.blue),
                    value: tag,
                    onChanged: (val) {
                      if (val == 0) {
                        assetsAudioPlayer.stop();
                        assetsAudioPlayer.open(
                          Audio("assets/white2.mp3"),
                          autoStart: true,
                        );
                        white_player.setVolume(1.00);

                        print("playing1");
                      } else if (val == 1) {
                        assetsAudioPlayer.stop();
                      } else if (val == 2) {
                        assetsAudioPlayer.stop();
                        assetsAudioPlayer.open(
                          Audio("assets/somine.mp3"),
                          autoStart: true,
                        );
                        white_player.setVolume(1.00);
                      } else if (val == 3) {
                      } else if (val == 4) {
                        assetsAudioPlayer.stop();
                        assetsAudioPlayer.open(
                          Audio("assets/kus.mp3"),
                          autoStart: true,
                        );
                        white_player.setVolume(1.00);
                      } else if (val == 5) {
                        assetsAudioPlayer.stop();
                        assetsAudioPlayer.open(
                          Audio("assets/selale.mp3"),
                          autoStart: true,
                        );
                        white_player.setVolume(1.00);
                      }
                      setState(() => tag = val);
                    },
                    choiceItems: C2Choice.listFrom<int, String>(
                      source: options,
                      value: (i, v) => i,
                      label: (i, v) => v,
                    ),
                  ),
                ])));
  }

  @override
  void dispose() {
    super.dispose();
    SoundGenerator.release();
  }

  sesiSifiraIndir() async {
    setState(() {
      white_player.setVolume(0.00);
    });
  }

  zamanlayiciIptal() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    _zamanlayiciTimer.cancel();
    SoundGenerator.stop();
    isPlaying4 = false;
    white_player.stop();
  }

  zamanlayiciShared() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int i = 1;
    int y = 1;
    isPlaying4 = true;
    const oneSec = const Duration(milliseconds: 200);
    _zamanlayiciTimer = new Timer.periodic(oneSec, (Timer t) {
      y++;

      white_player.setVolume(0.10);
      /*  int max = 5;
      int min = 0;
      Random rnd = new Random();
      i = min + rnd.nextInt(max - min); */
      i++;
      if (i >= 5) {
        i = 1;
      }
      if (y >= 20) {
        y = 1;
      }
      if (y < 1000) {
        if (y <= 12) {
          //print('hi!');
          if (i == 1) {
            SoundGenerator.setFrequency(prefs.getDouble('f1'));
          } else if (i == 2) {
            SoundGenerator.setFrequency(prefs.getDouble('f2'));
          } else if (i == 3) {
            SoundGenerator.setFrequency(prefs.getDouble('f3'));
          } else if (i == 4) {
            SoundGenerator.setFrequency(prefs.getDouble('f4'));
          }
          SoundGenerator.play();
        } else {
          SoundGenerator.stop();
        }
      } else if (y < 1000) {
        SoundGenerator.stop();
        t.cancel();
        print('bitti');
      }
    });
  }

  @override
  void initState() {
    super.initState();

    isPlaying = false;
    isPlaying1 = false;
    isPlaying2 = false;
    isPlaying3 = false;
    isPlaying4 = false;
    gecmisGirisSayisiEkle();
    gecmisGirisKayitEkle();
    if (whiteCaliyormu() == true) {
      white_player.open(
        Audio("assets/white2.mp3"),
        autoStart: true,
      );
    }

    //sesiSifiraIndir();
    SoundGenerator.init(sampleRate);

    SoundGenerator.onIsPlayingChanged.listen((value) {
      setState(() {
        isPlaying = value;
      });
    });

    SoundGenerator.onOneCycleDataHandler.listen((value) {
      setState(() {
        oneCycleData = value;
      });
    });

    SoundGenerator.setAutoUpdateOneCycleSample(true);
    //Force update for one time
    SoundGenerator.refreshOneCycleData();
  }
}
