import 'package:flutter/material.dart';

Route createFadeRoute(Widget page) => PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = .0;
        const end = 1.0;
        const curve = Curves.ease;

        final tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return FadeTransition(
          opacity: animation.drive(tween),
          child: child,
        );
      },
    );

MaterialPageRoute createMaterialPageRoute(Widget page) =>
    MaterialPageRoute(builder: (context) => page);
