

import 'dart:io';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter_empty/main.dart';
import 'package:logger/logger.dart';

const appName = "Demo";
final logger = Logger();
typedef FutureFunction = Future<dynamic> Function();

double get devicePixelRatio => View.of(MyApp.appContext).devicePixelRatio;

double get statusBarHeight => View.of(MyApp.appContext).padding.top / devicePixelRatio;

double get navBarHeight => View.of(MyApp.appContext).padding.bottom / devicePixelRatio;

double get screenWidth => View.of(MyApp.appContext).physicalSize.width / devicePixelRatio;

double get screenHeight => View.of(MyApp.appContext).physicalSize.height / devicePixelRatio;

double get statusAndNavbarHeight => kMinInteractiveDimensionCupertino + statusBarHeight;

bool get isAndroid => Platform.isAndroid;

bool get isIOS => Platform.isIOS;

double get minScreen => min(screenWidth, screenHeight);

bool get isPad => minScreen >= 500;