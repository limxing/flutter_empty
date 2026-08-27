import 'package:flutter/material.dart';

///颜色 hex颜色
class HexColor extends Color {
  HexColor(String hexColor) : super(HexColor._parse(hexColor));

  static int _parse(String hexColor) {
    if (hexColor.isEmpty) return Colors.white.value;
    if (hexColor.length != 7 && hexColor.length != 9) {
      throw Exception("HexColor is $hexColor but HexColor's length mast be 7 or 9");
    }
    if (hexColor.length == 7) {
      return int.parse(hexColor.replaceFirst("#", "0xff"));
    } else {
      return int.parse(hexColor.replaceFirst("#", "0x"));
    }
  }

  static Color parse(String hexColor) {
    if (hexColor.isEmpty) return Colors.white;
    if (hexColor.length != 7 && hexColor.length != 9) {
      throw Exception("HexColor is $hexColor but HexColor's length mast be 7 or 9");
    }
    if (hexColor.length == 7) {
      return Color(int.parse(hexColor.replaceFirst("#", "0xff")));
    } else {
      return Color(int.parse(hexColor.replaceFirst("#", "0x")));
    }
  }
}
