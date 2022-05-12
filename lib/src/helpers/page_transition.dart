import 'package:flutter/material.dart';

class PageTransition extends PageRouteBuilder {
  PageTransition({required this.child})
      : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> anotherAnimation,
          ) => child,
          transitionDuration: const Duration(seconds: 2),
          transitionsBuilder: (BuildContext context,
              Animation<double> animation,
              Animation<double> anotherAnimation,
              child2) {
            animation = CurvedAnimation(
              parent: animation,
              curve: Curves.fastLinearToSlowEaseIn,
            );
            return Align(
              alignment: Alignment.bottomCenter,
              child: SizeTransition(
                sizeFactor: animation,
                child: child2,
                axisAlignment: 0,
              ),
            );
          },
        );

  final Widget child;
}
