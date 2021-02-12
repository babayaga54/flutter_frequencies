import 'package:shared_preferences/shared_preferences.dart';

Future sharedPrefArchive() async {
  //sharedpref fonksiyon cagirma
  SharedPreferences prefs = await SharedPreferences.getInstance();
  //save data
  prefs.setString('phone', "905345983290");
  //delete data
  prefs.remove("phone");
  //update data
  prefs.setString('data', "fine");

  //read data
  String phone = prefs.getString('phone');
  return phone;
}

Future tokenSil() async {
  //sharedpref fonksiyon cagirma
  SharedPreferences prefs = await SharedPreferences.getInstance();

  //save data
  prefs.setString('phone', "905345983290");

  //delete data
  prefs.remove("phone");

  //read data
  String phone = prefs.getString('phone');
  return phone;
}
