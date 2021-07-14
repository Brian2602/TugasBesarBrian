class Tips{ //nama class model
  int _idTips; //atribut id tips
  String _namaTips;  //atribut nama tips
  String _isi;  //atribut isi tips


  int get idTips => _idTips; //get id tips

  String get namaTips => this._namaTips; //get nama tips
  set namaTips(String value) => this._namaTips = value;  //set nama tips

  String get isi => this._isi; //get isi tips
  set isi(String value) => this._isi = value; //set isi tips

  // konstruktor versi 1 (set scr bersama2)
  Tips(this._namaTips, this._isi);

  // konstruktor versi 2: konversi dari Map ke Tips (mengambil data dari sql yg tersimpan)
  Tips.fromMap(Map<String, dynamic> map) {
  this._idTips = map['idTips'];
  this._namaTips = map['namaTips'];
  this._isi = map['isi'];
 }

  // konversi dari Tips ke Map (utk update & insert)
  Map<String, dynamic> toMap() {
  Map<String, dynamic> map = Map<String, dynamic>(); //inisialisasi map
  map['idTips'] = this._idTips;
  map['namaTips'] = _namaTips;
  map['isi'] = _isi;
  return map; //mengembalikan nilai map
  }  
}