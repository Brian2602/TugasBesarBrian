import 'package:sqflite/sqflite.dart'; //import fungsi dari sqllite
import 'dart:async'; //import fungsi dari asyincron
import 'dart:io'; //import fungsi dari io
import 'package:path_provider/path_provider.dart'; //import fungsi dari path provider
import 'package:dicoding_project_flutter/models/resep.dart'; //import fungsi dari model resep
import 'package:dicoding_project_flutter/models/tips.dart'; //import fungsi dari model tips

class DbHelper{ //nama class
  static DbHelper _dbHelper; //objek class dbhelper
  static Database _database; //objek class database

  DbHelper._createObject(); //inisialisasi dbhelper untuk membuat objek database
  Future<Database> initDb() async{
    //untuk menentukan nama database dan lokasi yg dibuat
    Directory directory = await getApplicationSupportDirectory();
    String path = directory.path + 'resep.db'; //nama database
    //create, read databases
    var resepDatabase = openDatabase(path, version: 5, onCreate: _createDb);
    //return nilai object sbg hasil dr fungsi
    return resepDatabase;
  }

  //buat tabel baru dgn nama resep, atribut: id, nama, bahan, step
  void _createDb(Database db, int version) async{ //method create tabel dgn parameter objek database & versinya
    await db.execute(''' 
    CREATE TABLE resep(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      nama TEXT,
      bahan TEXT,
      step TEXT
    )
    ''');

    //buat tabel baru dgn nama tips, atribut : id, nama, isi
      await db.execute('''
    CREATE TABLE tips(
      idTips INTEGER PRIMARY KEY AUTOINCREMENT,
      namaTips TEXT,
      isi TEXT
    )
    ''');
  }

  //SELECT DATABASES//
  //tabel resep
  Future<List<Map<String, dynamic>>> selectResep() async { //method mengambil data tabel resep dari database
    Database db = await this.initDb(); //inisialisasi db
    var mapList = await db.query('resep', orderBy: 'nama'); //variabel yg mengirim data yg akan diambil dari tabel resep
    return mapList; //mengembalikan nilai variabel map
  }
  //tabel tips
  Future<List<Map<String, dynamic>>> selectTips() async { //method mengambil data tabel tips dari database
    Database db = await this.initDb(); //inisialisasi db
    var mapList = await db.query('tips', orderBy: 'namaTips'); //variabel yg mengirim data yg akan diambil dari tabel tips
    return mapList; //mengembalikan nilai variabel map
  }

  //CREATE DATABASES//
  //tabel resep
  Future<int> insertResep(Resep object) async { //method menambah data pada tabel resep
    Database db = await this.initDb(); //inisialisasi db
    int count = await db.insert('resep', object.toMap()); //menambahkan objek map pada tabel resep yg jumlahnya sesuai dengan atributnya
    return count; //mengembalikan jumlah data objek
  }
  //tabel tips
  Future<int> insertTips(Tips object) async { //method menambah data pada tabel tips
    Database db = await this.initDb(); //inisialisasi db
    int count = await db.insert('tips', object.toMap()); //menambahkan objek map pada tabel resep yg jumlahnya sesuai dengan atributnya
    return count; //mengembalikan jumlah data objek
  }

  //UPDATE DATABASES//
  //tabel resep
  Future<int> updateResep(Resep object) async { //method mengupdate database dari tabel resep
    Database db = await this.initDb(); //inisialisasi db
    int count = await db.update( //mengupdate data  sesuai jumlah data
      'resep', object.toMap(), //dari tabel resep, dan memanggilkan objek dari map
      where: 'id=?', //dimana id resep
      whereArgs: [object.id] //sesuai dengan id objeknya
      );
    return count; //mengembalikan nilai count
  }  
  //tabel tips
  Future<int> updateTips(Tips object) async { //method mengupdate database dari tabel resep
    Database db = await this.initDb(); //inisialisasi db
    int count = await db.update( //mengupdate data  sesuai jumlah data
      'tips', object.toMap(), //dari tabel tips, dan memanggilkan objek dari map
      where: 'idTips=?', //dimana id tips
      whereArgs: [object.idTips] //sesuai dengan id objeknya
      );
    return count; //mengembalikan nilai count
  }  

  //DELETE DATABASES
  //tabel resep
  Future<int> deleteResep(int id) async { //method mengupdate database dari tabel resep
    Database db = await this.initDb(); //inisialisasi db
    int count = await db.delete( //mengupdate data  sesuai jumlah data
               'resep', //dari tabel resep
                where: 'id=?', //dimana id resep
                whereArgs: [id]); //sesuai dengan id resep yg dikirimkan
    return count; //mengembalikan nilai count
  }
  //tabel tips
  Future<int> deleteTips(int idTips) async { //method mengupdate database dari tabel tips
    Database db = await this.initDb(); //inisialisasi db
    int count = await db.delete( //mengupdate data sesuai jumlah data
               'tips', //dari tabel tips
                where: 'idTips=?', //dimana id resep
                whereArgs: [idTips]); //sesuai dengan id tips yg dikirimkan
    return count; //mengembalikan nilai count
  }
  
  //GET TABLE//
  //tabel resep
  Future<List<Resep>> getResepList() async {//method untuk mengirimkan/mengambil data dari tabel resep
    var resepMapList = await selectResep(); //variabel untuk mengambil data tabel resep dengan method selectResep
    int count = resepMapList.length; //mengambil data dengan maplist sesuai dengan length tabel
    List<Resep> resepList = List<Resep>(); //list untuk tabel resep
    for (int i=0; i<count; i++) {//perulangan untuk menambahkan data
      resepList.add(Resep.fromMap(resepMapList[i]));//menambahkan data pada maplist
    }
    return resepList;//mengembalikan list tabel resep
  }

  //tabel tips
  Future<List<Tips>> getTipsList() async {//method untuk mengirimkan/mengambil data dari tabel tips
    var tipsMapList = await selectTips(); //variabel untuk mengambil data tabel tips dengan method selectTips
    int count = tipsMapList.length; //mengambil data dengan maplist sesuai dengan length tabel
    List<Tips> tipsList = List<Tips>(); //list untuk tabel tips
    for (int i=0; i<count; i++) {//perulangan untuk menambahkan data
      tipsList.add(Tips.fromMap(tipsMapList[i]));//menambahkan data pada maplist
    }
    return tipsList;//mengembalikan list tabel tips
  }
  
  factory DbHelper() { //model factory dbhelper
  if (_dbHelper == null) { //jika dbhelper bernilai null
    _dbHelper = DbHelper._createObject(); // maka db helper akan membuat objek
    }
    return _dbHelper; // mengembalikan nilai dbhelper
  }
  
  Future<Database> get database async { //method mengirim/menampilkan databse
  if (_database == null) { //jika database bernilai null
    _database = await initDb(); //database akan menunggu 
    }
    return _database; //mengembalikan nilai database
  }
}