import 'dart:math';
import 'dart:typed_data';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:sijakol/features/auth/login_screen.dart';
import 'package:sijakol/helper/basic_alert.dart';
import 'package:sijakol/helper/colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sijakol/helper/route.dart';
import 'package:sijakol/helper/user_default.dart';
import 'package:sijakol/providers/profile_provider.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  List<String> userDefault = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      requestProfile(context);
    });
  }

  Future<void> requestProfile(BuildContext context) async {
    final profileProvider = Provider.of<ProfileProvider>(context, listen: false);
    final requestProfile = await profileProvider.getUpdatedProfile();
    final userDefaults = await UserDefault().getUserDefaults();

    if (requestProfile) {
      await UserDefault().saveUserDefaults([
        profileProvider.profileData.nama ?? '',
        profileProvider.profileData.email ?? '',
        userDefaults[2],
        profileProvider.profileData.kelas ?? '',
        '0',
        profileProvider.profileData.profile_picture_name ?? ''
      ]);
    }else {
      _getUserDefault();
      Provider.of<ProfileProvider>(context, listen: false).getProfilePicture();
    }

    _getUserDefault();
  }

  Future<void> _getUserDefault() async {
    List<String> userDefaults = await UserDefault().getUserDefaults();
    setState(() {
      userDefault = userDefaults;
    });
  }

  ProfileData _setUpProfile() {
    return ProfileData(
        name: userDefault[0],
        email: userDefault[1],
        kelas: userDefault[3]
    );
  }

  @override
  Widget build(BuildContext context) {
    final profileProvider = Provider.of<ProfileProvider>(context);
    print("is Loading ${profileProvider.isLoading}");
    return SafeArea(child: Scaffold(
      body: Container(
        width: double.infinity,
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(left: 10, top: 16, right: 10, bottom: 16),
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                      "Profile",
                      style: GoogleFonts.openSans(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.w600
                      )
                  ),
                  SizedBox(width: 16),
                  IconButton(onPressed: () {
                    _confirmLogout();
                  }, icon: Icon(
                    Icons.logout,
                    color: Colors.white,
                    size: 30,
                  ))
                ],
              ),
            ),
            Expanded(child: Container(
              width: double.infinity,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 180,
                      decoration: BoxDecoration(
                          color: ColorPrimary,
                          borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(20),
                              bottomLeft: Radius.circular(20)
                          )
                      ),
                    ),
                    Transform.translate(
                      offset: Offset(0.0, -130.0),
                      child: Container(
                        width: double.infinity,
                        child: Column(
                          children: [
                            Container(
                              width: 250,
                              height: 250,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  image:  profileProvider.isLoading
                                      ? AssetImage('assets/images/img-default.png') as ImageProvider
                                      : MemoryImage(profileProvider.imageData),
                                  fit: BoxFit.cover,
                                ),
                                border: Border.all(
                                  color: Colors.white,
                                  width: 5,
                                ),
                              ),
                            ),
                            Transform.translate(
                              offset: Offset(80.0, -60.0),
                              child: GestureDetector(
                                onTap: () {

                                },
                                child: Container(
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      color: ColorText,
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: Colors.white,
                                        width: 5,
                                      )
                                  ),
                                  child: Icon(
                                    Icons.add,
                                    size: 20,
                                    color: ColorTextDark,
                                  ),
                                ),
                              ),
                            ),
                            Transform.translate(
                              offset: Offset(0.0, -30.0),
                              child: Column(
                                children: [
                                  Container(
                                    width: double.infinity,
                                    padding: EdgeInsets.only(left: 16, right: 16),
                                    child: userDefault.isEmpty ? Container(height: 0) : Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: _setUpProfile().toWidgetList(),
                                    ),
                                  ),
                                  SizedBox(height: 30),
                                  Container(
                                    padding: EdgeInsets.only(left: 16, right: 16),
                                    width: double.infinity,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Expanded(child: FilledButton(
                                          onPressed: () {

                                          },
                                          child: Padding(
                                            padding: EdgeInsets.only(left: 10, top: 5, right: 10, bottom: 5),
                                            child: Text(
                                              'Edit Profil',
                                              style: GoogleFonts.roboto(
                                                  color: Colors.white,
                                                  fontSize: 18
                                              ),
                                            ),
                                          ),
                                          style: ButtonStyle(
                                              backgroundColor: MaterialStateColor.resolveWith((states) => ColorPrimary)
                                          ),
                                        )),
                                        SizedBox(width: 10),
                                        Expanded(child: OutlinedButton(
                                          onPressed: () {

                                          },
                                          child: Padding(
                                            padding: EdgeInsets.only(left: 10, top: 5, right: 10, bottom: 5),
                                            child: Text(
                                              'Pengaturan',
                                              style: GoogleFonts.roboto(
                                                  color: ColorPrimary,
                                                  fontSize: 18
                                              ),
                                            ),
                                          ),
                                          style: ButtonStyle(
                                              side: MaterialStateProperty.resolveWith((states) => BorderSide(
                                                  color: ColorPrimary,
                                                  width: 2
                                              )),
                                              overlayColor: MaterialStateProperty.resolveWith((states) => ColorPrimary.withOpacity(0.1))
                                          ),
                                        ))
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 50),
                                  GestureDetector(
                                    onTap: () {
                                      _launchWhatsApp('6289530807796');
                                    },
                                    child: Container(
                                      width: double.infinity,
                                      margin: EdgeInsets.only(left: 16, right: 16),
                                      padding: EdgeInsets.all(20),
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.call,
                                            size: 25,
                                            color: Colors.white,
                                          ),
                                          SizedBox(width: 10),
                                          Text(
                                            'Hubungi walikelas',
                                            textAlign: TextAlign.center,
                                            style: GoogleFonts.poppins(
                                                color: Colors.white,
                                                fontSize: 18,
                                                fontWeight: FontWeight.w400
                                            ),
                                          )
                                        ],
                                      ),
                                      decoration: BoxDecoration(
                                          color: ColorSecond,
                                          boxShadow: [
                                            BoxShadow(
                                                color: Colors.grey.withOpacity(0.5),
                                                offset: Offset(0.0, 3.0),
                                                blurRadius: 3
                                            )
                                          ],
                                          borderRadius: BorderRadius.circular(16)
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 30),
                                  Container(
                                    width: double.infinity,
                                    margin: EdgeInsets.only(left: 16, right: 16),
                                    child: Text(
                                        'Bio',
                                        style: GoogleFonts.openSans(
                                            color: ColorTextDark,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold
                                        )
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ))
          ],
        ),
      ),
    ));
  }

  void _launchWhatsApp(String phoneNumber) async {
    final Uri url = Uri.parse("https://wa.me/$phoneNumber");
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
      print('WhatsApp opened');
    } else {
      print('Could not launch $url');
    }
  }

  void _confirmLogout() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Konfirmasi Logout'),
          content: Text('Apakah kamu yakin ingin keluar?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Batal'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                UserDefault().doLogout();
                Navigator.of(context).pushReplacement(
                    SijakolRoute(screen: LoginScreen())
                ); // Call the logout function
              },
              child: Text('Iya'),
            ),
          ],
        );
      },
    );
  }

}

class ProfileData {
  final String name;
  final String kelas;
  final String email;

  ProfileData({required this.name, required this.kelas, required this.email});

  List<Widget> toWidgetList() {
    return [
      Text(
          capitalize(name),
          style: GoogleFonts.poppins(
              color: ColorTextDark,
              fontSize: 25,
              fontWeight: FontWeight.bold,
          ),
      ),
      SizedBox(height: 8),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
              kelas,
              style: GoogleFonts.openSans(
                  color: ColorTextDark,
                  fontSize: 18,
                  fontWeight: FontWeight.w400
              )
          ),
          Text(
            ' | ',
            style: GoogleFonts.openSans(
                  color: ColorTextDark,
                  fontSize: 18,
                  fontWeight: FontWeight.bold
              )
          ),
          Text(
              email,
              style: GoogleFonts.openSans(
                  color: ColorTextDark,
                  fontSize: 18,
                  fontWeight: FontWeight.w400
              )
          ),
        ],
      )
    ];
  }

  String capitalize(String input) {
    if (input.isEmpty) {
      return input;
    }
    return input.split(' ').map((word) {
      if (word.isEmpty) {
        return word;
      }
      return word[0].toUpperCase() + word.substring(1).toLowerCase();
    }).join(' ');
  }
}