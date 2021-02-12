import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tinnius_therapy/controllers/gecmisekle.dart';

class Gecmis extends StatefulWidget {
  @override
  _GecmisState createState() => _GecmisState();
}

class _GecmisState extends State<Gecmis> {
  Future<String> datacekici(String string) async {
    String string2 = string;
//sharedpref fonksiyon cagirma
    SharedPreferences prefs = await SharedPreferences.getInstance();

//read data
    String phone = prefs.getString('$string2');
    return phone;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Geçmiş'),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              /*  RaisedButton(
                  child: Text('shared'),
                  onPressed: () {
                    gecmisGirisSayisiEkle();
                    gecmisGirisKayitEkle();
                  }), */
              SizedBox(height: 20),
              Column(
                children: List.generate(200, (index) {
                  //return Text(datacekici('kayit$index').toString());
                  return FutureBuilder<String>(
                      future: datacekici('kayit$index'),
                      builder: (context, AsyncSnapshot<String> snapshot) {
                        if (snapshot.hasData) {
                          return Text('         kayıt (${index + 1}) : ' +
                              snapshot.data);
                        } else if (snapshot.data == 'a') {
                          //return CircularProgressIndicator();
                          return Text('');
                        } else {
                          //return CircularProgressIndicator();
                          return Text('');
                        }
                      });
                }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
