import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:inventory_app/model/response_barang.dart';
import 'package:inventory_app/services/auth_services.dart';

class ItemServices {
  Future<List<Barang>> getListBarang() async {
    final uri = Uri.http(host,'/server_inventory/index.php/api/getBarang');
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      ResponseBarang responseBarang = ResponseBarang.fromJson(jsonDecode(response.body));
      return responseBarang.barang ?? [];
    } else {
      throw Exception('Failed to load barang');
    }
  }

  Future<ResponseBarang> updateBarang(String id, String name, String amount, String gambar) async {
    final uri = Uri.http(host,'/server_inventory/index.php/api/updateBarang');
    final response = await http.post(uri,
      body: {
        'id': id,
        'nama': name,
        'jumlah': amount,
        'gambar': gambar,
      }
    );
    if (response.statusCode == 200) {
      return ResponseBarang.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to update barang');
    }
  }

  Future<ResponseBarang> insertBarang(String name, String amount, String gambar) async {
    final uri = Uri.http(host,'/server_inventory/index.php/api/insertBarang');
    final response = await http.post(uri,
      body: {
        'nama': name,
        'jumlah': amount,
        'gambar': gambar,
      }
    );
    if (response.statusCode == 200) {
      return ResponseBarang.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to insert barang');
    }
  }
  
  Future<ResponseBarang> deleteBarang(String id) async {
    final uri = Uri.http(host,'/server_inventory/index.php/api/deleteBarang');
    final response = await http.post(uri,
      body: {
        'id': id,
      }
    );
    if (response.statusCode == 200) {
      return ResponseBarang.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to delete barang');
    }
  }

  Future<Barang> getDetailBarang(String id) async {
    final uri = Uri.http(host,'/server_inventory/index.php/api/getDetailBarang/$id');
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      return Barang.fromJson(jsonDecode(response.body)['barang']);
    } else {
      throw Exception('Failed to load barang');
    }
  }

}