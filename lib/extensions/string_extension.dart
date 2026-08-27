import 'dart:convert';
import 'package:bot_toast/bot_toast.dart';
import 'package:crypto/crypto.dart' as crypto;
import 'package:flutter/material.dart';
import 'package:flutter_empty/extensions/hex_color.dart';

extension StringExtension on String {
  String get toast {
    if (isEmpty) return "";
    BotToast.showText(
        text: this,
        textStyle: const TextStyle(fontSize: 16, color: Colors.white),
        contentColor: Colors.black87,
        align: Alignment.center,
        contentPadding: const EdgeInsets.only(top: 6, left: 10, right: 10, bottom: 6));
    return this;
  }

  String get md5 => crypto.md5.convert(utf8.encode(this)).toString();

  Color get hexColor => HexColor.parse(this);
}