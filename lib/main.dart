import 'package:any_image_view/any_image_view.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_empty/common.dart';
import 'package:flutter_empty/extensions/context_extension.dart';
import 'package:flutter_empty/extensions/int_extension.dart';
import 'package:flutter_empty/native_channel.dart';
import 'package:flutter_empty/network/net.dart';
import 'package:flutter_empty/ui/main/home_page.dart';
import 'package:flutter_empty/ui/web/web_page.dart';
import 'package:flutter_empty/utils/preference.dart';
import 'package:flutter_empty/widgets/ImageView.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:lifecycle/lifecycle.dart';

Future<void> main() async {
  var widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Preference.init();
  NativeChannel.init();
  final webUserAgent = await InAppWebViewController.getDefaultUserAgent();
  Net.init(webUserAgent);
  // webview debug toggle
  await InAppWebViewController.setWebContentsDebuggingEnabled(false);
  runApp(const MyApp());
}

final routes = {
  "/": (context) => const Application(),
  "main": (context) => const Homepage(),
  "web_page": (context) => WebPage(),
};

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static final botToastBuilder = BotToastInit();
  static late BuildContext _context;

  static BuildContext get appContext => _context;

  static final BotToastNavigatorObserver _botToastNavigatorObserver = BotToastNavigatorObserver();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    _context = context;
    return CupertinoApp(
      title: appName,
      debugShowCheckedModeBanner: kDebugMode,
      navigatorObservers: [defaultLifecycleObserver, _botToastNavigatorObserver],
      routes: routes,
      initialRoute: '/',
      localizationsDelegates: const [
        DefaultMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      theme: const CupertinoThemeData(
        brightness: Brightness.light,
        scaffoldBackgroundColor: Colors.white,
        textTheme: CupertinoTextThemeData(primaryColor: Colors.black),
      ),
      builder: botToastBuilder,
    );
  }
}

class Application extends StatefulWidget {
  const Application({super.key});

  @override
  State<Application> createState() => _ApplicationState();
}

class _ApplicationState extends State<Application> {
  @override
  void initState() {
    super.initState();
    // SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    //   statusBarColor: Colors.transparent,
    // ));
    // 等首帧渲染完成、导航器解锁后再跳转，避免在 initState 阶段
    // 直接 push 触发 '!navigator._debugLocked' 断言失败
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        context.pushPageReplaceNoAnim("main");
        FlutterNativeSplash.remove();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(color: Colors.white);
  }
}
