import 'package:flutter/material.dart';

enum DropdownPosition {
  bottom,
  top,
  left,
  right,
  topLeft,
  topCenter,
  topRight,
  bottomLeft,
  bottomCenter,
  bottomRight,
  auto, // New: automatically determines best position
}

class CustomDropdownMenu extends StatefulWidget {
  final Widget trigger;
  final List<Widget> items;
  final double offset;
  final double width;
  final Color backgroundColor;
  final BorderRadius borderRadius;
  final DropdownPosition position;
  final Duration animationDuration;
  final double? height, maxHeight, spacing;
  final bool transparent;
  final double screenEdgePadding; // Minimum distance from screen edges
  
  const CustomDropdownMenu({
    super.key,
    required this.trigger,
    required this.items,
    this.offset = 8.0,
    this.width = 200,
    this.height,
    this.transparent = false,
    this.maxHeight,
    this.spacing,
    this.backgroundColor = const Color(0xAA000000),
    this.borderRadius = const BorderRadius.all(Radius.circular(16)),
    this.position = DropdownPosition.auto, // Default to auto
    this.animationDuration = const Duration(milliseconds: 200),
    this.screenEdgePadding = 16.0, // Default padding from screen edges
  });

  @override
  State<CustomDropdownMenu> createState() => CustomDropdownMenuState();
}

class CustomDropdownMenuState extends State<CustomDropdownMenu>
    with SingleTickerProviderStateMixin {
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;
  bool _isOpen = false;
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;
  DropdownPosition? _calculatedPosition;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: widget.animationDuration,
    );
    _scaleAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutBack,
    );
    _fadeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeIn,
    );
  }

  void toggle() {
    if (!mounted) return;
    if (_isOpen) {
      _closeDropdown();
    } else {
      _showDropdown();
    }
  }

  void show() {
    if (!_isOpen) _showDropdown();
  }

  void hide() {
    if (_isOpen) _closeDropdown();
  }

  void _toggleDropdown() {
    if (_isOpen) {
      _closeDropdown();
    } else {
      _showDropdown();
    }
  }

  void _showDropdown() {
    _overlayEntry = _buildOverlayEntry();
    Overlay.of(context).insert(_overlayEntry!);
    _animationController.forward();
    _isOpen = true;
  }

  void _closeDropdown() {
    _animationController.reverse().then((_) {
      if (mounted && _overlayEntry?.mounted == true) {
        _overlayEntry?.remove();
      }
      _isOpen = false;
      _calculatedPosition = null;
    });
  }

  /// Calculate the best position for the dropdown based on available space
  DropdownPosition _calculateBestPosition(
    Size triggerSize,
    Offset triggerPosition,
    Size screenSize,
  ) {
    final dropdownHeight = widget.height ?? widget.maxHeight ?? 200;
    final dropdownWidth = widget.width;
    final padding = widget.screenEdgePadding;
    final offset = widget.offset;

    // Calculate available space in each direction
    final spaceAbove = triggerPosition.dy - padding;
    final spaceBelow = screenSize.height - triggerPosition.dy - triggerSize.height - padding;
    final spaceLeft = triggerPosition.dx - padding;
    final spaceRight = screenSize.width - triggerPosition.dx - triggerSize.width - padding;

    // If position is explicitly set (not auto), return it
    if (widget.position != DropdownPosition.auto) {
      return widget.position;
    }

    // Determine vertical position (top or bottom)
    final preferBottom = spaceBelow >= dropdownHeight + offset;
    final preferTop = spaceAbove >= dropdownHeight + offset;

    // Determine horizontal alignment
    final canCenterHorizontally = 
      triggerPosition.dx + (triggerSize.width - dropdownWidth) / 2 >= padding &&
      triggerPosition.dx + (triggerSize.width + dropdownWidth) / 2 <= screenSize.width - padding;
    
    final canAlignLeft = triggerPosition.dx + dropdownWidth <= screenSize.width - padding;
    final canAlignRight = triggerPosition.dx + triggerSize.width - dropdownWidth >= padding;

    // Decision logic
    if (preferBottom) {
      // Try bottom positions
      if (canCenterHorizontally) {
        return DropdownPosition.bottomCenter;
      } else if (canAlignLeft) {
        return DropdownPosition.bottomLeft;
      } else if (canAlignRight) {
        return DropdownPosition.bottomRight;
      }
      return DropdownPosition.bottom;
    } else if (preferTop) {
      // Try top positions
      if (canCenterHorizontally) {
        return DropdownPosition.topCenter;
      } else if (canAlignLeft) {
        return DropdownPosition.topLeft;
      } else if (canAlignRight) {
        return DropdownPosition.topRight;
      }
      return DropdownPosition.top;
    } else {
      // Not enough space vertically, try horizontal
      if (spaceRight >= dropdownWidth + offset) {
        return DropdownPosition.right;
      } else if (spaceLeft >= dropdownWidth + offset) {
        return DropdownPosition.left;
      }
      // Fallback: use bottom even if constrained
      return DropdownPosition.bottomCenter;
    }
  }

  Offset _getOffset(Size triggerSize, DropdownPosition position) {
    final dropdownHeight = widget.height ?? widget.maxHeight ?? 200;
    
    switch (position) {
      case DropdownPosition.top:
        return Offset(0, -widget.offset - dropdownHeight);
      case DropdownPosition.left:
        return Offset(-widget.width - widget.offset, 0);
      case DropdownPosition.right:
        return Offset(triggerSize.width + widget.offset, 0);
      case DropdownPosition.bottom:
        return Offset(0, triggerSize.height + widget.offset);
      case DropdownPosition.topLeft:
        return Offset(0, -widget.offset - dropdownHeight);
      case DropdownPosition.topCenter:
        return Offset(
          (triggerSize.width - widget.width) / 2,
          -widget.offset - dropdownHeight,
        );
      case DropdownPosition.topRight:
        return Offset(
          triggerSize.width - widget.width,
          -widget.offset - dropdownHeight,
        );
      case DropdownPosition.bottomLeft:
        return Offset(0, triggerSize.height + widget.offset);
      case DropdownPosition.bottomCenter:
        return Offset(
          (triggerSize.width - widget.width) / 2,
          triggerSize.height + widget.offset,
        );
      case DropdownPosition.bottomRight:
        return Offset(
          triggerSize.width - widget.width,
          triggerSize.height + widget.offset,
        );
      case DropdownPosition.auto:
        return Offset(0, triggerSize.height + widget.offset);
    }
  }

  Alignment _getAlignment(DropdownPosition position) {
    switch (position) {
      case DropdownPosition.top:
      case DropdownPosition.topLeft:
      case DropdownPosition.topCenter:
      case DropdownPosition.topRight:
        return Alignment.bottomCenter;
      case DropdownPosition.bottom:
      case DropdownPosition.bottomLeft:
      case DropdownPosition.bottomCenter:
      case DropdownPosition.bottomRight:
        return Alignment.topCenter;
      case DropdownPosition.left:
        return Alignment.centerRight;
      case DropdownPosition.right:
        return Alignment.centerLeft;
      case DropdownPosition.auto:
        return Alignment.topCenter;
    }
  }

  OverlayEntry _buildOverlayEntry() {
    RenderBox renderBox = context.findRenderObject() as RenderBox;
    Size triggerSize = renderBox.size;
    Offset triggerPosition = renderBox.localToGlobal(Offset.zero);
    Size screenSize = MediaQuery.of(context).size;

    // Calculate the best position
    _calculatedPosition = _calculateBestPosition(
      triggerSize,
      triggerPosition,
      screenSize,
    );

    return OverlayEntry(
      builder: (context) => MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: _closeDropdown,
          behavior: HitTestBehavior.translucent,
          child: Stack(
            children: [
              Positioned(
                child: CompositedTransformFollower(
                  link: _layerLink,
                  offset: _getOffset(triggerSize, _calculatedPosition!),
                  showWhenUnlinked: false,
                  child: Material(
                    color: Colors.transparent,
                    child: FadeTransition(
                      opacity: _fadeAnimation,
                      child: ScaleTransition(
                        scale: _scaleAnimation,
                        alignment: _getAlignment(_calculatedPosition!),
                        child: Container(
                          width: widget.width,
                          constraints: BoxConstraints(
                            minHeight: widget.height ?? 0,
                            maxHeight: widget.maxHeight ?? 400,
                          ),
                          decoration: BoxDecoration(
                            color: widget.backgroundColor,
                            borderRadius: widget.borderRadius,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.3),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: widget.borderRadius,
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: widget.items,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    if (_isOpen && _overlayEntry?.mounted == true) {
      _overlayEntry?.remove();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: GestureDetector(onTap: _toggleDropdown, child: widget.trigger),
    );
  }
}
