import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sijakol/features/home_screen.dart';
import 'package:sijakol/helper/basic_alert.dart';
import 'package:sijakol/helper/colors.dart';
import 'package:sijakol/helper/user_default.dart';
import 'package:sijakol/providers/auth_provider.dart';
import 'package:sijakol/response/login_response.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

extension ProviderExtension on BuildContext {
  AuthProvider get authProvider => Provider.of<AuthProvider>(this, listen: false);
}

class _LoginScreenState extends State<LoginScreen> {
  UserDefault userDefault = UserDefault();
  BasicAlert _basicAlert = BasicAlert();

  TextEditingController emailContoller = TextEditingController();
  TextEditingController passwordContoller = TextEditingController();
  String email = "";
  String password = "";

  bool _isObscured = false;
  IconData _icon = Icons.visibility_off;
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(left: 30, top: 70, right: 30),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  child: Image.asset(
                    'assets/icons/ic_sijakol.png',
                    height: 55,
                    fit: BoxFit.fitHeight,
                  ),
                ),
                const SizedBox(height: 70),
                Text(
                  'Selamat datang kembali',
                  style: GoogleFonts.poppins(
                      fontSize: 18,
                      color: const Color(0xff06467C),
                      fontWeight: FontWeight.w600
                  ),
                ),
                const SizedBox(height: 70),
                TextFormField(
                  style: GoogleFonts.openSans(
                      color: ColorTextDark
                  ),
                  controller: emailContoller,
                  decoration: InputDecoration(
                      border: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: ColorText,
                            width: 2,
                            style: BorderStyle.solid
                        ),
                      ),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: ColorText,
                              width: 2,
                              style: BorderStyle.solid
                          )
                      ),
                      hintText: 'Email',
                      hintStyle: GoogleFonts.openSans(
                          color: ColorText
                      ),
                      prefixIcon: Icon(
                        Icons.email,
                        color: ColorTextDark,
                      )
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  style: GoogleFonts.openSans(
                      color: ColorTextDark
                  ),
                  controller: passwordContoller,

                  decoration: InputDecoration(
                    border: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: ColorText,
                          width: 2,
                          style: BorderStyle.solid
                      ),
                    ),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: ColorText,
                            width: 2,
                            style: BorderStyle.solid
                        )
                    ),
                    hintText: 'Kata sandi',
                    hintStyle: GoogleFonts.openSans(
                        color: ColorText
                    ),
                    prefixIcon: Icon(
                      Icons.lock,
                      color: ColorTextDark,
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _icon,
                        color: ColorTextDark,
                      ),
                      onPressed: () {
                        _toggleVisibility();
                      },
                    ),
                  ),
                  obscureText: _obscureText,
                ),
                SizedBox(height: 8),
                Container(
                  alignment: Alignment.centerRight,
                  child: Text(
                      'Lupa Password?',
                      style: GoogleFonts.poppins(
                          color: ColorPrimary,
                          decoration: TextDecoration.underline
                      ),
                      textAlign: TextAlign.right
                  ),
                ),
                SizedBox(height: 117),
                Container(
                  width: double.infinity,
                  height: 55,
                  child: TextButton(
                    style: TextButton.styleFrom(
                        backgroundColor: ColorPrimary,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(17)
                        ),
                        foregroundColor: ColorPrimary
                    ),
                    onPressed: () {
                      setState(() {
                        email = emailContoller.text;
                        password = passwordContoller.text;
                        _submitLogin();
                      });
                    },
                    child: Text(
                      'Masuk',
                      style: GoogleFonts.openSans(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w600
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _toggleVisibility() {
    setState(() {
      _isObscured = !_isObscured;
      _icon = _isObscured ? Icons.visibility : Icons.visibility_off;
      _obscureText = _isObscured ? false : true;
    });
  }

  void _submitLogin() async {
    _basicAlert.showBasicAlert(BasicState.loading, null);

    bool loginSuccess = await context.authProvider.doLogin(email, password);
    if (loginSuccess) {
      await _basicAlert.showBasicAlert(
          BasicState.success,
          context.authProvider.loginResponse.message
      ).then((_) {
        if (context.authProvider.loginResponse.data != null) {
          LoginDataUser response = context.authProvider.loginResponse.data!;
          userDefault.saveUserDefaults([
            response.name,
            response.email,
            response.token,
            response.kelas_name,
            response.kelas_id.toString(),
            response.profile_picture_url
          ]);
        }
        _directSuccesLogin();
      },);
    }else {
      _basicAlert.showBasicAlert(BasicState.error, context.authProvider.loginResponse.message);
    }
  }

  Future<void> _directSuccesLogin() async {
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => HomeScreen()));
  }
}
