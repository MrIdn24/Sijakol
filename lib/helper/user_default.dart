import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sijakol/features/auth/login_screen.dart';

import '../features/home_screen.dart';

class UserDefault {

  Future<void> saveUserDefaults(List<String> data) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList("userModel", data);
    await prefs.setBool('isLoggedIn', true);
  }

  Future<void> _saveProfilePicture(Uint8List imageBytes) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String base64Image = base64Encode(imageBytes);
    await prefs.setString('profile_pictures', base64Image);
  }

  Future<Uint8List?> _loadImageFromPrefs() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? base64Image = prefs.getString('saved_image');
    if (base64Image != null) {
      return base64Decode(base64Image);
    }else {
      return null;
    }
  }

  Future<List<String>> getUserDefaults() async {
    final prefs = await SharedPreferences.getInstance();

    // Get a string value
    List<String>? userModel = prefs.getStringList("userModel");

    return userModel ?? ["tidak ada"];
  }

  Future<bool> getUserDefaultsLogged() async {
    final prefs = await SharedPreferences.getInstance();

    bool? isLogged = prefs.getBool("isLoggedIn");

    return isLogged ?? false;
  }

  Future<void> doLogout() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.remove('userModel');
    await prefs.remove('isLoggedIn');
  }
}