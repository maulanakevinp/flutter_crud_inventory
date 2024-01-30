// ItemProvider
import 'package:flutter/material.dart';
import 'package:inventory_app/model/response_barang.dart';
import 'package:inventory_app/services/item_services.dart';

class ItemProvider extends ChangeNotifier {
  final _itemServices = ItemServices();

  bool isFetching = false;
  List<Barang> listBarang = [];
  List<Barang> listSearchBarang = [];
  late ResponseBarang responseBarang;
  late Barang barang;

  Future<void> getBarang(String id) async {
    isFetching = true;
    notifyListeners();
    try {
      barang = await _itemServices.getDetailBarang(id);
    } finally {
      isFetching = false;
      notifyListeners();
    }
  }

  Future<void> getListBarang() async {
    isFetching = true;
    notifyListeners();
    try {
      listBarang = await _itemServices.getListBarang();
    } finally {
      isFetching = false;
      notifyListeners();
    }
  }

  Future<void> insertBarang(String name, String amount, String gambar) async {
    final response = await _itemServices.insertBarang(name, amount, gambar);
    responseBarang = response;
    await getListBarang();
  }

  Future<void> updateBarang(String id, String name, String amount, String gambar) async {
    final response = await _itemServices.updateBarang(id, name, amount, gambar);
    responseBarang = response;
    await getListBarang();
  }

  Future<void> deleteBarang(String id) async {
    final response = await _itemServices.deleteBarang(id);
    responseBarang = response;
    await getListBarang();
  }

  void search(String keywords) {
    List<Barang> listSearch = [];
    if (keywords.isEmpty) {
      listSearch.clear();
      listSearchBarang = listSearch;
    } else {
      for (var itemBarang in listBarang) {
        if (itemBarang.barangNama!.toLowerCase().contains(keywords.toLowerCase())) {
          listSearch.add(itemBarang);
        }
      }
      listSearchBarang = listSearch;
    }
    notifyListeners();
  }

  ItemProvider() {
    getListBarang();
  }
}