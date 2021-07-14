class Resep{ //nama class model
  int _id; //atribut id resep
  String _nama; //atribut nama resep
  String _bahan; //atribut bahan resep
  String _step; // atribut step resep

  int get id => _id; //get id resep

  String get nama => this._nama; //get nama resep
  set nama(String value) => this._nama = value; //set nama resep

  String get bahan => this._bahan; //get bahan resep
  set bahan(String value) => this._bahan = value; //set bahan resep

  String get step => this._step; //get step resep
  set step(String value) => this._step = value; //set step resep

  // konstruktor versi 1 (set scr bersama2)
  Resep(this._nama, this._bahan, this._step);

  // konstruktor versi 2: konversi dari Map ke Resep (mengambil data dari sql yg tersimpan)
  Resep.fromMap(Map<String, dynamic> map) {
  this._id = map['id'];
  this._nama = map['nama'];
  this._bahan = map['bahan'];
  this._step = map['step'];
 }

  // konversi dari Resep ke Map (utk update & insert)
  Map<String, dynamic> toMap() {
  Map<String, dynamic> map = Map<String, dynamic>(); //inisialisai map
  map['id'] = this._id;
  map['nama'] = _nama;
  map['bahan'] = _bahan;
  map['step'] = _step;
  return map; //mengembalikan nilai map
  }  
}