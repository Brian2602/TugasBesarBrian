import 'package:flutter/material.dart'; //import library material
import 'package:flutter/widgets.dart'; //import library widgets
import 'package:sqflite/sqflite.dart'; //import fungsi dari sqllite
import 'dart:async'; //import fungsi dari asyincron
import 'package:dicoding_project_flutter/service/dbhelper.dart'; //import library dbhelper
import 'package:dicoding_project_flutter/widgets/detail_resep.dart'; //import library class DetailResep
import 'package:dicoding_project_flutter/widgets/form_resep.dart'; //import library FormResep
import 'package:dicoding_project_flutter/models/resep.dart'; //import library ModelResep

//pendukung program asinkron
class UIResep extends StatefulWidget { //nama class menggunakan statefull
  @override
  _UIResepState createState() => _UIResepState(); //membuat state
}

class _UIResepState extends State<UIResep> { //class state
  DbHelper dbHelper = DbHelper(); //inisialisasi objek class dbhelper
  int count = 0; //variabel count
  List<Resep> resepList; //variabel list dari class Resep

  @override
  Widget build(BuildContext context) { //widget
    updateListView(); //menampilkan data list yg sudah terupdate pada halaman
    @override
    void initState() { //method initState
      super.initState();//memanggil method initState dari class induk
      updateListView(); //menampilkan data list yg sudah terupdate
    }

    if (resepList == null) { //jika list resep kosong
      resepList = List<Resep>(); //list memanggil List dari class Resep untuk diisi
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
          'Resep Masakan',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold), //style text judul
        ),
        backgroundColor: Colors.orangeAccent, //warna bg app bar
        centerTitle: true, //agar judul berada ditengah
      ),
      body: Column( //body berbentuk widget kolom
        children: [
          Expanded( //anak pertama body
            child: createListView(), //menampilkan method createListView
          ),
          Container( //anak kedua body
            child: FloatingActionButton( //berbentuk button lingkaran
              onPressed: () async { //saat diklik
                var resep = await navigateToEntryForm(context, null); //memanggil method untuk mengisi form
                if (resep != null) { //jika data resep sudah terisi
                  int result = await dbHelper.insertResep(resep); // variabel result akan mengisi data resep dengan method insertResep
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

  Future<Resep> navigateToEntryForm(BuildContext context, Resep resep) async { //method mengisi form tabel resep
    var result = await Navigator.push(context, // variabel result untuk memanggil navigasi
        MaterialPageRoute(builder: (BuildContext context) { // route navigasi 
      return FormResep(resep); // memanggil  class FormResep untuk mengisi data pada tabel resep 
    }));
    return result; // mengembalikan nilai result
  }

  ListView createListView() { //method membuat list view
    TextStyle textStyle = Theme.of(context).textTheme.headline5; //style text
    return ListView.builder( //mengembalikan nilai listview yaitu builder
        itemCount: count, //jumlah item pada builder
        itemBuilder: (BuildContext context, int index) { //data pada builder
          final resep = resepList[index]; //variabel resep yang mengirimkan index pada list resep
          return Card( //card
            color: Colors.white, //warna card
            elevation: 3.0,
            child: ListTile( //list berbentuk listtile
              title: Text( //judul
                this.resepList[index].nama, //judul sesuai nama index pada list resep
              ),
              subtitle: Text('Klik for details'), //subtitle pada list tile
              trailing: GestureDetector( //gesture detector
                  child: PopupMenuButton(//button pada gesture yang berbentuk popup menu
                    onSelected: (value){//ketika diklik mengirimkan value
                      value();//method value
                    },
                itemBuilder: (context) => [ //data builder pada menu button
                  PopupMenuItem( //menu popup button pertama
                      child: Row( //berbentuk row
                        children: [
                          Text('Edit'), //text ke-1 yang muncul pada button pop ketika diklik
                        ],
                      ),
                      value: () async { //method value yang dipanggil
                        var resep = await navigateToEntryForm( //variabel resep untuk mengisi form dengan memanggil method navigateToEntryForm
                            context, this.resepList[index]);//parameter method
                        //panggil fungsi untuk edit data
                        if (resep != null) { //jika resep terisi
                          dbHelper.updateResep(resep);//memanggil dbhelper untuk mengupdate data resep
                          updateListView();//menampilkan data yang sudah diupdate
                        }
                      }
                    ),
                  PopupMenuItem( //menu popup button kedua
                      child: Row( //berbentuk row
                        children: [
                          Text('Hapus'), //text ke-2 yang muncul pada button pop ketika diklik
                        ],
                      ),
                      value: () async { //method value yang dipanggil
                        //Panggil Fungsi untuk Delete dari DB
                        dbHelper.deleteResep(this.resepList[index].id);//memanggil dbhelper untuk menghapus data resep dengan parameter id resep
                        updateListView();//menampilkan data yang sudah diupdate (data yg dihapus akan hilang)
                        }
                    )
                ],
                child: Icon(Icons.more_vert),//icon pada button pop
                ),
              ),
              //ke detail resep
              onTap: () async { //fungsi saat listview diklik
                Navigator.push(//navigasi push
                    context,
                    MaterialPageRoute(//versi 2
                        builder: (context) => DetailResep(resepArgs: resep)));//memanggil class DetailResep dgn parameter resepArgs
              },
            ),
          );
        });
  }

//fungsi update listview resep
  void updateListView() {
    final Future<Database> dbFuture = dbHelper.initDb();// inisialisasi objek class Database
    dbFuture.then((database) {//database yg dipilih
      //TODO 1 Select data dari DB
      Future<List<Resep>> resepListFuture = dbHelper.getResepList();//inisialisasi objek class Resep
      resepListFuture.then((resepList) {//list resep yg dipilih
        setState(() {
          this.resepList = resepList; //variabel list resep
          this.count = resepList.length; //jumlah list resep sesuai dgn jumlah yg ada
        });
      });
    });
  }
}
