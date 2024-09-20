import 'package:flutter/material.dart';


class AppLogo extends StatelessWidget {
  double width;

  AppLogo({
    this.width = 70
  });

  @override
  Widget build(BuildContext context) {
    return Image.asset('asset/images/applelogo.jpg', width: width,);
  }
}
