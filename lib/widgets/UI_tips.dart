import 'package:flutter/material.dart'; //import library material
import 'package:flutter/widgets.dart'; //import library widgets
import 'package:sqflite/sqflite.dart'; //import fungsi dari sqllite
import 'dart:async'; //import fungsi dari asyincron
import 'package:dicoding_project_flutter/service/dbhelper.dart'; //import library dbhelper
import 'package:dicoding_project_flutter/widgets/form_tips.dart'; //import library class FormTips
import 'package:dicoding_project_flutter/models/tips.dart'; //import library class Tips
import 'package:dicoding_project_flutter/widgets/detail_tips.dart'; //import library DetailTips

//pendukung program asinkron
class UITips extends StatefulWidget { //nama aclass menggunakan statefull
  @override
  _UITipsState createState() => _UITipsState(); //membuat state
}

class _UITipsState extends State<UITips> { //class state
  DbHelper dbHelper = DbHelper(); //inisialisasi objek class dbhelper
  int count = 0; //variabel count
  List<Tips> tipsList; //variabel list dari class Tips

  @override
  Widget build(BuildContext context) { //widget
    updateListView(); //menampilkan data list yg sudah terupdate pada halaman
    @override
    void initState() { //method initState
      super.initState();//memanggil method initState dari class induk
      updateListView(); //menampilkan data list yg sudah terupdate
    }

    if (tipsList == null) { //jika list tips kosong
      tipsList = List<Tips>(); //list memanggil List dari class Tips untuk diisi
    }
    return Scaffold( //scaffold
      appBar: AppBar( //app bar
        actions: [//memberi aksi
          IconButton( //button berbentuk icon pada bar
              onPressed: () { //saat diklik
                Navigator.pop(context); //kembali ke navigasi sebelumnya (homepage)
              },
              icon: Icon(Icons.home_filled))//icon berbentuk rumah
        ],
        title: Text( //judul bar
          'List Belanja',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold), //style text judul
        ),
        backgroundColor: Colors.orangeAccent, //warna bg app bar
        centerTitle: true, //agar judul berada ditengah
      ),
      body: Column( //body berbentuk widget kolom
        children: [
          Expanded( //anak pertama body
            child: createListView(),  //menampilkan method createListView
          ),
          Container(//anak kedua body
            child: FloatingActionButton( //berbentuk button lingkaran
              onPressed: () async { //saat diklik
                var tips = await navigateToEntryForm(context, null); //memanggil method untuk mengisi form
                if (tips != null) { //jika data tips sudah terisi
                  int result = await dbHelper.insertTips(tips); // variabel result akan mengisi data tips dengan method inserTips
                  if (result > 0) {  //jika result lebih dari 0
                    updateListView(); //method update list view akan dipanggil
                  }
                }
              },
              child: Icon(Icons.add), //icon pada button
            ),
          ),
        ],
      ),
    );
  }

  Future<Tips> navigateToEntryForm(BuildContext context, Tips tips) async { //method mengisi form tabel tips
    var result = await Navigator.push(context, // variabel result untuk memanggil navigasi
        MaterialPageRoute(builder: (BuildContext context) { // route navigasi 
      return FormTips(tips); // memanggil  class FormTips untuk mengisi data pada tabel tips
    }));
    return result; // mengembalikan nilai result
  }

  ListView createListView() {
    TextStyle textStyle = Theme.of(context).textTheme.headline5;
    return ListView.builder(
        itemCount: count,
        itemBuilder: (BuildContext context, int index) {
          final tips = tipsList[index];
          return Card(
            color: Colors.white,
            elevation: 3.0,
            child: ListTile(
              title: Text(
                this.tipsList[index].namaTips,
                style: textStyle,
              ),
              subtitle: Text('Klik for details'),
              trailing: GestureDetector(
                  child: PopupMenuButton(
                    onSelected: (value){
                      value();
                    },
                itemBuilder: (context) => [
                  PopupMenuItem(
                      child: Row(
                        children: [
                          Text('Edit'),
                        ],
                      ),
                      value: () async {
                        var tips = await navigateToEntryForm(
                            context, this.tipsList[index]);
                        //panggil fungsi untuk edit data
                        if (tips != null) {
                          dbHelper.updateTips(tips);
                          updateListView();
                        }
                      }
                    ),
                  PopupMenuItem(
                      child: Row(
                        children: [
                          Text('Hapus'),
                        ],
                      ),
                      value: () async {
                        //Panggil Fungsi untuk Delete dari DB
                        dbHelper.deleteTips(this.tipsList[index].idTips);
                        updateListView();
                      }
                    )
                ],
                child: Icon(Icons.more_vert),
                ),
              ),
              //ke detail tips
              onTap: () async {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DetailTips(tipsArgs: tips)));
              },
            ),
          );
        });
  }

//fungsi update listview tips
  void updateListView() {
    final Future<Database> dbFuture = dbHelper.initDb();
    dbFuture.then((database) {
      //TODO 1 Select data dari DB
      Future<List<Tips>> tipsListFuture = dbHelper.getTipsList();
      tipsListFuture.then((tipsList) {
        setState(() {
          this.tipsList = tipsList;
          this.count = tipsList.length;
        });
      });
    });
  }
}
