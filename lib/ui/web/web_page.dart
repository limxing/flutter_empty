import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_empty/common.dart';
import 'package:flutter_empty/extensions/context_extension.dart';
import 'package:flutter_empty/ui/web/web_view_model.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

import '../../extensions/int_extension.dart';

/// 通用网页
class WebPage extends StatefulWidget {
  const WebPage({super.key});

  @override
  State<WebPage> createState() => _WebPageState();
}

class _WebPageState extends State<WebPage> {
  /// 进度到达该值即开始淡出（与 inappwebview 的 100 进度之间留出余量）
  static const _progressFadeThreshold = 0.98;

  final viewModel = WebViewModel();

  @override
  Widget build(BuildContext context) {
    final url = context.arguments?["url"] ?? "https://www.baidu.com";
    return Provider(
      builder: (context, child) => CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          border: Border(bottom: BorderSide(color: Colors.blueAccent)),
          backgroundColor: Colors.white,
          leading: GestureDetector(
            child: Container(
              color: Colors.white,
              child: Icon(CupertinoIcons.back, color: Colors.black87, size: 26.pt),
            ),
            onTap: () {
              viewModel.webBack(context);
            },
          ),
          middle: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 300.pt),
            child: Observer(
              builder: (context) => PopScope(
                canPop: !viewModel.webCanGoback,
                onPopInvokedWithResult: (canPop, re) {
                  if (!canPop) {
                    viewModel.webBack(context);
                  }
                },
                child: Text(
                  viewModel.webTitle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Colors.black, fontSize: 16.pt),
                ),
              ),
            ),
          ),
          trailing: Observer(
            builder: (context) => Visibility(
              visible: viewModel.webCanGoback,
              child: GestureDetector(
                child: Icon(Icons.close_rounded, color: Colors.black, size: 24.pt),
                onTap: () {
                  context.pop();
                },
              ),
            ),
          ),
        ),
        child: Stack(
          children: [
            InAppWebView(
              onTitleChanged: (controller, title) => viewModel.webTitle = title ?? "",
              initialUrlRequest: URLRequest(url: WebUri(url)),
              initialSettings: InAppWebViewSettings(
                javaScriptEnabled: true,
                mediaPlaybackRequiresUserGesture: false,
                useShouldOverrideUrlLoading: true,
                cacheEnabled: true,
                mixedContentMode: MixedContentMode.MIXED_CONTENT_COMPATIBILITY_MODE,
              ),
              onWebViewCreated: viewModel.webOnCreated,
              onLoadStart: viewModel.webOnLoadStart,
              onLoadStop: viewModel.webOnLoadStop,
              onProgressChanged: viewModel.webOnProgress,
              shouldOverrideUrlLoading: viewModel.webShouldLoading,
              // pullToRefreshController: PullToRefreshController(),
            ),
            Observer(
              builder: (context) {
                final progress = viewModel.webProgress.clamp(0.0, 1.0);
                return AnimatedOpacity(
                  // 加载接近完成时淡出，到 0 后指示器仍留在树中，避免瞬间消失
                  opacity: progress >= _progressFadeThreshold ? 0.0 : 1.0,
                  duration: const Duration(milliseconds: 450),
                  curve: Curves.easeInOut,
                  child: OverflowBox(
                    maxWidth: screenWidth + 4,
                    alignment: Alignment.topCenter,
                    child: TweenAnimationBuilder<double>(
                      // 只给 end，TweenAnimationBuilder 会从当前显示值平滑过渡到新值
                      tween: Tween<double>(end: progress),
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeOutCubic,
                      builder: (context, value, _) => LinearProgressIndicator(
                        value: value,
                        borderRadius: BorderRadius.circular(2),
                        backgroundColor: Colors.grey[200],
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      create: (BuildContext context) => viewModel,
    );
  }

  @override
  void dispose() {
    viewModel.disposed();
    super.dispose();
  }
}
