import 'package:first_flutter_app/Common/comHelper.dart';
import 'package:first_flutter_app/Models/AlphabetModel.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import 'dart:io' as io;


class DbHelper2 {
  Database ?_db;
  static const String DB_Name = 'test.db';
  static const String Table_User = 'Alphabet';
  static const int Version = 1;

  static  const  String C_Alphabet_id='Alphabet_id';
  static const String C_Alphabet_Arabic = 'Alphabet_Arabic';
  static const String C_wordExample = 'wordExample';


  Future<Database?> get db async {
    if (_db != null) {
      insertAlphabet();
      return _db;
    }
    _db = await initDb();
    return _db;
  }

  initDb() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = "${documentsDirectory.path}+ $DB_Name";
    var db = await openDatabase(path, version: Version, onCreate: _onCreate);
    insertAlphabet();

    return db;
  }

  _onCreate(Database db, int intVersion) async {
    await db.execute("CREATE TABLE $Table_User ("
        " $C_Alphabet_id INTEGER, "
        " $C_Alphabet_Arabic TEXT, "
        " $C_wordExample TEXT, "
        " PRIMARY KEY ($C_Alphabet_id)"
        ")");
  }

  Future<int?> saveData(AlphabetModel model) async {
    var dbClient = await db;
    var res = await dbClient?.insert(Table_User, model.toMap());
    return res;
  }
  late Map <String,dynamic> items;
  late DbHelper2 dbHelper2;

  void insertAlphabet() async {

    items["A"]= AlphabetModel("1","A", "Ahmad");
    items["B"]= AlphabetModel("2","B", "Boy");
    items["C"]= AlphabetModel("3","C", "Car");
    items["D"]= AlphabetModel("4","D", "Doctor");
    items["E"]= AlphabetModel("5","E", "Emarite");
    items["F"]= AlphabetModel("6","F", "Farm");
    items["G"]= AlphabetModel("7","G", "Goal");
    items["H"]= AlphabetModel("8","H", "Hamzeh");

    for(int i=0;i<8;i++) {
      await insertThem(items[i]);
    }


  }

  insertThem(AlphabetModel model) async {

    AlphabetModel uModel = AlphabetModel(model.Alphabet_id,model. Alphabet_Arabic,model.wordExample);
    print("Alphabet_id : ${model.Alphabet_id} Alphabet_Arabic:${model.Alphabet_Arabic}   wordExample:${model.wordExample}");

    await dbHelper2.saveData(uModel).then((userData) {

    }).catchError((error) {
      print("Error : "+error);});
  }

  // Future<UserModel?> getLoginUser(String userId, String password) async {
  //   var dbClient = await db;
  //   var res = await dbClient?.rawQuery("SELECT * FROM $Table_User WHERE "
  //       "$C_UserID = '$userId' AND "
  //       "$C_Password = '$password'");
  //
  //   if (res!.length > 0) {
  //     return UserModel.fromMap(res!.first);
  //   }
  //
  //   return null;
  // }
  //
  // Future<int?> updateUser(UserModel user) async {
  //   var dbClient = await db;
  //   var res = await dbClient?.update(Table_User, user.toMap(),
  //       where: '$C_UserID = ?', whereArgs: [user.user_id]);
  //   return res;
  // }
  //
  // Future<int?> deleteUser(String user_id) async {
  //   var dbClient = await db;
  //   var res = await dbClient
  //       ?.delete(Table_User, where: '$C_UserID = ?', whereArgs: [user_id]);
  //   return res;
  // }
}