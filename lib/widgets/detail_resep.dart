import 'package:flutter/material.dart';
import 'package:dicoding_project_flutter/models/resep.dart'; //import library model Resep
import 'package:dicoding_project_flutter/service/dbhelper.dart'; //import library dbhelper

class DetailResep extends StatefulWidget { //nama class menggunakan statefull
  final Resep resepArgs; //variabel yg mengirim data class Resep (sebagai jembatan pada navigasi)
  DetailResep({Key key, this.resepArgs}) : super(key: key); //key pada class DetailResep

  @override
  _DetailResepState createState() => _DetailResepState(); //membuat state
}

class _DetailResepState extends State<DetailResep> { //state
  DbHelper dbHelper = DbHelper(); //inisialisasi objek class dbhelper
  int count = 0; //variabel count
  List<Resep> resepList; //variabel list dari class Resep

  @override
  Widget build(BuildContext context) { //widget
    @override
    void initState() { //method initState
      super.initState(); //memanggil method initState dari class induk
    }

    return DefaultTabController( //memanggil tab bar
      length: 2, //jumlah tab bar
      child: Scaffold( //scaffold
          appBar: AppBar( //app bar
            title: Text(widget.resepArgs.nama), //judul app bar berisi nama pada resep yg dikirim oleh resepArgs
            backgroundColor: Colors.orangeAccent, //warna bg app bar
            centerTitle: true, // agar judul berada ditengah
            bottom: TabBar( //tab bar
              labelColor: Colors.deepOrangeAccent, // warna label 
              unselectedLabelColor: Colors.white, //warna tab yg dipilih
              indicator: BoxDecoration( //box decoration tab
                  borderRadius: BorderRadius.only( //radius border
                    topLeft: Radius.circular(10), //radius kiri atas
                    topRight: Radius.circular(10), //radius kanan atas
                  ),
                  color: Colors.white),//warna yg muncul pada tabs(text)
              tabs: [//tabs pada tab
                Tab(
                  child: Text('Bahan'),// anak pertama pada tabs
                ),
                Tab(
                  child: Text('Steps'), //anak kedua pada tabs
                ),
              ],
            ),
          ),
          body: TabBarView( // body berbentuk tab bar view
            children: [ //mengextends
              Column( //kolom tab bar pertama
                children: [
                  Expanded(//expanded
                    child: Container(
                      margin: const EdgeInsets.all(50.0), //jarak antar ruang
                      padding: const EdgeInsets.all(30.0), //jarak antar ruang luar
                      child: Text(
                        widget.resepArgs.bahan, //menampilkan kolom bahan dari tabel resep
                        style: TextStyle(//style text kolom 
                            fontSize: 20, //ukuran text
                            fontStyle: FontStyle.italic), //font text
                      ),
                    ),
                  ),
                ],
              ),
              Column( //kolom tab bar pertama
                children: [
                  Expanded(//expanded
                    child: Container( //container
                      margin: const EdgeInsets.all(50.0), //jarak antar ruang
                      padding: const EdgeInsets.all(30.0), //jarak antar ruang luar
                      child: Text(
                        widget.resepArgs.step, //menampilkan kolom step dari tabel resep
                        style: TextStyle(//style text kolom 
                            fontSize: 20, //ukuran text
                            fontStyle: FontStyle.italic), //font text
                      ),
                    ),
                  ),
                ],
              ),
            ],
          )),
    );
  }
}
