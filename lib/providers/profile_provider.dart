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
import 'package:sijakol/models/profile_model.dart';
import 'package:sijakol/response/base_response.dart';
import 'package:sijakol/response/jadwal_response.dart';
import 'package:sijakol/models/jadwal_mingguan_bulanan_model.dart';
import 'package:sijakol/response/login_response.dart';
import 'package:sijakol/response/profile_response.dart';

class ProfileProvider extends ChangeNotifier {
  ProfileModel _profileResponse = ProfileModel();
  ProfileModel get profileData => _profileResponse;

  String _message = "";
  String get message => _message;

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  Uint8List? _imageData;
  Uint8List get imageData => _imageData!;

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<bool> getProfile() async {
    BasicAlert().showBasicAlert(BasicState.loading, "");
    final userDefault = await UserDefault().getUserDefaults();
    var endpointUrl = "${BaseUrl().baseURL}/api/profile";
    final uri = Uri.parse(endpointUrl).replace(queryParameters: {
    });
    final response = await http.get(
      uri,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${userDefault[2]}',
      },
    );

    final Map<String, dynamic> result = json.decode(response.body);
    final finalResponse = ProfileResponse.fromJson(
        result,
            (dataJson) => ProfileModel.fromJson(dataJson)
    );

    _profileResponse = finalResponse.data;
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
  }

  Future<bool> getProfilePicture() async {
    print("ini masuk kgk si");
    BasicAlert().showBasicAlert(BasicState.loading, "");
    final userDefault = await UserDefault().getUserDefaults();
    var endpointUrl = "${BaseUrl().baseURL}/api/profile/picture";
    final uri = Uri.parse(endpointUrl).replace(queryParameters: {
    });
    final response = await http.get(
      uri,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${userDefault[2]}',
      },
    );

    if (response.statusCode == 200) {
      notifyListeners();
      BasicAlert().showBasicAlert(BasicState.none, '');
      _imageData = response.bodyBytes;
      setLoading(false);
      return true;
    } else {
      notifyListeners();
      BasicAlert().showBasicAlert(BasicState.error, response.reasonPhrase);
      _isLoading = false;
      return false;
    }
  }


  Future<bool> getUpdatedProfile() async {
    try {
      setLoading(true);
      final profileUpdated = await getProfile();
      if (profileUpdated) {
        final profilePicture = await getProfilePicture();
        if (profilePicture) {
          setLoading(false);
          return true;
        }else {
          setLoading(false);
          return false;
        }
      } else {
        setLoading(false);
        return false;
      }
    } catch (e) {
      print('Error updating profile: $e');
      setLoading(false);
      return false;
    }
  }
}