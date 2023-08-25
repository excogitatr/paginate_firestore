import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class RefreshIndicatorWidget extends StatefulWidget {
  final CustomRefresher customRefresher;
  final Widget child;

  const RefreshIndicatorWidget(
      {Key? key, required this.customRefresher, required this.child,}) : super(key: key);

  @override
  State<RefreshIndicatorWidget> createState() => _RefreshIndicatorWidgetState();
}

class _RefreshIndicatorWidgetState extends State<RefreshIndicatorWidget> {
  @override
  Widget build(BuildContext context) {
    return NotificationListener(
      onNotification: (value) {
        return false;
      },
      child: SmartRefresher(
        footer: widget.customRefresher.footer,
        enablePullUp: false,
        enablePullDown: true,
        physics: widget.customRefresher.physics ?? const ScrollPhysics(),
        enableTwoLevel: true,
        header: widget.customRefresher.header ??
            const WaterDropHeader(
              waterDropColor: Colors.transparent,
              idleIcon: SizedBox(
                  width: 30, height: 30, child: CircularProgressIndicator()),
            ),
        controller: widget.customRefresher.refreshController!,
        scrollController: widget.customRefresher.scrollController,
        onRefresh: widget.customRefresher.onRefresh,
        child: widget.child,
      ),
    );
  }
}

class CustomRefresher {
  final Future<void> Function()? onRefresh;
  final ScrollController? scrollController;
  final RefreshController? refreshController;
  final ScrollPhysics? physics;
  final bool? enablePullUp;
  final bool? enablePullDown;
  final bool? enableTwoLevel;
  final Widget? header;
  final Widget? footer;

  CustomRefresher({
    this.onRefresh,
    this.scrollController,
    this.refreshController,
    this.physics,
    this.enablePullUp,
    this.enablePullDown,
    this.enableTwoLevel,
    this.header,
    this.footer,
  });
}
