import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Users'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  Future<List<User>> _getUsers() async {
     var data = await http.get("http://www.json-generator.com/api/json/get/bYKKPeXRcO?indent=2");
     var jsonData = json.decode(data.body);

     List<User> users= [];
     for(var u in jsonData) {
       User user = User(u["index"], u["about"], u["name"], u["picture"], u["company"], u["email"]);
       users.add(user);
     }

     print("the Number is " + users.length.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
         child: FutureBuilder(
           future: _getUsers(),
           builder: (BuildContext context, AsyncSnapshot asyncSnapshot){

           },
         ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class User {

  final int index;
  final String about;
  final String name;
  final String picture;
  final String company;
  final String email;

  User(this.index, this.about, this.name, this.picture, this.company,
      this.email);
}
