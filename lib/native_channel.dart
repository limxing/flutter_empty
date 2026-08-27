import 'package:flutter/services.dart';

//与native通讯
class NativeChannel {
  static final _channel = const MethodChannel('channel/abc_flutter');
  static void init(){
    _channel.setMethodCallHandler((call){
      switch(call.method){
        case "":
          break;
      }
      return Future.value("");
    });
  }
}