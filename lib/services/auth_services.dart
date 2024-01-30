import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:inventory_app/model/response_login.dart';

const host = "192.168.183.17";

class AuthServices {
  Future<ResponseLogin> login(String email, String password) async {
    final uri = Uri.http(host,'/server_inventory/index.php/api/login');
    final response = await http.post(uri,
      body: {
        "email" : email,
        "password": password
      }
    );
    return ResponseLogin.fromJson(jsonDecode(response.body));
  }
}