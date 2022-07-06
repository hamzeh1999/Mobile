import 'package:first_flutter_app/Common/comHelper.dart';
import 'package:first_flutter_app/Common/getTextFormField.dart';
import 'package:first_flutter_app/DatabaseHandler/dbHelper.dart';
import 'package:first_flutter_app/DatabaseHandler/dbHelper2.dart';
import 'package:first_flutter_app/Models/AlphabetModel.dart';
import 'package:first_flutter_app/Models/UserModel.dart';
import 'package:first_flutter_app/Screens/homeForm1.dart';
import 'package:first_flutter_app/Screens/loginForm.dart';
import 'package:first_flutter_app/src/my_app.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyBook extends StatefulWidget {
  final String name;
 MyBook({Key? key, required this.name}) : super(key: key);
  @override
  _MyBookState createState() => _MyBookState();
}

class _MyBookState extends State<MyBook> {




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text(widget.name.toString()),
      ),

    );
  }
}
