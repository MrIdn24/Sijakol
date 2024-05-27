import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart';
import 'package:sijakol/features/auth/login_screen.dart';
import 'package:sijakol/features/home_screen.dart';
import 'package:sijakol/features/jadwal_kelas_screen.dart';
import 'package:sijakol/features/splash_screen.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:sijakol/features/utils/basic_alert.dart';
import 'package:sijakol/providers/auth_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AuthProvider(),
        ),
      ],
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          statusBarColor: Colors.black,
          statusBarIconBrightness: Brightness.light,
        ),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: SplashScreen(),
          builder: BasicAlert.init(),
        ),
      ),
    );
  }
}
