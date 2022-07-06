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

class HomeForm extends StatefulWidget {
  @override
  _HomeFormState createState() => _HomeFormState();
}

class _HomeFormState extends State<HomeForm> {
  List<AlphabetModel> items = [
    AlphabetModel("1", "A", "Ahmad"),
    AlphabetModel("2", "B", "Boy"),
    AlphabetModel("3", "C", "Car"),
    AlphabetModel("4", "D", "Doctor"),
    AlphabetModel("5", "E", "Emarite"),
    AlphabetModel("6", "F", "Farm"),
    AlphabetModel("7", "G", "Goal"),
    AlphabetModel("8", "H", "Hamzeh")
  ];

  final _formKey = GlobalKey<FormState>();
  final Future<SharedPreferences> _pref = SharedPreferences.getInstance();

  late DbHelper dbHelper;

  late DbHelper2 dbHelper2;

  final _conUserId = TextEditingController();
  final _conDelUserId = TextEditingController();
  final _conUserName = TextEditingController();
  final _conEmail = TextEditingController();
  final _conPassword = TextEditingController();
  final _conbirth = TextEditingController();

  @override
  void initState() {
    super.initState();
    getUserData();
    dbHelper = DbHelper();
    dbHelper2 = DbHelper2();
  }

  Future<void> getUserData() async {
    final SharedPreferences sp = await _pref;

    setState(() {
      int finalNumber = DateTime.now().year - sp.getInt('birth');
      _conbirth.text = finalNumber.toString();
      _conUserId.text = sp.getString("user_id");
      _conDelUserId.text = sp.getString("user_id");
      _conUserName.text = sp.getString("user_name");
      _conEmail.text = sp.getString("email");
      _conPassword.text = sp.getString("password");
    });
  }

  update() async {
    String uid = _conUserId.text;
    String uname = _conUserName.text;
    String email = _conEmail.text;
    String passwd = _conPassword.text;
    String birth = _conbirth.text;

    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      UserModel user = UserModel(uid, uname, email, passwd, int.parse(birth));
      await dbHelper.updateUser(user).then((value) {
        if (value == 1) {
          alertDialog(context, "Successfully Updated");

          updateSP(user, true).whenComplete(() {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => LoginForm()),
                    (Route<dynamic> route) => false);
          });
        } else {
          alertDialog(context, "Error Update");
        }
      }).catchError((error) {
        print("error::::::::::::::::::" + error);
        alertDialog(context, "Error");
      });
    }
  }

  Future<void> insertAlphabet() async {
    for (int i = 0; i < 8; i++) {
      await insertThem(items[i]);
    }
  }

  insertThem(AlphabetModel model) async {
    AlphabetModel uModel = AlphabetModel(
        model.Alphabet_id, model.Alphabet_Arabic, model.wordExample);
    print(
        "Alphabet_id : ${model.Alphabet_id} Alphabet_Arabic:${model.Alphabet_Arabic}   wordExample:${model.wordExample}");

    await dbHelper2.saveData(uModel).then((userData) {
      alertDialog(context, "Items Insert");
    }).catchError((error) {
      print("Error : " + error);
      alertDialog(context, "Error: Items Insert Fail");
    });
  }

  delete() async {
    final SharedPreferences sp = await _pref;

    String delUserID = _conDelUserId.text;

    await dbHelper.deleteUser(delUserID).then((value) {
      if (value == 1) {
        alertDialog(context, "Successfully LogOut");
        sp.setBool("isLoggedIn", false);

        updateSP(null as UserModel, false).whenComplete(() {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => LoginForm()),
                  (Route<dynamic> route) => false);
        });
      }
    });
  }

  Future updateSP(UserModel user, bool add) async {
    final SharedPreferences sp = await _pref;

    if (add) {
      sp.setString("user_name", user.user_name);
      sp.setString("email", user.email);
      sp.setString("password", user.password);
    } else {
      sp.remove('user_id');
      sp.remove('user_name');
      sp.remove('email');
      sp.remove('password');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Form(
        key:_formKey ,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 20.0),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      //Update
                      getTextFormField(
                          controller: _conbirth,
                          icon: Icons.date_range,
                          isEnable: false,
                          hintName: 'Age'),
                      SizedBox(height: 5.0),

                      getTextFormField(
                          controller: _conUserId,
                          isEnable: false,
                          icon: Icons.person,
                          hintName: 'User ID'),
                      SizedBox(height: 10.0),
                      getTextFormField(
                          controller: _conUserName,
                          icon: Icons.person_outline,
                          inputType: TextInputType.name,
                          hintName: 'User Name'),

                      SizedBox(height: 10.0),
                      getTextFormField(
                          controller: _conEmail,
                          icon: Icons.email,
                          inputType: TextInputType.emailAddress,
                          hintName: 'Email'),
                      SizedBox(height: 10.0),
                      getTextFormField(
                        controller: _conPassword,
                        icon: Icons.lock,
                        hintName: 'Password',
                        isObscureText: true,
                      ),
                      SizedBox(height: 2.0),
                      Container(
                        margin: EdgeInsets.all(30.0),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        child: FlatButton(
                          onPressed: update,
                          child: Text(
                            'Update',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      SizedBox(height: 2.0),

                      Container(
                        margin: EdgeInsets.all(30.0),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        child: FlatButton(
                          onPressed: (){
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) => HomeForm1()));
                          },
                          child: Text(
                            'Show ALPHABET',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      SizedBox(height: 2.0),
                      Container(
                        margin: EdgeInsets.all(30.0),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        child: FlatButton(
                          onPressed: delete,
                          child: Text(
                            'Delete',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      SizedBox(height: 2.0),
                      Container(
                        margin: EdgeInsets.all(30.0),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        child: FlatButton(
                          onPressed: () async{
                            final SharedPreferences sp = await _pref;

                            sp.setBool("isLoggedIn", false);
                            setState((){});
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(builder: (_) => LoginForm()),
                                    (Route<dynamic> route) => false);
                          },
                          child: Text(
                            'Log Out',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),

                    ],
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
