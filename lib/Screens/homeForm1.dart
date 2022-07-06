import 'package:first_flutter_app/Models/AlphabetModel.dart';
import 'package:first_flutter_app/src/my_app.dart';
import 'package:flutter/material.dart';

import 'MyBook.dart';


class HomeForm1 extends StatefulWidget {
  const HomeForm1({Key? key}) : super(key: key);



  @override
  _HomeForm1State createState() => _HomeForm1State();
}

class _HomeForm1State extends State<HomeForm1> {
   List<AlphabetModel> items=[
  AlphabetModel("1","A", "Ahmad"),
  AlphabetModel("2","B", "Boy"),
  AlphabetModel("3","C", "Car"),
  AlphabetModel("4","D", "Doctor"),
  AlphabetModel("5","E", "Emirate"),
  AlphabetModel("6","F", "Farm"),
  AlphabetModel("7","G", "Goal"),
  AlphabetModel("8","H", "Haze")
  ];





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
          childAspectRatio: 240/410,
          children: List.generate(items.length, (index) {
            return GestureDetector(
               onTap: ()=>  Navigator.push(context,
                MaterialPageRoute(builder: (context) => MyBook(name: items[index].wordExample))),
                child: Items(id:items[index].Alphabet_id,Arabic:items[index].Alphabet_Arabic,wordExample:items[index].wordExample));})
      )
    );
  }


}
