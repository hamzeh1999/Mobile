import 'package:first_flutter_app/Screens/loginForm.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Screens/homeForm.dart';

Future<void> main() async {
  // runApp(const MyApp());
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();

  var status = prefs.getBool('isLoggedIn') ?? false;
  print("Is There a User? : ${status.toString()}");
  runApp(MaterialApp( debugShowCheckedModeBanner: false,home: status == true ?HomeForm() : LoginForm() ));


}

