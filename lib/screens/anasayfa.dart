import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sound_generator/sound_generator.dart';
import 'package:sound_generator/waveTypes.dart';

class AnaSayfa extends StatefulWidget {
  @override
  _AnaSayfaState createState() => _AnaSayfaState();
}

class _AnaSayfaState extends State<AnaSayfa> {
  bool isPlaying = false;
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

  @override
  void initState() {
    super.initState();
    isPlaying = false;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AnaSayfa'),
      ),
      body: Center(
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  'Ana Frekans  ' + this.frequency.toStringAsFixed(2),
                  style: TextStyle(fontSize: 30),
                ),
                SizedBox(width: 10),
                CircleAvatar(
                    radius: 25,
                    backgroundColor: Colors.lightBlueAccent,
                    child: IconButton(
                        icon: Icon(isPlaying ? Icons.stop : Icons.play_arrow),
                        onPressed: () {
                          SoundGenerator.setFrequency(1000);
                          SoundGenerator.setBalance(0);
                          SoundGenerator.setVolume(1);

                          isPlaying
                              ? SoundGenerator.stop()
                              : SoundGenerator.play();
                        })),
              ],
            ),
            Column(
              children: [
                Row(
                  children: [
                    Text('f = ' + this.frequency.toStringAsFixed(2) + " Hz"),
                    SizedBox(width: 10),
                    CircleAvatar(
                        radius: 10,
                        backgroundColor: Colors.lightBlueAccent,
                        child: IconButton(
                            icon:
                                Icon(isPlaying ? Icons.stop : Icons.play_arrow),
                            onPressed: () {
                              if (this.frequency.toInt() <= 30) {
                                SoundGenerator.stop();
                              } else {
                                SoundGenerator.play();
                              }

                              // SoundGenerator.setFrequency(1000);
                              //SoundGenerator.setBalance(0);
                              SoundGenerator.setVolume(1);
                              /*
                              isPlaying
                                  ? SoundGenerator.stop()
                                  : SoundGenerator.play(); */
                            })),
                  ],
                ),
                Row(
                  children: [
                    Text('f = ' + this.frequency1.toStringAsFixed(2) + " Hz"),
                    SizedBox(width: 10),
                    CircleAvatar(
                        radius: 10,
                        backgroundColor: Colors.lightBlueAccent,
                        child: IconButton(
                            icon:
                                Icon(isPlaying ? Icons.stop : Icons.play_arrow),
                            onPressed: () {
                              SoundGenerator.setFrequency(1000);
                              SoundGenerator.setBalance(0);
                              SoundGenerator.setVolume(1);

                              isPlaying
                                  ? SoundGenerator.stop()
                                  : SoundGenerator.play();
                            })),
                  ],
                ),
                Row(
                  children: [
                    Text('f = ' + this.frequency2.toStringAsFixed(2) + " Hz"),
                    SizedBox(width: 10),
                    CircleAvatar(
                        radius: 10,
                        backgroundColor: Colors.lightBlueAccent,
                        child: IconButton(
                            icon:
                                Icon(isPlaying ? Icons.stop : Icons.play_arrow),
                            onPressed: () {
                              SoundGenerator.setFrequency(1000);
                              SoundGenerator.setBalance(0);
                              SoundGenerator.setVolume(1);

                              isPlaying
                                  ? SoundGenerator.stop()
                                  : SoundGenerator.play();
                            })),
                  ],
                ),
                Row(
                  children: [
                    Text('f = ' + this.frequency3.toStringAsFixed(2) + " Hz"),
                    SizedBox(width: 10),
                    CircleAvatar(
                        radius: 10,
                        backgroundColor: Colors.lightBlueAccent,
                        child: IconButton(
                            icon:
                                Icon(isPlaying ? Icons.stop : Icons.play_arrow),
                            onPressed: () {
                              SoundGenerator.setFrequency(1000);
                              SoundGenerator.setBalance(0);
                              SoundGenerator.setVolume(1);

                              isPlaying
                                  ? SoundGenerator.stop()
                                  : SoundGenerator.play();
                            })),
                  ],
                ),
                Row(
                  children: [
                    Text('f = ' + this.frequency4.toStringAsFixed(2) + " Hz"),
                    SizedBox(width: 10),
                    CircleAvatar(
                        radius: 10,
                        backgroundColor: Colors.lightBlueAccent,
                        child: IconButton(
                            icon:
                                Icon(isPlaying ? Icons.stop : Icons.play_arrow),
                            onPressed: () {
                              SoundGenerator.setFrequency(1000);
                              SoundGenerator.setBalance(0);
                              SoundGenerator.setVolume(1);

                              isPlaying
                                  ? SoundGenerator.stop()
                                  : SoundGenerator.play();
                            })),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
