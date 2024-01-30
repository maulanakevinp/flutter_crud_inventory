import 'package:flutter/material.dart';
import 'package:inventory_app/model/response_barang.dart';
import 'package:inventory_app/services/item_services.dart';

class DetailItemProvider extends ChangeNotifier {
  final _itemService = ItemServices();
  var _isFetching = false; // Make it private
  late Barang _barang;

  bool get isFetching => _isFetching;
  Barang get barang => _barang;

  DetailItemProvider(String id) {
    getBarang(id);
  }

  Future<void> getBarang(String id) async {
    try {
      _isFetching = true;
      notifyListeners();
      _barang = await _itemService.getDetailBarang(id);
    } finally {
      _isFetching = false;
      notifyListeners();
    }
  }
}
