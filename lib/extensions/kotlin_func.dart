import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

T? runCatching<T>(ValueGetter<T?> callback) {
  try {
    return callback();
  } catch (e) {
    if(kDebugMode){
      print(e);
    }
    return null;
  }
}