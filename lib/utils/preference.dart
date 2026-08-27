import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../extensions/kotlin_func.dart';

///kv配置
class Preference {
  static SharedPreferences? sp;

  //在程序入口初始化
  static Future<void> init() async {
    WidgetsFlutterBinding.ensureInitialized();
    sp = await SharedPreferences.getInstance();
  }

  static String getString(SKey key, {String defaultValue = ""}) {
    return sp?.getString(key.key) ?? defaultValue;
  }
  static String getStringWithKey(String key, {String defaultValue = ""}) {
    return sp?.getString(key) ?? defaultValue;
  }

  static List<String> getList(SKey key) {
    return sp?.getStringList(key.key) ?? List<String>.empty();
  }

  static saveString({required SKey key, required String value}) {
    sp?.setString(key.key, value);
  }
  static saveStringWithKey({required String key, required String value}) {
    sp?.setString(key, value);
  }

  static removeKey(SKey key) {
    sp?.remove(key.key);
  }
  static removeKeyString(String key) {
    sp?.remove(key);
  }

  static bool containsKey(SKey<dynamic> sKey) {
    return sp?.containsKey(sKey.key) ?? false;
  }
}

typedef SKeyT<T> = T? Function(Map<String, dynamic>);

class SKey<T> {
  Type _typeOf<T>() => T;
  String key;

  String? _type;

  SKeyT<T>? valueFromJson;

  SKey(this.key, {T? value, this.valueFromJson}) {
    _type = _typeOf<T>().toString();
    _value = getValue() ?? value;
  }

  T? _value;

  T? getValue() {
    _value ??= (_type == 'String'
        ? Preference.sp?.getString(key)
        : _type == 'int'
            ? Preference.sp?.getInt(key)
            : _type == 'bool'
                ? Preference.sp?.getBool(key)
                : _type == 'double'
                    ? Preference.sp?.getDouble(key)
                    : _type == 'List<String>'
                        ? Preference.sp?.getStringList(key)
                        : containsKey
                            ? runCatching(() => valueFromJson?.call(jsonDecode(Preference.sp?.getString(key) ?? "")))
                            : null) as T?;
    return _value;
  }

  void setValue(T? v) {
    _value = v;
    if (v == null) {
      Preference.sp?.remove(key);
    } else {
      v is String
          ? Preference.sp?.setString(key, v)
          : v is int
              ? Preference.sp?.setInt(key, v)
              : v is bool
                  ? Preference.sp?.setBool(key, v)
                  : v is double
                      ? Preference.sp?.setDouble(key, v)
                      : v is List<String>
                          ? Preference.sp?.setStringList(key, v)
                          : Preference.sp?.setString(key, jsonEncode(v));
    }
  }
}

extension KeyExtension on SKey {
  String get string => Preference.getString(this);

  List<String> get stringList => Preference.getList(this);

  bool get containsKey => Preference.containsKey(this);

  void saveList(List<String> value) => Preference.sp?.setStringList(key, value);

  void remove() => Preference.sp?.remove(key);

  void saveString(String value) => Preference.sp?.setString(key, value);
}
