import 'package:flutter/material.dart';
import 'package:dicoding_project_flutter/models/tips.dart'; //import library class Tips

class FormTips extends StatefulWidget {  //nama class menggunakan statefull
  final Tips tips; //variabel yg mengirim data class Tips
  FormTips(this.tips); //objek class FormTips

  @override
  FormTipsState createState() => FormTipsState(this.tips);  //membuat state
}

//class controller
class FormTipsState extends State<FormTips> { //state
  Tips tips; //variabel tips
  FormTipsState(this.tips);//objek class FormTipsState

  TextEditingController namaTipsController = TextEditingController(); //controller nama tabel tips
  TextEditingController isiController = TextEditingController(); //controller isi tabel tips

  @override
  Widget build(BuildContext context) { //widget
    //kondisi
    if (tips != null) { //jika tips sudah terisi
      namaTipsController.text = tips.namaTips; //memanggil kontroler nama
      isiController.text = tips.isi; //memanggil kontroler isi
    }
    //merubah
    return Scaffold(//scaffold
        appBar: AppBar( //app bar
          title: tips == null ? Text('Tambah') : Text('Edit'), //title pada app bar, jika tips masih kosong app bar akan memunculkan text 'Tambah' jika sudah terisi app bar akan emnampilkan text 'Edit'
        ),
        body: Padding( //body berbentuk widget padding
            padding: EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0), //mengatur jarak
            child: ListView( //listview
              children: [
                //mengisi data nama
                Padding( //padding
                  padding: EdgeInsets.only(top: 20.0, bottom: 20.0), //mengatur jarak
                  child: TextField( //menampilkan text field
                    controller: namaTipsController, //untuk mengisi data kolom nama
                    keyboardType: TextInputType.text, //type keyboard untuk mengisi data nama
                    decoration: InputDecoration( //dekorasi inputan
                      labelText: 'Judul List', // label pada text field
                      border: OutlineInputBorder( //outline pada border
                        borderRadius: BorderRadius.circular(10.0), //radius pada border
                      ),
                    ),
                  ),
                ),

                //mengisi data nama
                Padding( //padding
                  padding: EdgeInsets.only(top: 20.0, bottom: 20.0), //mengatur jarak
                  child: TextField( //menampilkan text field
                    controller: isiController, //untuk mengisi data kolom isi
                    keyboardType: TextInputType.text, //type keyboard untuk mengisi data isi
                    decoration: InputDecoration( //dekorasi inputan
                      labelText: 'Masukkan List Belanja', // label pada text field
                      border: OutlineInputBorder( //outline pada border
                        borderRadius: BorderRadius.circular(10.0), //radius pada border
                      ),
                    ),
                  ),
                ),

                //tombol button
                Padding( //padding
                  padding: EdgeInsets.only(top: 20.0, bottom: 20.0), //mengatur jarak
                  child: Row(
                    children: <Widget>[ //widget
                      // tombol simpan
                      Expanded(
                        child: RaisedButton(//berbentuk raisedbutton
                          color: Theme.of(context).primaryColorDark, //warna button
                          textColor: Theme.of(context).primaryColorLight,//warna text button
                          child: Text( //text pada button
                            'Simpan',
                            textScaleFactor: 1.5, //skala text
                          ),
                          onPressed: () { //saat diklik
                            if (tips == null) { //jika data tips kosong
                              // tambah data
                              tips = Tips( //data dari class Tips
                                namaTipsController.text,  //memanggil kontroler nama
                                isiController.text, //memanggil kontroler isi
                              );
                            } else {//jika data tips sudah terisi
                              // ubah data
                              tips.namaTips = namaTipsController.text; //mengubah kolom nama dari tabel tips
                              tips.isi = isiController.text; //mengubah kolom isi dari tabel tips
                            }
                            Navigator.pop(context,
                                tips); // kembali ke layar sebelumnya dengan membawa objek tips
                          },
                        ),
                      ),
                      Expanded( //expanded
                        child: RaisedButton( //berbentuk raised button
                          color: Theme.of(context).primaryColorDark, //warna button
                          textColor: Theme.of(context).primaryColorLight, //warna text button
                          child: Text( //text pada button
                            'Batal',
                            textScaleFactor: 1.5, //skala text
                          ),
                          onPressed: () {  //saat diklik
                            Navigator.pop(context);  //kembali ke halaman sebelumnya
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )));
  }
}
