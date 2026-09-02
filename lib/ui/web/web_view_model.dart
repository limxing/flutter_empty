import 'package:flutter/cupertino.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:mobx/mobx.dart';

import '../../extensions/obj_extension.dart';

part 'web_view_model.g.dart';

class WebViewModel = WebViewModelBase with _$WebViewModel;

abstract class WebViewModelBase with Store {
  InAppWebViewController? webController;
  static const _webJavaObjName = "flutter";
  @observable
  var webTitle = "";

  @observable
  var webCanGoback = false;

  @observable
  var webProgress = 0.0;

  void webOnLoadStart(InAppWebViewController controller, WebUri? url) async {
    controller.canGoBack().then((back) {
      webCanGoback = back;
    });
  }

  void webOnLoadStop(InAppWebViewController controller, WebUri? url) {}

  void webOnProgress(InAppWebViewController controller, int pro) {
    webProgress = pro / 100.0;
  }

  Future<NavigationActionPolicy> webShouldLoading(
    InAppWebViewController controller,
    NavigationAction navigationAction,
  ) async {
    return NavigationActionPolicy.ALLOW;
  }

  void webOnCreated(InAppWebViewController controller) {
    webController = controller;
    controller.addJavaScriptHandler(
      handlerName: _webJavaObjName,
      callback: (arguments) => _webCallApp(Map<String, dynamic>.from(arguments.first)),
    );
  }

  // JavaScript 注入回调
  void _webCallApp(Map<String, dynamic> map) {}

  void webBack(BuildContext context) {
    if (webCanGoback) {
      webController?.goBack();
    } else {
      Navigator.of(context).pop();
    }
  }

  void disposed() {
    webController = null;
  }
}
