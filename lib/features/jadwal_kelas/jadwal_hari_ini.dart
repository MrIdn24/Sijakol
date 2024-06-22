import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sijakol/features/auth/login_screen.dart';
import 'package:sijakol/helper/colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sijakol/helper/user_default.dart';
import 'package:sijakol/models/jadwal_hari_ini_model.dart';
import 'package:sijakol/providers/jadwals_provider.dart';
import 'package:sijakol/response/jadwal_response.dart';

class JadwalHariIniScreen extends StatefulWidget {
  const JadwalHariIniScreen({super.key});

  @override
  State<JadwalHariIniScreen> createState() => _JadwalHariIniScreenState();
}

class _JadwalHariIniScreenState extends State<JadwalHariIniScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
    Provider.of<JadwalProvider>(context, listen: false).getjadwalHariIni();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
      // Provider.of<JadwalProvider>(context, listen: false).getjadwalHariIni(2);
    }
  }

  @override
  Widget build(BuildContext context) {
    final jadwalProvider = Provider.of<JadwalProvider>(context);
    return SafeArea(child: Scaffold(
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(left: 10, top: 16, right: 10, bottom: 16),
              child: Row(
                children: [
                  IconButton(onPressed: () {
                    Navigator.of(context).pop();
                  }, icon: Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                    size: 30,
                  )),
                  SizedBox(width: 16),
                  Text(
                      "Jadwal Hari Ini",
                      style: GoogleFonts.openSans(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.w600
                      )
                  )
                ],
              ),
              decoration: BoxDecoration(
                  color: ColorPrimary,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 0,
                      blurRadius: 5,
                      offset: const Offset(0, 5),
                    )
                  ]
              ),
            ),
            Expanded(child: Container(
              width: double.infinity,
              padding: EdgeInsets.only(left: 10, right: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Container(
                      child: (jadwalProvider.jadwalHariIniData.length) != 0 ? ListView.builder(
                        controller: _scrollController,
                        itemBuilder: (BuildContext context, int index) {
                          return ChildProduct(index, jadwalProvider.jadwalHariIniData[index]);
                        },
                        itemCount: jadwalProvider.jadwalHariIniData.length,
                      ) : Padding(
                        padding: const EdgeInsets.only(left: 16, right: 16),
                        child: Center(child: Text(
                            jadwalProvider.message,
                            style: GoogleFonts.poppins(
                                color: ColorTextDark,
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                            ),
                          textAlign: TextAlign.center,
                        )),
                      ),
                    ),
                  )
                ],
              ),
            )),
          ],
        ),
      ),
    ));
  }
}

class ChildProduct extends StatelessWidget {
  final Map<String, String> monthsInIndonesia = {
    'January': 'Januari',
    'February': 'Februari',
    'March': 'Maret',
    'April': 'April',
    'May': 'Mei',
    'June': 'Juni',
    'July': 'Juli',
    'August': 'Agustus',
    'September': 'September',
    'October': 'Oktober',
    'November': 'November',
    'December': 'Desember',
  };

  Map<String, String> daysInIndonesian = {
    'Sunday':'Minggu',
    'Monday':'Senin',
    'Tuesday':'Selasa',
    'Wednesday':'Rabu',
    'Thursday':'Kamis',
    'Friday':'Jumat',
    'Saturday':'Sabtu'
  };

  int index = 0;
  JadwalHariIniModel? jadwalData = JadwalHariIniModel();

  ChildProduct(int index, JadwalHariIniModel jadwalData) {
    this.index = index;
    this.jadwalData = jadwalData;
  }

  var colors = [
    Colors.green,
    Colors.yellow,
    Colors.red,
    Colors.orange,
    Colors.blue,
    Colors.purple,
  ];

  MaterialColor _setColors(String pelajaran) {
    if (pelajaran == 'IPA') {
      return colors[0];
    } else if (pelajaran == 'IPS') {
      return colors[1];
    } else if (pelajaran == 'Matematika') {
      return colors[2];
    } else if (pelajaran == 'B. Indonesia') {
      return colors[3];
    } else if (pelajaran == 'B. Inggris') {
      return colors[4];
    } else if (pelajaran == 'Seni Budaya') {
      return colors[5];
    } else {
      return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
    padding: EdgeInsets.only(top: index == 0 ? 20 : 0),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: index == 0 ? 16 : 0,
            margin: EdgeInsets.only(bottom: index == 0 ? 25 : 0),
            child: Text(
              index == 0 ? '${daysInIndonesian[DateFormat('EEEE').format(DateTime.now())]}, ${DateFormat('dd').format(DateTime.now())} ${monthsInIndonesia[DateFormat('MMMM').format(DateTime.now())]} ${DateFormat('yyyy').format(DateTime.now())}' : "",
              style: GoogleFonts.poppins(
                  color: ColorTextDark,
                  fontSize: 14,
                  fontWeight: FontWeight.normal
              ),
              textAlign: TextAlign.left,
            )
          ),
          Container(
            padding: EdgeInsets.only(left: 5),
            margin: EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
                color: _setColors(jadwalData?.mata_pelajaran ?? "-"),
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 0,
                    blurRadius: 3,
                    offset: const Offset(0, 3),
                  )
                ]
            ),
            child: Row(
              children: [
                SizedBox(width: 10),
                Expanded(
                    child: Container(
                      padding: EdgeInsets.only(left: 8,top: 10, right: 10, bottom: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(10),
                            bottomRight: Radius.circular(10)
                        ),
                      ),
                      child: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  jadwalData?.mata_pelajaran ?? "Tidak ada",
                                  style: GoogleFonts.poppins(
                                      color: ColorTextDark,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600
                                  )
                              ),
                              SizedBox(height: 8),
                              Row(
                                children: [
                                  Icon(
                                    Icons.alarm,
                                    size: 22,
                                    color: ColorText,
                                  ),
                                  SizedBox(width: 8),
                                  Text(
                                      '${jadwalData?.waktu_mulai ?? '00:00'} - ${jadwalData?.waktu_selesai ?? '00:00'}',
                                      style: GoogleFonts.poppins(
                                          color: Colors.black,
                                          fontSize: 13,
                                          fontWeight: FontWeight.normal
                                      )
                                  ),
                                ],
                              ),
                              SizedBox(height: 8),
                              Row(
                                children: [
                                  Icon(
                                    Icons.person,
                                    size: 22,
                                    color: ColorText,
                                  ),
                                  SizedBox(width: 8),
                                  Text(
                                      jadwalData?.guru_pengajar ?? 'Tidak ada',
                                      style: GoogleFonts.poppins(
                                          color: Colors.black,
                                          fontSize: 13,
                                          fontWeight: FontWeight.normal
                                      )
                                  ),
                                ],
                              ),
                              SizedBox(height: 8),
                              Row(
                                children: [
                                  Icon(
                                    Icons.hourglass_bottom,
                                    size: 22,
                                    color: ColorText,
                                  ),
                                  SizedBox(width: 8),
                                  Text(
                                      jadwalData?.durasi ?? '0 Min',
                                      style: GoogleFonts.poppins(
                                          color: Colors.black,
                                          fontSize: 13,
                                          fontWeight: FontWeight.normal
                                      )
                                  ),
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                    )
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}