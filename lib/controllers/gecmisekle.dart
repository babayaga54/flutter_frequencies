import 'package:shared_preferences/shared_preferences.dart';

gecmisGirisSayisiEkle() async {
  print('gecmisEkle1');
  SharedPreferences prefs = await SharedPreferences.getInstance();
  print('gecmisEkle2');
  int girissayisi = prefs.getInt('girissayisi');
  print('gecmisEkle3');
  print(DateTime.now());
  if (girissayisi == null) {
    prefs.setInt('girissayisi', 0);
  }
  girissayisi = prefs.getInt('girissayisi') + 1;
  prefs.setInt('girissayisi', girissayisi);

  print('toplam giriş sayısı:' + prefs.getInt('girissayisi').toString());
  //return girissayisi;
}

gecmisGirisKayitEkle() async {
  print('gecmisEkle1');
  SharedPreferences prefs = await SharedPreferences.getInstance();
  print('gecmisEkle2');
  int girissayisi = prefs.getInt('girissayisi');
  prefs.setString(
      'kayit${girissayisi.toString()}', '${DateTime.now().toString()}');
  print('kayit eklendi :' + prefs.getString('kayit${girissayisi.toString()}'));
}

whiteCaliyormu() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  bool whiteCal = prefs.getBool('whitenoise');
  print('white noise degeri : ' + whiteCal.toString());
  if (whiteCal == true) {
    return true;
  }
}

gecmisSil() async {
  print('gecmisSil1');
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setInt('girissayisi', 0);
  print('gecmisSil1');
  for (int a = 0; a <= 200; a++) {
    try {
      prefs.remove('kayit$a');
    } catch (exception) {
      print(exception);
    }
  }

/*
    print('gecmisSil3');
    prefs.setString('kayit$a', '');
    print('gecmisSil4');
    
    print('gecmisSil5');
    print('kayit silindi :' + prefs.getString('kayit$a')); */
}
