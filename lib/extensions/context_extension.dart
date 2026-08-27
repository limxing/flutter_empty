
import 'package:flutter/cupertino.dart';

extension ContextExtension on BuildContext {

  Future pushPageString(String pageName, {Object? arguments}) {
    return Navigator.of(this).pushNamed(pageName, arguments: arguments);
  }

  Future pushPageReplace(String pageName, {Object? arguments}) {
    return Navigator.of(this).pushReplacementNamed(pageName, arguments: arguments);
  }

  /// 无动画替换当前页面（pushReplacement 的无动画变体），支持命名路由及可选参数
  Future pushPageReplaceNoAnim(String pageName, {Object? arguments}) {
    final NavigatorState navigator = Navigator.of(this);
    final RouteSettings settings = RouteSettings(name: pageName, arguments: arguments);
    // 通过 onGenerateRoute 与 onUnknownRoute 解析命名路由对应的页面，
    // 兼容 routes map 与 onGenerateRoute 两种注册方式
    Route<Object?>? namedRoute = navigator.widget.onGenerateRoute?.call(settings);
    if (namedRoute == null && navigator.widget.onUnknownRoute != null) {
      namedRoute = navigator.widget.onUnknownRoute!.call(settings);
    }
    // CupertinoPageRoute 是 CupertinoApp 命名路由的标准产物，取其页面构造方法
    if (namedRoute is! CupertinoPageRoute) {
      return Future.value();
    }
    final Widget Function(BuildContext) pageBuilder = namedRoute.builder;
    return navigator.pushReplacement(
      PageRouteBuilder(
        settings: settings,
        transitionDuration: Duration.zero,
        reverseTransitionDuration: Duration.zero,
        pageBuilder: (_, _, _) => pageBuilder(this),
      ),
    );
  }
  void pop<T>({T? result}) {
    Navigator.pop(this, result);
  }

  Map<String, dynamic>? get arguments => ModalRoute.of(this)?.settings.arguments as Map<String, dynamic>?;

  dynamic get argumentObj => ModalRoute.of(this)?.settings.arguments;
}