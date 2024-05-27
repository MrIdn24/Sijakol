import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:sijakol/features/auth/login_screen.dart';
import 'package:sijakol/helper/colors.dart';
import 'package:google_fonts/google_fonts.dart';

class JadwalKelasScreen extends StatefulWidget {
  const JadwalKelasScreen({super.key});

  @override
  State<JadwalKelasScreen> createState() => _JadwalKelasScreenState();
}

class _JadwalKelasScreenState extends State<JadwalKelasScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      body: Container(
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
                      "Jadwal Kelas",
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
            Container(
              margin: EdgeInsets.only(top: 22),
              padding: EdgeInsets.only(left: 10, right: 10),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {

                    },
                    child: Container(
                      padding: EdgeInsets.only(left: 16, top: 16, right: 16, bottom: 16),
                      width: double.infinity,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: 300,
                                child: Row(
                                  children: [
                                    Image.asset(
                                      'assets/icons/ic_planner.png',
                                      height: 35,
                                      fit: BoxFit.fitHeight,
                                    ),
                                    SizedBox(width: 16),
                                    Text(
                                        'Jadwal Hari Ini',
                                        style: GoogleFonts.poppins(
                                          color: ColorTextDark,
                                          fontSize: 18,
                                        )
                                    )
                                  ],
                                ),
                              ),
                              Icon(
                                Icons.keyboard_arrow_right,
                                color: ColorTextDark,
                                size: 35,
                              ),
                            ],
                          ),
                          SizedBox(height: 16),
                          Container(
                            height: 2,
                            width: double.infinity,
                            color: ColorText,
                          )
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {

                    },
                    child: Container(
                      padding: EdgeInsets.only(left: 16, top: 16, right: 16, bottom: 16),
                      width: double.infinity,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: 300,
                                child: Row(
                                  children: [
                                    Image.asset(
                                      'assets/icons/ic_next_week.png',
                                      height: 35,
                                      fit: BoxFit.fitHeight,
                                    ),
                                    SizedBox(width: 16),
                                    Expanded(child: Text(
                                      'Jadwal Mingguan & Bulanan',
                                      style: GoogleFonts.poppins(
                                        color: ColorTextDark,
                                        fontSize: 18,
                                      ),
                                    ))
                                  ],
                                ),
                              ),
                              Icon(
                                Icons.keyboard_arrow_right,
                                color: ColorTextDark,
                                size: 35,
                              ),
                            ],
                          ),
                          SizedBox(height: 16),
                          Container(
                            height: 2,
                            width: double.infinity,
                            color: ColorText,
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }
}

