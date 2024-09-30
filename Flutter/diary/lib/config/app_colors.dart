import 'package:flutter/material.dart';

class AppColors{

  //메인 배경색깔
  static const basicColor = Color(0xfffcf0e0);
  //메인보다 조금 더 진한색
  static const moreBasicColor = Color(0xfffbdcb4);


  //colorMap(테이블 저장 color -> Colors로 변경)
  Map<String, Color> colorMap = {
    'red' : Colors.red,
    'orange' : Colors.orange,
    'yellow' : Colors.yellow,
    'green' : Colors.green,
    'blue' : Colors.blue,
    'purple' : Colors.purple,
    'brown' : Colors.brown,
    'grey' : Colors.grey,
  };

}


MaterialColor getMaterialColor(Color color) {
  final int red = color.red;
  final int green = color.green;
  final int blue = color.blue;

  final Map<int, Color> shades = {
    50: Color.fromRGBO(red, green, blue, .1),
    100: Color.fromRGBO(red, green, blue, .2),
    200: Color.fromRGBO(red, green, blue, .3),
    300: Color.fromRGBO(red, green, blue, .4),
    400: Color.fromRGBO(red, green, blue, .5),
    500: Color.fromRGBO(red, green, blue, .6),
    600: Color.fromRGBO(red, green, blue, .7),
    700: Color.fromRGBO(red, green, blue, .8),
    800: Color.fromRGBO(red, green, blue, .9),
    900: Color.fromRGBO(red, green, blue, 1),
  };

  return MaterialColor(color.value, shades);
}