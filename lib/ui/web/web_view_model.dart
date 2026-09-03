import 'package:flutter/cupertino.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:mobx/mobx.dart';

import '../../extensions/obj_extension.dart';

part 'web_view_model.g.dart';

class WebViewModel = WebViewModelBase with _$WebViewModel;

abstract class WebViewModelBase with Store {
  InAppWebViewController? webController;
  static const _webJavaObjName = "flutter";

  //标题
  @observable
  var webTitle = "";

  //是否能够网页回退
  @observable
  var webCanGoback = false;

  //网页加载进度
  @observable
  var webProgress = 0.0;

  //页面开始加载
  void webOnLoadStart(InAppWebViewController controller, WebUri? url) async {
    controller.canGoBack().then((back) {
      webCanGoback = back;
    });
  }

  //页面停止加载
  void webOnLoadStop(InAppWebViewController controller, WebUri? url) {}

  //页面加载进度
  void webOnProgress(InAppWebViewController controller, int pro) {
    webProgress = pro / 100.0;
  }

  //允许加载的页面scheme
  final allowedScheme = ["http", "https"];

  //拦截页面请求
  Future<NavigationActionPolicy> webShouldLoading(
    InAppWebViewController controller,
    NavigationAction navigationAction,
  ) async {
    if (allowedScheme.contains(navigationAction.request.url?.scheme)) {
      return NavigationActionPolicy.ALLOW;
    }
    return NavigationActionPolicy.CANCEL;
  }

  //网页组件创建完成
  void webOnCreated(InAppWebViewController controller) {
    webController = controller;
    controller.addJavaScriptHandler(
      handlerName: _webJavaObjName,
      callback: (arguments) => _webCallApp(Map<String, dynamic>.from(arguments.first)),
    );
  }

  // JavaScript 注入回调
  void _webCallApp(Map<String, dynamic> map) {}

  //点击返回
  void webBack(BuildContext context) {
    if (webCanGoback) {
      webController?.goBack();
    } else {
      Navigator.of(context).pop();
    }
  }

  //释放资源
  void disposed() {
    webController = null;
  }
}
