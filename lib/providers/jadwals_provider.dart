import 'dart:convert';
import 'dart:ffi';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:http/http.dart';
import 'package:flutter/services.dart';
import 'package:sijakol/features/jadwal_kelas/jadwal_mingguan_bulanan.dart';
import 'package:sijakol/helper/basic_alert.dart';
import 'package:sijakol/helper/base_url.dart';
import 'package:sijakol/helper/user_default.dart';
import 'package:sijakol/main.dart';
import 'package:sijakol/models/jadwal_hari_ini_model.dart';
import 'package:sijakol/response/base_response.dart';
import 'package:sijakol/response/jadwal_response.dart';
import 'package:sijakol/models/jadwal_mingguan_bulanan_model.dart';
import 'package:sijakol/response/login_response.dart';


class JadwalProvider extends ChangeNotifier {
  List<JadwalHariIniModel> _jadwalHariIniResponse = [];
  List<JadwalHariIniModel> get jadwalHariIniData => _jadwalHariIniResponse;

  String _message = "";
  String get message => _message;

  List<JadwalMingguanBulananModel> _jadwalMingguanBulananResponse = [];
  List<JadwalMingguanBulananModel> get jadwalMingguanBulananData => _jadwalMingguanBulananResponse;
  List<String> userDefault = [];

  Future<void> _getUserDefault() async {
    userDefault = await UserDefault().getUserDefaults();
  }

  Future<bool> getjadwalHariIni() async {
    BasicAlert().showBasicAlert(BasicState.loading, "");
    _getUserDefault().then((value) async {
      var endpointUrl = "${BaseUrl().baseURL}/api/jadwal/hari-ini";
      final uri = Uri.parse(endpointUrl).replace(queryParameters: {
      });
      final response = await http.get(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ' + userDefault[2],
        },
      );

      final Map<String, dynamic> result = json.decode(response.body);
      final finalResponse = JadwalResponse<List<JadwalHariIniModel>>.fromJson(
        result,
            (dataJson) => (dataJson as List).map((item) => JadwalHariIniModel.fromJson(item)).toList(),
      );
      _jadwalHariIniResponse = finalResponse.data ?? [];
      _message = finalResponse.message;
      if (response.statusCode == 200) {
        notifyListeners();
        BasicAlert().showBasicAlert(BasicState.none, '');
        return true;
      } else {
        notifyListeners();
        BasicAlert().showBasicAlert(BasicState.error, response.reasonPhrase);
        return false;
      }
    });
    return false;
  }

  Future<bool> getjadwalMingguanBulanan(String tanggal) async {
    BasicAlert().showBasicAlert(BasicState.loading, "");
    _getUserDefault().then((value) async {
      var endpointUrl = BaseUrl().baseURL + "/api/jadwal/bulanan";
      final uri = Uri.parse(endpointUrl).replace(queryParameters: {
        'tanggal': tanggal
      });
      final response = await http.get(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ' + userDefault[2],
        },
      );

      final Map<String, dynamic> result = json.decode(response.body);
      final finalResponse = JadwalResponse<List<JadwalMingguanBulananModel>>.fromJson(
        result,
            (dataJson) => (dataJson as List).map((item) => JadwalMingguanBulananModel.fromJson(item)).toList(),
      );
      _jadwalMingguanBulananResponse = finalResponse.data ?? [];
      _message = finalResponse.message;
      if (response.statusCode == 200) {
        notifyListeners();
        BasicAlert().showBasicAlert(BasicState.none, '');
        return true;
      } else {
        notifyListeners();
        BasicAlert().showBasicAlert(BasicState.error, response.reasonPhrase);
        return false;
      }
    });
    return false;
  }

  Future<bool> jadwalHariIni() async {
    final bool fetchedJadwal = await getjadwalHariIni();
    notifyListeners();
    return fetchedJadwal;
  }

  Future<bool> jadwalMingguanBulanan(String tanggal) async {
    final bool fetchedJadwal = await getjadwalMingguanBulanan(tanggal);
    notifyListeners();
    return fetchedJadwal;
  }
}