import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppLoader extends StatelessWidget {
  final double size;
  final Color color;

  const AppLoader({
    this.size = 30,
    this.color = Colors.green,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size,
      width: size,
      child: CupertinoActivityIndicator(
        color: color,
        radius: size / 2,
      ),
    );
  }
}
