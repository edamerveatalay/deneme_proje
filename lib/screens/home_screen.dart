import 'dart:convert';

import 'package:deneme_proje/models/urunler_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  UrunlerModel?
  _veriler; //urunleri null olarak oluşturdum yani null olabilir dedim
  List<Urun> _urunler = []; //1-boş bir urunler listesi oluşturduk
  void _loadData() async {
    //fonk çalışır data jasonı okur ondan sonra _urunler modeline verir
    final dataString = await rootBundle.loadString('assets/files/data.json');
    final dataJson = jsonDecode(
      dataString,
    ); //stringi jsona çevirmek için jsonDecode kullandık

    _veriler = UrunlerModel.fromJson(
      dataJson,
    ); //gelen json verisinden model oluşturup _urunlere gönderdik
    _urunler = _veriler!
        .urunler; //2-sonrasında veriler çekildikten sonra urunler içerisine verilerdeki urunleri ekleyebiliriz
    setState(() {});

    print(
      dataJson['kategoriler'],
    ); //dart tanısın diye jsona dönüştürdük böyle de yazdırdık
  } //veri okuma

  void _filterData(int id) {
    //
    _urunler = _veriler!.urunler
        .where(
          (verilerEleman) => verilerEleman.kategori == id,
        ) //koşul, sadece belirli kategoriye ait ürünleri alır.
        .toList(); //toList() → filtrelenmiş sonucu tekrar liste haline getirir.

    setState(
      () {},
    ); //setState() → UI’yi yeniden çizer. Değer değiştiyse görüntünü değişmesi için
  } //where id'nin nerede olduğunu bulup onu filtreleyecek

  void _resetFilter() {
    _urunler = _veriler!.urunler;
    setState(() {});
  }

  @override
  void initState() {
    _loadData(); // buraya ne yazarsak uygulama ilk başladığında çalışır
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _veriler == null
            ? const Text('yükleniyor')
            : Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: _resetFilter,
                    child: Text('tüm ürünler'),
                  ),
                  _kategorilerView(),
                  _urunlerView(),
                ],
              ),
      ),
    );
  }

  ListView _urunlerView() {
    return ListView.separated(
      // ListView.separated → Elemanlar arasında otomatik ayırıcı (divider/boşluk) ekleyen liste yapısı
      shrinkWrap: true, //kendini kısıtla kendi boyutunu çok artırma
      itemCount: _urunler.length,
      itemBuilder: (context, index) {
        final Urun urun = _urunler[index];
        return ListTile(
          leading: Image.network(
            urun.resim,
            width: 100,
            height: 100,
            fit: BoxFit
                .cover, // boxfit Resmi kutuyu tamamen dolduracak şekilde kırparak ölçeklendirir
          ), //leading ile sol tarafta belirli bi boşluk oluşturulup resim yerleştirilir
          title: Text(urun.isim),
        ); //ListTile tek satırlık öğe yapısı oluşturur
      },
      separatorBuilder: (context, index) => const Divider(
        height: 10,
      ), //Yani separatorBuilder her iki liste elemanı arasına ne konacağını belirler, burada da 10 px yüksekliğinde bir Divider eklenmiş
    );
  }

  Row _kategorilerView() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center, //altında yazanları ortalar
      //row yan yana olmasını sağlar row içine yazdıklarının
      children: List.generate(_veriler!.kategoriler.length, (index) {
        final kategori = _veriler!
            .kategoriler[index]; //Veri modelindeki kategoriler listesinden, listedeki belirli sıradaki (index) kategoriyi al ve kategori değişkenine ata.
        return GestureDetector(
          onTap: () => _filterData(kategori.id),
          child: Container(
            padding: EdgeInsets.all(8),
            margin: EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              color: Colors.black12,
              borderRadius: BorderRadius.circular(
                10,
              ), //kenarları oval yaptık borderradius ile
            ),
            child: Text(kategori.isim),
          ),
        );
      }),
    );
  }
}
