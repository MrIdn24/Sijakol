import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SijakolRoute extends PageRouteBuilder {
  final Widget screen;

  SijakolRoute({required this.screen})
      : super(
    pageBuilder: (context, animation, secondaryAnimation) => screen,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(0.0, 1.0);
      const end = Offset.zero;
      const curve = Curves.easeInOut;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
      var offsetAnimation = animation.drive(tween);

      return SlideTransition(
        position: offsetAnimation,
        child: child,
      );
    },
    fullscreenDialog: true, // Fullscreen dialog option
  );
}