import 'package:flutter/widgets.dart'; //import library widgets
import 'package:flutter/material.dart';
import 'package:dicoding_project_flutter/widgets/home.dart';//import library class HomePage

void main() { //method main
  runApp(MyApp());
}

class MyApp extends StatefulWidget { // class MyApp
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState(); //memanggil state 
}

class _MyAppState extends State<MyApp> { //class state
  @override
  Widget build(BuildContext context) {//widget
    return MaterialApp( //mengembalikan nilai MaterialApp
      debugShowCheckedModeBanner: false, // menghilangkan bendera debug
      title: 'Catatan Resep App', // judul
      theme: ThemeData( //tema
        primarySwatch: Colors.orange, //berwarna orange
      ),
      home: HomePage() //memanggil class HomePage
    );
  }
}
