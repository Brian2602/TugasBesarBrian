import 'package:flutter/material.dart';
import 'package:dicoding_project_flutter/models/resep.dart'; //import library class Resep

class FormResep extends StatefulWidget {  //nama class menggunakan statefull
  final Resep resep; //variabel yg mengirim data class Resep
  FormResep(this.resep); //objek class FormResep

  @override
  FormResepState createState() => FormResepState(this.resep);  //membuat state
}

//class controller
class FormResepState extends State<FormResep> { //state
  Resep resep; //variabel resep
  FormResepState(this.resep);//objek class FormResepState

  TextEditingController namaController = TextEditingController(); //controller nama tabel resep
  TextEditingController bahanController = TextEditingController(); //controller bahan tabel resep
  TextEditingController stepController = TextEditingController(); //controller step tabel resep

  @override
  Widget build(BuildContext context) { //widget
    //kondisi
    if (resep != null) { //jika resep sudah terisi
      namaController.text = resep.nama; //memanggil kontroler nama
      bahanController.text = resep.bahan; //memanggil kontroler bahan
      stepController.text = resep.step; //memanggil kontroler step
    }
    //merubah
    return Scaffold(//scaffold
        appBar: AppBar( //app bar
          title: resep == null ? Text('Tambah') : Text('Edit'), //title pada app bar, jika resep masih kosong app bar akan memunculkan text 'Tambah' jika sudah terisi app bar akan emnampilkan text 'Edit'
        ),
        body: Padding( //body berbentuk widget padding
            padding: EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0), //mengatur jarak
            child: ListView( //listview
              children: [
                //mengisi data nama
                Padding( //padding
                  padding: EdgeInsets.only(top: 20.0, bottom: 20.0), //mengatur jarak
                  child: TextField( //menampilkan text field
                    controller: namaController, //untuk mengisi data kolom nama
                    keyboardType: TextInputType.text, //type keyboard untuk mengisi data nama
                    decoration: InputDecoration( //dekorasi inputan
                      labelText: 'Nama Resep', // label pada text field
                      border: OutlineInputBorder( //outline pada border
                        borderRadius: BorderRadius.circular(10.0), //radius pada border
                      ),
                    ),
                  ),
                ),

                //mengisi data bahan
                Padding( //padding
                  padding: EdgeInsets.only(top: 20.0, bottom: 20.0), //mengatur jarak
                  child: TextField( //menampilkan text field
                    controller: bahanController, //untuk mengisi data kolom bahan
                    keyboardType: TextInputType.text, //type keyboard untuk mengisi data bahan
                    decoration: InputDecoration( //dekorasi inputan
                      labelText: 'Bahan', // label pada text field
                      border: OutlineInputBorder( //outline pada border
                        borderRadius: BorderRadius.circular(10.0), //radius pada border
                      ),
                    ),
                  ),
                ),

                //mengisi data step
                Padding( //padding
                  padding: EdgeInsets.only(top: 20.0, bottom: 20.0), //mengatur jarak
                  child: TextField( //menampilkan text field
                    controller: stepController, //untuk mengisi data kolom step
                    keyboardType: TextInputType.text, //type keyboard untuk mengisi data step
                    decoration: InputDecoration( //dekorasi inputan
                      labelText: 'Steps', // label pada text field
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
                        child: RaisedButton( //berbentuk raisedbutton
                          color: Theme.of(context).primaryColorDark, //warna button
                          textColor: Theme.of(context).primaryColorLight, //warna text button
                          child: Text( //text pada button
                            'Save',
                            textScaleFactor: 1.5, // skala text
                          ),
                          onPressed: () { //saat diklik
                            if (resep == null) { //jika data resep kosong
                              // tambah data
                              resep = Resep( //data dari class Resep
                                namaController.text, //memanggil kontroler nama
                                bahanController.text, //memanggil kontroler bahan
                                stepController.text, //memanggil kontroler step
                              );
                            } else {//jika data resep sudah terisi
                              // ubah data
                              resep.nama = namaController.text; //mengubah nama resep
                              resep.bahan = bahanController.text; //mengubah bahan resep
                              resep.step = stepController.text; //mengubah step resep
                            }
                            Navigator.pop(context, resep);  // kembali ke layar sebelumnya dengan membawa objek resep
                          },
                        ),
                      ),
                      Expanded( //expanded
                        child: RaisedButton( //berbentuk raised button
                          color: Theme.of(context).primaryColorDark, //warna button
                          textColor: Theme.of(context).primaryColorLight, //warna text button
                          child: Text( //text pada button
                            'Cancel',
                            textScaleFactor: 1.5, // skala text
                          ),
                          onPressed: () { //saat diklik
                            Navigator.pop(context); //kembali ke halaman sebelumnya
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
