import 'dart:convert';
import 'dart:ffi';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:http/http.dart';
import 'package:flutter/services.dart';
import 'package:sijakol/helper/base_url.dart';
import 'package:sijakol/main.dart';
import 'package:sijakol/response/login_response.dart';

class AuthProvider extends ChangeNotifier {
  LoginResponse _loginResponse = LoginResponse(code: 0, message: "");
  LoginResponse get loginResponse => _loginResponse;

  Future<bool> loginUser(String email, String password) async {
    var endpointUrl = BaseUrl().baseURL + "/api/login";
    final uri = Uri.parse(endpointUrl);
    var body = {
      'email': email,
      'password': password,
    };
    var bodyJson = json.encode(body);
    final response = await http.post(
      uri,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json'
      },
      body: bodyJson,
    );
    final Map<String, dynamic> result = json.decode(response.body);
    _loginResponse = LoginResponse.fromJson(result);
    if (response.statusCode == 200) {
      notifyListeners();
      return true;
    } else {
      return false;
    }
  }

  Future<bool> doLogin(String email, String password) async {
    final bool fetchedProducts = await loginUser(email, password);

    return fetchedProducts;
  }
}