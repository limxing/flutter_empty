import 'package:flutter/cupertino.dart';

T? runCatching<T>(ValueGetter<T?> callback) {
  try {
    return callback();
  } catch (e) {
    return null;
  }
}