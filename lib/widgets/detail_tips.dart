import 'package:flutter/material.dart';
import 'package:dicoding_project_flutter/models/tips.dart'; //import library model Tips
import 'package:dicoding_project_flutter/service/dbhelper.dart'; //import library dbhelper

class DetailTips extends StatefulWidget { //nama class menggunakan statefull
  final Tips tipsArgs; //variabel yg mengirim data class Tips (sebagai jembatan pada navigasi)
  DetailTips({Key key, this.tipsArgs}) : super(key: key); //key pada class DetailTips

  @override
  _DetailTipsState createState() => _DetailTipsState(); //membuat state
}

class _DetailTipsState extends State<DetailTips> { //state
  DbHelper dbHelper = DbHelper(); //inisialisasi objek class dbhelper
  int count = 0; //variabel count
  List<Tips> tipsList; //variabel list dari class Tips

  @override
  Widget build(BuildContext context) { //widget
    @override
    void initState() { //method initState
      super.initState(); //memanggil method initState dari class induk
    }

    return Scaffold( //mengembalikan nilai scaffold
      appBar: AppBar( //app bar
        title: Text(widget.tipsArgs.namaTips), //judul app bar sesuai dengan nama tips
        backgroundColor: Colors.orangeAccent, //warna bg pada app bar
        centerTitle: true, //agar judul berada ditengah
      ),
      body: Column(//body berbentuk widget kolom
        children: [
          Expanded( //expanded 
            child: Container( //container
              margin: const EdgeInsets.all(30.0), //mengatur jarak ruang
              padding: const EdgeInsets.all(30.0), //mengatur jarak ruang
              child: Text( //text pada body
                widget.tipsArgs.isi, //mengirim data kolom isi dari tabel tips
                style: TextStyle(fontSize: 20, fontStyle: FontStyle.italic), //style text pada body
              ),
            ),
          ),
        ],
      ),
    );
  }
}
