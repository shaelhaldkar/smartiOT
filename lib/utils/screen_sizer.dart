import 'package:flutter/material.dart';

class RSize {
  static late double w;
  static late double h;
  static late double sp;

  static init(BuildContext context) {
    final mq = MediaQuery.of(context);
    w = mq.size.width;
    h = mq.size.height;
    sp = mq.textScaleFactor;
  }

  static double rw(double v) => w * (v / 375);
  static double rh(double v) => h * (v / 812);
  static double rs(double v) => v * sp;
}
