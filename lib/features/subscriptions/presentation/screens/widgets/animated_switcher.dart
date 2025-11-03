import 'package:ahiaa_web/core/common/widgets/texts/fitted_texts.dart';
import 'package:ahiaa_web/core/utils/constants/colors.dart';
import 'package:flutter/material.dart';

// Model for toggle option
class ToggleOption {
  final String label;
  final dynamic value;
  final IconData? icon;

  const ToggleOption({
    required this.label,
    required this.value,
    this.icon,
  });
}

// Main Toggle Switch Widget
class AnimatedToggleSwitch extends StatefulWidget {
  final List<ToggleOption> options;
  final dynamic selectedValue;
  final ValueChanged<dynamic> onChanged;
  final Color selectedColor;
  final Color unselectedColor;
  final Color selectedTextColor;
  final Color unselectedTextColor;
  final double height;
  final EdgeInsets padding;
  final Duration animationDuration;
  final Curve animationCurve;
  final double borderRadius;
  final TextStyle? textStyle;

  const AnimatedToggleSwitch({
    super.key,
    required this.options,
    required this.selectedValue,
    required this.onChanged,
    this.selectedColor = const Color(0xFF1F1F1F),
    this.unselectedColor = const Color(0xFFE8E4F3),
    this.selectedTextColor = Colors.white,
    this.unselectedTextColor = PColors.deepBlack,
    this.height = 48,
    this.padding = const EdgeInsets.all(4),
    this.animationDuration = const Duration(milliseconds: 300),
    this.animationCurve = Curves.easeInOutCubic,
    this.borderRadius = 24,
    this.textStyle,
  }) : assert(options.length >= 2, 'Must have at least 2 options');

  @override
  State<AnimatedToggleSwitch> createState() => _AnimatedToggleSwitchState();
}

class _AnimatedToggleSwitchState extends State<AnimatedToggleSwitch> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      decoration: BoxDecoration(
        color: widget.unselectedColor,
        borderRadius: BorderRadius.circular(widget.borderRadius),
      ),
      padding: widget.padding,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final itemWidth = constraints.maxWidth / widget.options.length;
          final selectedIndex = widget.options.indexWhere(
            (option) => option.value == widget.selectedValue,
          );
          debugPrint(selectedIndex.toString());
          return Stack(
            children: [
              // Animated sliding background
              AnimatedPositioned(
                duration: widget.animationDuration,
                curve: widget.animationCurve,
                left: selectedIndex  * itemWidth,
                top: 0,
                bottom: 0,
                width: itemWidth,
                child: Container(
                  decoration: BoxDecoration(
                    color: widget.selectedColor,
                    borderRadius: BorderRadius.circular(
                      widget.borderRadius - widget.padding.horizontal / 2,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                ),
              ),
              // Toggle options
              Row(
                children: widget.options.asMap().entries.map((entry) {
                  final index = entry.key;
                  final option = entry.value;
                  final isSelected = widget.selectedValue == option.value;

                  return Expanded(
                    child: _ToggleOptionButton(
                      option: option,
                      isSelected: isSelected,
                      selectedTextColor: widget.selectedTextColor,
                      unselectedTextColor: widget.unselectedTextColor,
                      textStyle: widget.textStyle,
                      animationDuration: widget.animationDuration,
                      onTap: () => widget.onChanged(option.value),
                    ),
                  );
                }).toList(),
              ),
            ],
          );
        },
      ),
    );
  }
}

// Individual toggle option button (composable)
class _ToggleOptionButton extends StatelessWidget {
  final ToggleOption option;
  final bool isSelected;
  final Color selectedTextColor;
  final Color unselectedTextColor;
  final TextStyle? textStyle;
  final Duration animationDuration;
  final VoidCallback onTap;

  const _ToggleOptionButton({
    required this.option,
    required this.isSelected,
    required this.selectedTextColor,
    required this.unselectedTextColor,
    required this.textStyle,
    required this.animationDuration,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: Center(
          child: AnimatedDefaultTextStyle(
            duration: animationDuration,
            style: (textStyle ?? const TextStyle()).copyWith(
              color: isSelected ? selectedTextColor : unselectedTextColor,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
              fontSize: textStyle?.fontSize ?? 14,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (option.icon != null) ...[
                  Icon(
                    option.icon,
                    size: 16,
                    color: isSelected ? selectedTextColor : unselectedTextColor,
                  ),
                  const SizedBox(width: 6),
                ],
                ResponsiveText(option.label).withSize(10).bold.withLetterSpacing(0.9),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Builder pattern for easy configuration
class ToggleSwitchBuilder {
  List<ToggleOption> _options = [];
  dynamic _selectedValue;
  ValueChanged<dynamic>? _onChanged;
  Color _selectedColor = const Color(0xFF1F1F1F);
  Color _unselectedColor = const Color(0xFFE8E4F3);
  Color _selectedTextColor = Colors.white;
  Color _unselectedTextColor = const Color(0xFF666666);
  double _height = 48;
  EdgeInsets _padding = const EdgeInsets.all(4);
  Duration _animationDuration = const Duration(milliseconds: 300);
  Curve _animationCurve = Curves.easeInOutCubic;
  double _borderRadius = 24;
  TextStyle? _textStyle;

  ToggleSwitchBuilder withOptions(List<ToggleOption> options) {
    _options = options;
    return this;
  }

  ToggleSwitchBuilder withSelectedValue(dynamic value) {
    _selectedValue = value;
    return this;
  }

  ToggleSwitchBuilder withOnChanged(ValueChanged<dynamic> callback) {
    _onChanged = callback;
    return this;
  }

  ToggleSwitchBuilder withColors({
    Color? selectedColor,
    Color? unselectedColor,
    Color? selectedTextColor,
    Color? unselectedTextColor,
  }) {
    if (selectedColor != null) _selectedColor = selectedColor;
    if (unselectedColor != null) _unselectedColor = unselectedColor;
    if (selectedTextColor != null) _selectedTextColor = selectedTextColor;
    if (unselectedTextColor != null) _unselectedTextColor = unselectedTextColor;
    return this;
  }

  ToggleSwitchBuilder withHeight(double height) {
    _height = height;
    return this;
  }

  ToggleSwitchBuilder withPadding(EdgeInsets padding) {
    _padding = padding;
    return this;
  }

  ToggleSwitchBuilder withAnimation({
    Duration? duration,
    Curve? curve,
  }) {
    if (duration != null) _animationDuration = duration;
    if (curve != null) _animationCurve = curve;
    return this;
  }

  ToggleSwitchBuilder withBorderRadius(double radius) {
    _borderRadius = radius;
    return this;
  }

  ToggleSwitchBuilder withTextStyle(TextStyle style) {
    _textStyle = style;
    return this;
  }

  Widget build() {
    assert(_options.isNotEmpty, 'Options must be provided');
    assert(_onChanged != null, 'onChanged callback must be provided');

    return AnimatedToggleSwitch(
      options: _options,
      selectedValue: _selectedValue,
      onChanged: _onChanged!,
      selectedColor: _selectedColor,
      unselectedColor: _unselectedColor,
      selectedTextColor: _selectedTextColor,
      unselectedTextColor: _unselectedTextColor,
      height: _height,
      padding: _padding,
      animationDuration: _animationDuration,
      animationCurve: _animationCurve,
      borderRadius: _borderRadius,
      textStyle: _textStyle,
    );
  }
}

// Example Usage
class ToggleSwitchExample extends StatefulWidget {
  const ToggleSwitchExample({Key? key}) : super(key: key);

  @override
  State<ToggleSwitchExample> createState() => _ToggleSwitchExampleState();
}

class _ToggleSwitchExampleState extends State<ToggleSwitchExample> {
  String billingPeriod = 'yearly';
  String viewMode = 'grid';
  String timePeriod = 'week';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Billing toggle (like your design)
            AnimatedToggleSwitch(
              options: const [
                ToggleOption(label: 'Yearly Billing', value: 'yearly'),
                ToggleOption(label: 'Monthly Billing', value: 'monthly'),
              ],
              selectedValue: billingPeriod,
              onChanged: (value) {
                setState(() {
                  billingPeriod = value;
                  print('Billing changed to: $value');
                });
              },
            ),

            const SizedBox(height: 32),

            // Example with icons
            AnimatedToggleSwitch(
              options: const [
                ToggleOption(
                    label: 'Grid', value: 'grid', icon: Icons.grid_view),
                ToggleOption(label: 'List', value: 'list', icon: Icons.list),
              ],
              selectedValue: viewMode,
              onChanged: (value) {
                setState(() {
                  viewMode = value;
                  print('View mode changed to: $value');
                });
              },
            ),

            const SizedBox(height: 32),

            // Example using builder pattern
            ToggleSwitchBuilder()
                .withOptions(const [
                  ToggleOption(label: 'Day', value: 'day'),
                  ToggleOption(label: 'Week', value: 'week'),
                  ToggleOption(label: 'Month', value: 'month'),
                ])
                .withSelectedValue(timePeriod)
                .withOnChanged((value) {
                  setState(() {
                    timePeriod = value;
                    print('Time period changed to: $value');
                  });
                })
                .withColors(
                  selectedColor: const Color(0xFF4A90E2),
                  unselectedColor: const Color(0xFFE3F2FD),
                )
                .withAnimation(
                  duration: const Duration(milliseconds: 400),
                  curve: Curves.elasticOut,
                )
                .build(),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: ToggleSwitchExample(),
  ));
}
