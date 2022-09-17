import 'package:flutter/material.dart';
import 'package:samplesorder/app/auth/success.dart';
import 'package:samplesorder/app/auth/login.dart';
import 'package:samplesorder/app/auth/signup.dart';
import 'package:samplesorder/app/home.dart';
import 'package:samplesorder/app/orders/add.dart';
import 'package:samplesorder/app/orders/edit.dart';
import 'package:samplesorder/components/cardnote.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'app/orders/mydropdown.dart';
import 'app/orders/test.dart';

late SharedPreferences sharedPref;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  sharedPref = await SharedPreferences
      .getInstance(); // to access shared preferences from any where in app
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'course PHP Rest API',
      initialRoute: sharedPref.getString("id") == null ? "login" : "home",
      //"test",
      routes: {
        "login": (context) => Login(),
        "signup": (context) => SignUp(),
        "home": (context) => Home(),
        "success": (context) => Success(),
        "addorder": (context) => AddOrder(),
        "editorder": (context) => EditOrders(),
        "mydropdown": (context) => MyDropDown(),
      },
    );
  }
}
