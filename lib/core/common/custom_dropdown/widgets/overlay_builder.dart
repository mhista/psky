
// ==================== OVERLAY BUILDER ====================

import 'package:flutter/material.dart';

class OverlayBuilder extends StatefulWidget {
  final Widget Function(Size, VoidCallback hide) overlay;
  final Widget Function(VoidCallback show) child;
  final OverlayPortalController? overlayPortalController;
  final Function(bool)? visibility;

  const OverlayBuilder({
    super.key,
    required this.overlay,
    required this.child,
    this.overlayPortalController,
    this.visibility,
  });

  @override
  OverlayBuilderState createState() => OverlayBuilderState();
}

class OverlayBuilderState extends State<OverlayBuilder> {
  late OverlayPortalController overlayController;

  @override
  void initState() {
    super.initState();
    overlayController = widget.overlayPortalController ?? OverlayPortalController();
  }

  void showOverlay() {
    overlayController.show();
    if (widget.visibility != null) widget.visibility!(true);
  }

  void hideOverlay() {
    overlayController.hide();
    if (widget.visibility != null) widget.visibility!(false);
  }

  @override
  Widget build(BuildContext context) {
    return OverlayPortal(
      controller: overlayController,
      overlayChildBuilder: (_) {
        final renderBox = context.findRenderObject() as RenderBox;
        final size = renderBox.size;
        return widget.overlay(size, hideOverlay);
      },
      child: widget.child(showOverlay),
    );
  }
}