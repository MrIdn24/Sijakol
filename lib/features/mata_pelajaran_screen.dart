import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:sijakol/features/auth/login_screen.dart';
import 'package:sijakol/helper/colors.dart';
import 'package:google_fonts/google_fonts.dart';

class MataPelajaranScreen extends StatefulWidget {
  const MataPelajaranScreen({super.key});

  @override
  State<MataPelajaranScreen> createState() => _MataPelajaranScreenState();
}

class _MataPelajaranScreenState extends State<MataPelajaranScreen> {
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
                      "Mata Pelajaran",
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
                                      'assets/icons/ic_assessment.png',
                                      height: 35,
                                      fit: BoxFit.fitHeight,
                                    ),
                                    SizedBox(width: 16),
                                    Text(
                                        'Daftar Mata Pelajaran',
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
                                      'assets/icons/ic_info_assesment.png',
                                      height: 35,
                                      fit: BoxFit.fitHeight,
                                    ),
                                    SizedBox(width: 16),
                                    Expanded(child: Text(
                                      'Informasi Mata Pelajaran',
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
                                      'assets/icons/ic_training.png',
                                      height: 35,
                                      fit: BoxFit.fitHeight,
                                    ),
                                    SizedBox(width: 16),
                                    Expanded(child: Text(
                                      'Guru & Ruang Kelas',
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

