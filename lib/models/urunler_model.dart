import 'dart:math';

class UrunlerModel {
  //hepsini kapsayan
  final List<Urun>
  urunler; //liste olduğu için jsondakiler biz de dışarıdan liste istedik
  final List<Kategori> kategoriler; //kategoriler listesini de aldık

  UrunlerModel(this.urunler, this.kategoriler);

  factory UrunlerModel.fromJson(Map<String, dynamic> json) {
    final List jsonUrunler = json['urunler'];
    final List jsonKategoriler = json['kategoriler'];

    return UrunlerModel(
      jsonUrunler.map((e) => Urun.fromJson(e)).toList(),
      jsonKategoriler.map((e) => Kategori.fromJson(e)).toList(),
    );
  }
}

class Urun {
  final int id;
  final int kategori;
  final String isim;
  final String resim;

  Urun(this.id, this.kategori, this.isim, this.resim);

  /*Urun.fromJson(Map<String, dynamic> json) //dışarıdan jsonı alıp bütün değerleri jsona eşitledik
    : id = json['id'],
      kategori = json['kategori'],
      isim = json['isim'],
      resim = json['resim'];
}*/

  factory Urun.fromJson(Map<String, dynamic> json) {
    //kkendi classımızı dönüştürmüş olduk
    //factory ile yapıyoruz
    return Urun(json['id'], json['kategori'], json['isim'], json['resim']);
  }
}

class Kategori {
  final int id;
  final String isim;

  Kategori(this.id, this.isim);

  factory Kategori.fromJson(Map<String, dynamic> json) {
    return Kategori(json['id'], json['isim']);
  }
}
