import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart';
import 'package:http/http.dart';
import 'package:http/http.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:sijakol/features/auth/login_screen.dart';
import 'package:sijakol/features/jadwal_kelas_screen.dart';
import 'package:sijakol/features/mata_pelajaran_screen.dart';
import 'package:sijakol/features/utils/basic_alert.dart';
import 'package:sijakol/helper/colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sijakol/helper/user_default.dart';
import 'package:sijakol/main.dart';
import 'package:sijakol/providers/auth_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  List<String> inspireWords = [
    "Keep going, you're doing great!",
    "Success comes with hard work.",
    "Never stop learning, keep growing.",
    "Believe in your own abilities.",
    "Every effort brings you closer."
  ];

  void _showLoginDialog() {
    UserDefault().doLogout();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.only(bottom: 20),
        child: Container(
          width: double.infinity,
          child: Column(
            children: [
              Container(
                color: ColorPrimary,
                padding: EdgeInsets.only(left: 16, right: 16, top: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        setState(() {
                          print("Anjay");
                          // _showLoginDialog();
                          _showLoginDialog();
                        });
                      },
                      child: Image.asset(
                          'assets/icons/ic_user.png',
                          width: 30,
                          fit: BoxFit.fitWidth
                      ),
                    ),
                    IconButton(onPressed: () {
                    }, icon: Icon(
                      Icons.notifications,
                      color: Colors.white,
                    ))
                  ],
                ),
              ),
              Container(
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: 16, right: 16, bottom: 16),
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
                        color: Color(0XFF33658A),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Transform.translate(
                                offset: const Offset(30, 0),
                                child: Text(
                                  inspireWords[Random().nextInt(inspireWords.length)],
                                  style: GoogleFonts.openSans(
                                      color: Colors.white,
                                      fontSize: 22,
                                      fontWeight: FontWeight.w600
                                  ),
                                )
                            ),
                          ),
                          Expanded(child: Transform.translate(
                            offset: const Offset(0, 63),
                            child: Image.asset(
                              'assets/images/img-study-home.png',
                              fit: BoxFit.fitHeight,
                              height: 300,
                            ),
                          ))
                        ],
                      ),
                    ),
                    const SizedBox(height: 22),
                    Container(
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.only(left: 16, right: 16),
                            width: double.infinity,
                            child: Text(
                              'Home',
                              style: GoogleFonts.openSans(
                                  fontSize: 18,
                                  color: const Color(0xff001a2d),
                                  fontWeight: FontWeight.w700
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) => JadwalKelasScreen()));
                                  },
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        width: 100,
                                        height: 100,
                                        padding: const EdgeInsets.all(20),
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(13),
                                            color: ColorMenu,
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey.withOpacity(0.5),
                                                spreadRadius: 0,
                                                blurRadius: 3,
                                                offset: const Offset(0, 3),
                                              )
                                            ]
                                        ),
                                        child:
                                        Image.asset(
                                          'assets/icons/ic_calendar.png',
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                      const SizedBox(height: 7),
                                      SizedBox(
                                        width: 100,
                                        child: Text(
                                          'Jadwal Kelas',
                                          style: GoogleFonts.openSans(
                                              fontSize: 14,
                                              color: const Color(0xff131B2B),
                                              fontWeight: FontWeight.w600
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(context, MaterialPageRoute(
                                        builder: (context) => MataPelajaranScreen())
                                    );
                                  },
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        width: 100,
                                        height: 100,
                                        padding: const EdgeInsets.all(20),
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(13),
                                            color: ColorMenu,
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey.withOpacity(0.5),
                                                spreadRadius: 0,
                                                blurRadius: 3,
                                                offset: const Offset(0, 3),
                                              )
                                            ]
                                        ),
                                        child:
                                        Image.asset(
                                          'assets/icons/ic_purpose.png',
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                      const SizedBox(height: 7),
                                      SizedBox(
                                        width: 100,
                                        child: Text(
                                          'Mata Pelajaran',
                                          style: GoogleFonts.openSans(
                                              fontSize: 14,
                                              color: const Color(0xff131B2B),
                                              fontWeight: FontWeight.w600
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 100,
                                      height: 100,
                                      padding: const EdgeInsets.all(20),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(13),
                                          color: ColorMenu,
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.grey.withOpacity(0.5),
                                              spreadRadius: 0,
                                              blurRadius: 3,
                                              offset: const Offset(0, 3),
                                            )
                                          ]
                                      ),
                                      child:
                                      Image.asset(
                                        'assets/icons/ic_assignment.png',
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                    const SizedBox(height: 7),
                                    SizedBox(
                                      width: 100,
                                      child: Text(
                                        'Tugas & Ujian',
                                        style: GoogleFonts.openSans(
                                            fontSize: 14,
                                            color: const Color(0xff131B2B),
                                            fontWeight: FontWeight.w600
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 100,
                                      height: 100,
                                      padding: const EdgeInsets.all(20),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(13),
                                          color: ColorMenu,
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.grey.withOpacity(0.5),
                                              spreadRadius: 0,
                                              blurRadius: 3,
                                              offset: const Offset(0, 3),
                                            )
                                          ]
                                      ),
                                      child:
                                      Image.asset(
                                        'assets/icons/ic_loudspeaker.png',
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                    const SizedBox(height: 7),
                                    SizedBox(
                                      width: 100,
                                      child: Text(
                                        'Pengumuman',
                                        style: GoogleFonts.openSans(
                                            fontSize: 14,
                                            color: const Color(0xff131B2B),
                                            fontWeight: FontWeight.w600
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 22),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}

class ChildJadwal extends StatelessWidget {
  String tag = "";
  String image = "";

  ChildJadwal(this.tag, this.image);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => CategoryScreen(
        //       query: tag,
        //       name: title,
        //     ),
        //   ),
        // );
      },
      child: Container(
        height: 200,
        width: 200,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(child: Image.network(
              "https://unduhperangkatku.com/wp-content/uploads/2023/11/jadwal-pelajaran-kelas-5.jpg",
              fit: BoxFit.contain,
            ))
          ],
        ),
      ),
    );
  }
}
